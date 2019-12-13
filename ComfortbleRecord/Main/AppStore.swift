//
//  AppStore.swift
//  ComfortbleRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Combine
import Foundation
import ReSwift

final class AppStore: StoreSubscriber, DispatchingStoreType, ObservableObject {
    private let store: Store<AppState>
    var state: AppState { store.state }
    private(set) var objectWillChange: ObservableObjectPublisher = .init()

    init(_ store: Store<AppState>) {
        self.store = store
        store.subscribe(self)
    }

    func newState(state: AppState) {
        objectWillChange.send()
    }

    func dispatch(_ action: Action) {
        if Thread.isMainThread {
            store.dispatch(action)
        } else {
            DispatchQueue.main.async { [store] in
                store.dispatch(action)
            }
        }
    }

    deinit {
        store.unsubscribe(self)
    }
}
