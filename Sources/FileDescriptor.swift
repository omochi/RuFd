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

    public func read(buffer: UnsafeMutableRawPointer, size: Int) throws -> Int {
        let ret = Darwin.read(fd, buffer, size)
        if ret == -1 { throw PosixError(code: errno) }
        return ret
    }

    public func write(buffer: UnsafeRawPointer, size: Int) throws -> Int {
        let ret = Darwin.write(fd, buffer, size)
        if ret == -1 { throw PosixError(code: errno) }
        return ret
    }

    public static let stdin: FileDescriptor =
        FileDescriptor(fd: STDIN_FILENO, closeOnDeinit: false)
    public static let stdout: FileDescriptor =
        FileDescriptor(fd: STDOUT_FILENO, closeOnDeinit: false)
    public static let stderr: FileDescriptor =
        FileDescriptor(fd: STDERR_FILENO, closeOnDeinit: false)

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

