//
//  LoadingView.swift
//  ComfortableRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    private let isLoading: Bool
    init(isLoading: Bool) {
        self.isLoading = isLoading
    }

    var body: some View {
        ZStack {
            if isLoading {
                Spacer()
                    .background(Color.primary)
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)

                Text("Loading...")
                    .fontWeight(.bold)
                    .foregroundColor(Color.primary)
            }
        }
    }
}

#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true)
    }
}
#endif
