//
//  OpenConfig.swift
//  RuFd
//
//  Created by omochimetaru on 2017/03/31.
//
//

import Darwin

public struct OpenFlag: OptionSet {
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }
    public let rawValue: Int32

    // open for reading only
    public static let readOnly = OpenFlag(rawValue: O_RDONLY)
    // open for writing only
    public static let writeOnly = OpenFlag(rawValue: O_WRONLY)
    // open for reading and writing
    public static let readWrite = OpenFlag(rawValue: O_RDWR)
    // do not block on open or for data to become available
    public static let nonBlock = OpenFlag(rawValue: O_NONBLOCK)
    // append on each write
    public static let append = OpenFlag(rawValue: O_APPEND)
    // create file if it does not exist
    public static let create = OpenFlag(rawValue: O_CREAT)
    // truncate size to 0
    public static let truncate = OpenFlag(rawValue: O_TRUNC)
    // error if .create and the file exists
    public static let exclusive = OpenFlag(rawValue: O_EXCL)
    // atomically obtain a shared lock
    public static let sharedLock = OpenFlag(rawValue: O_SHLOCK)
    // atomically obtain an exclusive lock
    public static let exclusiveLock = OpenFlag(rawValue: O_EXLOCK)
    // do not follow symlinks
    public static let notFollow = OpenFlag(rawValue: O_NOFOLLOW)
    // allow open of symlinks
    public static let symlink = OpenFlag(rawValue: O_SYMLINK)
    // descriptor requested for event notifications only
    public static let eventOnly = OpenFlag(rawValue: O_EVTONLY)
    // mark as close-on-exec
    public static let closeOnExec = OpenFlag(rawValue: O_CLOEXEC)
    // don't assign controlling terminal
    public static let notChangeTty = OpenFlag(rawValue: O_NOCTTY)
}
