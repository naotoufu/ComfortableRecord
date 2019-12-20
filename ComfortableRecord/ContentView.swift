//
//  ContentView.swift
//  ComfortableRecord
//
//  Created by 伊東直人 on 2019/12/12.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var store: AppStore
    
    var body: some View {
        AnyView({ () -> AnyView in
            if store.state.authState.loadingState == .initial {
                return AnyView(Spacer())
            } else {
                if self.store.state.authState.user != nil {
                    return AnyView(TabView())
                } else {
                    return AnyView(SignUpView())
                }
            }
            }())
            .onAppear { self.store.dispatch(AuthState.Action.subscribe()) }
            .onDisappear { self.store.dispatch(AuthState.Action.unsubscribe()) }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppMain().store)
    }
}
#endif
