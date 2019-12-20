//
//  AppState.swift
//  ComfortableRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var authState: AuthState = .init()
    var signUpState: SignUpState = .init()
}
