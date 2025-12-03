import SwiftUI

public struct CustomTabBarViewModifier<V: TabBarItemProtocol>: ViewModifier {
    private let tab: V
    private let tabBarBottomPaddingForOlderDevices: CGFloat = 6
    private let customTabBarHeight: CGFloat = 66

    private var safeAreaInsets: UIEdgeInsets? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets
    }

    public init(tab: V) {
        self.tab = tab
    }

    public func body(content: Content) -> some View {
        let bottomPadding = safeAreaInsets?.bottom  == 0 ? tabBarBottomPaddingForOlderDevices : 0

        content
            .safeAreaInset(edge: .bottom, spacing: .zero) {
                Spacer().frame(height: customTabBarHeight + bottomPadding)
            }
            .tag(tab.tag)
            .onAppear {
                UITabBar.changeTabBarState(shouldHide: true)
            }
    }
}

public extension View {
    func setupCustomTab<V: TabBarItemProtocol>(tab: V) -> some View {
        return modifier(CustomTabBarViewModifier(tab: tab))
    }
}
