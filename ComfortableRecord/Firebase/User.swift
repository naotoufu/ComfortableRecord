//
//  User.swift
//  ComfortableRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Firebase
import FireSnapshot
import Foundation

extension Model {
    struct User: SnapshotData, HasTimestamps {
        var username: String = ""
    }
}

