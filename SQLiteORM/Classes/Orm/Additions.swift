//
//  Additions.swift
//  SQLiteORM
//
//  Created by Valo on 2019/5/10.
//

import Foundation

extension Database {
    /// 数据库对象池
    private static let pool = NSMapTable<NSString, Database>.strongToWeakObjects()

    /// 从数据库对象池创建数据库.若池中存在,则直接取出.否则创建并放入池中
    ///
    /// - Parameters:
    ///   - location: 数据库位置/路径
    ///   - flags: 打开数据库的flags
    ///   - encrypt: 加密字符串
    /// - Returns: 数据库
    public class func fromPool(_ location: Location = .temporary, flags: Int32 = 0, encrypt: String = "") -> Database {
        let udid = location.description + "\(flags)" + encrypt as NSString
        if let db = pool.object(forKey: udid) {
            return db
        }

        let db = Database(location, flags: flags, encrypt: encrypt)
        pool.setObject(db, forKey: udid)
        return db
    }
}
