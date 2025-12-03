//
//  CustomNavigationView.swift
//  Platform
//
//  Created by Ankit Panchotiya on 24/10/25.
//

import SwiftUI

public extension View {

    func withNavigation<LeadingView: View, TrailingView: View>(
        title: String = "",
        background: Color = Color.primaryBG,
        horizontalSpace: Double = 20,
        verticalSpace: Double = 8,
        @ViewBuilder leftContent: @escaping () -> LeadingView = { EmptyView() },
        @ViewBuilder rightContent: (() -> TrailingView) = { EmptyView() }
    ) -> some View {
        VStack(spacing: 0) {
            ZStack {
                if !title.isEmpty {
                    Text(title)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.primaryLabel)
                }

                HStack {
                    leftContent()
                    Spacer()
                    rightContent()
                }
            }
            .padding(.horizontal, horizontalSpace)
            .padding(.vertical, verticalSpace)
            .background(background)

            self
            Spacer()
        }
        .navigationBarHidden(true)
    }
}
