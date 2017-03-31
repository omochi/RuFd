//
//  OpenOpenMode.swift
//  RuFd
//
//  Created by omochimetaru on 2017/03/31.
//
//

import Darwin

public struct OpenMode: OptionSet {
    public init(rawValue: mode_t) {
        self.rawValue = rawValue
    }
    public let rawValue: mode_t

    public static let rwxu = OpenMode(rawValue: S_IRWXU)
    public static let ru = OpenMode(rawValue: S_IRUSR)
    public static let wu = OpenMode(rawValue: S_IWUSR)
    public static let xu = OpenMode(rawValue: S_IXUSR)
    public static let rwxg = OpenMode(rawValue: S_IRWXG)
    public static let rg = OpenMode(rawValue: S_IRGRP)
    public static let wg = OpenMode(rawValue: S_IWGRP)
    public static let xg = OpenMode(rawValue: S_IXGRP)
    public static let rwxo = OpenMode(rawValue: S_IRWXO)
    public static let ro = OpenMode(rawValue: S_IROTH)
    public static let wo = OpenMode(rawValue: S_IWOTH)
    public static let xo = OpenMode(rawValue: S_IXOTH)
    public static let suid = OpenMode(rawValue: S_ISUID)
    public static let sgid = OpenMode(rawValue: S_ISGID)
    public static let sticky = OpenMode(rawValue: S_ISVTX)
}
