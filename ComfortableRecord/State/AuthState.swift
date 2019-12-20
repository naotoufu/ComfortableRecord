//
//  AuthState.swift
//  ComfortableRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Combine
import Foundation
import Firebase
import FireSnapshot
import Foundation
import ReSwift
import ReSwiftThunk

// MARK: - State
struct AuthState: StateType {
    enum LoadingState {
        case initial
        case loaded
    }
    
    var loadingState: LoadingState = .initial
    var user: Snapshot<Model.User>?
    var listenerCancellable: AnyCancellable?
}

// MARK: - Action
extension AuthState {
    public enum Action: ReSwift.Action {
        case finishInitialLoad
        case updateAuthChangeListener(listener: AnyCancellable?)
        case updateUser(user: Snapshot<Model.User>?)
        
        static func subscribe() -> AppThunkAction {
            AppThunkAction { dispatch, getState in
                let finishInitialLoad = {
                    if getState()?.authState.loadingState == .initial {
                        dispatch(AuthState.Action.finishInitialLoad)
                    }
                }
                
                let cancellable = Auth.auth().combine.stateDidChange()
                    .map { $1 }
                    .map { user -> ReSwift.Action in
                        if let user = user {
                            return fetchUser(uid: user.uid) {
                                finishInitialLoad()
                            }
                        } else {
                            finishInitialLoad()
                            return updateUser(user: nil)
                        }
                }
                .sink(receiveValue: dispatch)
                
                dispatch(updateAuthChangeListener(listener: cancellable))
            }
        }
        
        static func unsubscribe() -> AppThunkAction {
            AppThunkAction { dispatch, getState in
                getState()?.authState.listenerCancellable?.cancel()
                dispatch(updateAuthChangeListener(listener: nil))
            }
        }
        
        static func fetchUser(uid: String, completion: @escaping () -> Void = {}) -> AppThunkAction {
            AppThunkAction { dispatch, getState in
                Snapshot.get(.user(userID: uid)) { result in
                    switch result {
                    case let .success(user):
                        dispatch(updateUser(user: user))
                    case let .failure(error):
                        print(error)
                        if getState()?.signUpState.requesting == false {
                            dispatch(signOut())
                        }
                    }
                    completion()
                }
            }
        }
        
        static func signOut() -> AppThunkAction {
            AppThunkAction { _, _ in
                _ = try? Auth.auth().signOut()
            }
        }
    }
}

// MARK: - Reducer
extension AuthState {
    static var reducer: Reducer<AuthState> {
        return { action, state in
            var state = state ?? AuthState()
           guard let action = action as? Action else {
                return state
            }
            switch action {
            case .finishInitialLoad:
                state.loadingState = .loaded
                return state
            case let .updateAuthChangeListener(cancellable):
                state.listenerCancellable = cancellable
                return state
            case let .updateUser(user):
                state.user = user
                return state
            }
        }
    }
}
