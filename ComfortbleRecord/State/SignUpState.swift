//
//  SignUpState.swift
//  ComfortbleRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Firebase
import FireSnapshot
import Foundation
import ReSwift

// MARK: - State
struct SignUpState: StateType {
    var requesting: Bool = false
    var error: Error?
}

// MARK: - Action
extension SignUpState {
    public enum Action: ReSwift.Action {
        case signUpStarted
        case signUpFinished
        case signUpFailed(error: Error)
        
        static func signUp(with name: String, auth: Auth = .auth()) -> AppThunkAction {
            AppThunkAction { dispatch, getState in
                if getState()?.signUpState.requesting == true {
                    return
                }
                dispatch(Action.signUpStarted)
                auth.signInAnonymously { result, error in
                    if let error = error {
                        dispatch(Action.signUpFailed(error: error))
                    } else if let result = result {
                        dispatch(Action.createUser(with: result.user.uid, name: name))
                    }
                }
            }
        }
        private static func createUser(with uid: String, name: String, db: Firestore = .firestore()) -> AppThunkAction {
            AppThunkAction { dispatch, _ in
                let user = Model.User(username: name)
                Snapshot(data: user, path: .user(userID: uid)).create { result in
                    switch result {
                    case .success:
                        dispatch(AuthState.Action.fetchUser(uid: uid) {
                            dispatch(SignUpState.Action.signUpFinished)
                        })
                    case let .failure(error):
                        dispatch(SignUpState.Action.signUpFailed(error: error))
                    }
                }
            }
        }
    }
}

// MARK: - Reducer
extension SignUpState {
    static var reducer: Reducer<SignUpState> {
        return { action, state in
            var state = state ?? SignUpState()
            switch action {
            case let action as Action:
                switch action {
                case .signUpStarted:
                    state.requesting = true
                    state.error = nil
                    return state
                case .signUpFinished:
                    state.requesting = false
                    state.error = nil
                    return state
                case let .signUpFailed(error):
                    state.requesting = false
                    state.error = error
                    return state
                }
            default:
                return state
            }
        }
    }
}
