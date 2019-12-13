//
//  AppReducer.swift
//  ComfortbleRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Foundation
import ReSwift

enum AppReducer {
    static var reducer: Reducer<AppState> {
        return { action, state in
            var state = state ?? AppState()
            state.authState = AuthState.reducer(action, state.authState)
            state.signUpState = SignUpState.reducer(action, state.signUpState)
            return state
        }
    }
}
