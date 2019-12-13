//
//  AppMain.swift
//  ComfortbleRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftThunk

final class AppMain {
    let store: AppStore

    init(store: Store<AppState> = makeStore()) {
        self.store = AppStore(store)
    }
}

private func makeStore() -> Store<AppState> {
    .init(
        reducer: AppReducer.reducer,
        state: .init(),
        middleware: [
            createLoggingMiddleware(),
            createThunkMiddleware(),
        ]
    )
}
