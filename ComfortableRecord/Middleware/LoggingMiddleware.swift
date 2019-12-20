//
//  LoggingMiddleware.swift
//  ComfortableRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Foundation
import ReSwift

func createLoggingMiddleware() -> Middleware<AppState> {
    return { _, _ in
        { next in
            { action in
                print("[dispatch]: \(action)")
                next(action)
            }
        }
    }
}
