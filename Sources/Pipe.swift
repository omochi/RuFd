//
//  Pipe.swift
//  RuProcess
//
//  Created by omochimetaru on 2017/03/31.
//
//

import Darwin
import RuPosixError

public class Pipe {
    public init(reader: FileDescriptor,
                writer: FileDescriptor)
    {
        self.reader = reader
        self.writer = writer
    }

    public let reader: FileDescriptor
    public let writer: FileDescriptor

    public static func create() throws -> Pipe {
        var fds: [Int32] = [0, 0]
        let ret = Darwin.pipe(&fds)
        guard ret == 0 else {
            throw PosixError(code: errno)
        }
        return Pipe(reader: .of(fds[0]),
                    writer: .of(fds[1]))
    }
}
