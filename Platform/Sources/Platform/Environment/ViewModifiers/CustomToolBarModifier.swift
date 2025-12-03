//
//  CustomTabBar.swift
//  Platform
//
//  Created by Ankit Panchotiya on 13/10/25.
//

import SwiftUI

// MARK: - CustomToolBarModifier
public struct CustomToolBarModifier<LeadingView: View, TrailingView: View>: ViewModifier {
    let leftContent: LeadingView?
    let title: String
    let rightContent: TrailingView?
    let isHideSharedBackground: Bool
    
    public init(
        @ViewBuilder leftContent: () -> LeadingView? = { EmptyView() },
        title: String = "",
        @ViewBuilder rightContent: () -> TrailingView? = { EmptyView() },
        isHideSharedBackground: Bool
    ) {
        self.leftContent = leftContent()
        self.title = title
        self.rightContent = rightContent()
        self.isHideSharedBackground = isHideSharedBackground
    }
    
    public func body(content: Content) -> some View {
        content
            .if(Util.isIOS26, transform: { view in
                view
                    .toolbarBackground(.hidden, for: .navigationBar)
            })
            .if(!Util.isIOS26, transform: { view in
                view
                    .toolbarBackground(Color.black, for: .navigationBar)
            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)
            .toolbar {
                ToolBarTab(
                    leftContent: { leftContent },
                    title: title,
                    rightContent: { rightContent },
                    isHideSharedBackground: isHideSharedBackground
                )
            }
    }
}

public extension View {
    func customToolBar<LeadingView: View, TrailingView: View>(
        isHideSharedBackground: Bool = false,
        @ViewBuilder leftContent: @escaping () -> LeadingView? = { EmptyView() },
        title: String = "",
        @ViewBuilder rightContent: @escaping () -> TrailingView? = { EmptyView() }
    ) -> some View {
        modifier(
            CustomToolBarModifier(
                leftContent: leftContent,
                title: title,
                rightContent: rightContent,
                isHideSharedBackground: isHideSharedBackground
            )
        )
    }
}

fileprivate struct ToolBarTab<LeadingView: View, TrailingView: View>: ToolbarContent {
    let leftContent: LeadingView?
    let title: String
    let rightContent: TrailingView?
    let isHideSharedBackground: Bool
    
    init(
        @ViewBuilder leftContent: () -> LeadingView? = { EmptyView() },
        title: String = "",
        @ViewBuilder rightContent: () -> TrailingView? = { EmptyView() },
        isHideSharedBackground: Bool
    ) {
        self.leftContent = leftContent()
        self.title = title
        self.rightContent = rightContent()
        self.isHideSharedBackground = isHideSharedBackground
    }
    
    var body: some ToolbarContent {
        // Apply conditionally
        hideSharedBackground(apply: isHideSharedBackground) {
            ToolbarItemGroup(placement: .topBarLeading) {
                if let leftContent = leftContent {
                    leftContent
                }
                
                if !title.isEmpty {
                    Text(title)
                        .sfProSemiBold(size: 17)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }
        }
        
        ToolbarItem(placement: .topBarTrailing) {
            if let rightContent = rightContent {
                rightContent
            }
        }
    }
    
    @ToolbarContentBuilder
    private func hideSharedBackground<Content: ToolbarContent>(
        apply: Bool,
        @ToolbarContentBuilder _ content: () -> Content
    ) -> some ToolbarContent {
        if #available(iOS 26.0, *), apply {
            content()
                .sharedBackgroundVisibility(.hidden)
        } else {
            content()
        }
    }
}
