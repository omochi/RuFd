//
//  FileDescriptor.swift
//  RuFd
//
//  Created by omochimetaru on 2017/03/31.
//
//

import Darwin
import RuPosixError

public class FileDescriptor : Equatable, Hashable {
    public init(fd: Int32, closeOnDeinit: Bool) {
        self.fd = fd
        self.closeOnDeinit = closeOnDeinit
        self.closed = false
    }

    deinit {
        if closeOnDeinit {
            try! close()
        }
    }

    public let fd: Int32
    public let closeOnDeinit: Bool
    public private(set) var closed: Bool

    public var hashValue: Int {
        return fd.hashValue
    }

    public func close() throws {
        if closed {
            return
        }
        let ret = Darwin.close(fd)
        guard ret == 0 else {
            throw PosixError(code: ret)
        }
        closed = true
    }

    public func read() throws -> [UInt8] {
        var data = [UInt8]()
        let chunkSize = 1024 * 8
        while true {
            let chunk = try read(size: chunkSize)
            data.append(contentsOf: chunk)
            if chunk.count < chunkSize {
                break
            }
        }
        return data
    }

    public func read(size: Int) throws -> [UInt8] {
        var chunk = Array<UInt8>(repeating: 0, count: size)
        let ret = Darwin.read(fd, &chunk, chunk.count)
        if ret == -1 {
            throw PosixError(code: errno)
        }
        return chunk
    }

    public func write(data: [UInt8]) throws {
        var totalWriteSize = 0
        while true {
            if totalWriteSize == data.count {
                break
            }
            let ret = data.withUnsafeBytes { dataPointer -> Int in
                let p = dataPointer.baseAddress! + totalWriteSize
                let size = data.count - totalWriteSize
                return Darwin.write(fd, p, size)
            }
            if ret == -1 {
                throw PosixError(code: errno)
            }
            totalWriteSize += ret
        }
    }

    public static let stdin: FileDescriptor = .of(STDIN_FILENO)
    public static let stdout: FileDescriptor = .of(STDOUT_FILENO)
    public static let stderr: FileDescriptor = .of(STDERR_FILENO)

    public static func of(_ fd: Int32) -> FileDescriptor {
        return FileDescriptor(fd: fd, closeOnDeinit: false)
    }

    public static func open(path: String, flag: OpenFlag,
                            mode: OpenMode = [.ru, .wu, .rg, .wg, .ro, .wo])
        throws -> FileDescriptor
    {
        let fd = Darwin.open(path, flag.rawValue, mode.rawValue)
        if fd == -1 {
            throw PosixError(code: errno)
        }
        return FileDescriptor(fd: fd, closeOnDeinit: true)
    }
}

public func == (lhs: FileDescriptor, rhs: FileDescriptor) -> Bool {
    return lhs.fd == rhs.fd
}

