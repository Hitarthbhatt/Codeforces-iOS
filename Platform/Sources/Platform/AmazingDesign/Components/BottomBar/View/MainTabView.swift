import SwiftUI

public struct MainTabView<T: TabBarItemProtocol>: View {
    @Binding private var selectedTab: T
    private let allCases: [T]
    @State private var isOpenLogin: Bool = false
    @State var routerService: RouterService = RouterService.shared
    private var safeAreaInsets: UIEdgeInsets? {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets
    }

    public init(
        selectedTab: Binding<T>,
        allCases: [T]
    ) {
        self._selectedTab = selectedTab
        self.allCases = allCases
    }

    public var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(allCases, id: \.self) { tab in
                tab.getContent()
                    .tabItem {
                        CustomTabButton(
                            currentTab: tab,
                            selectedTab: $selectedTab
                        )
                    }
                    .tag(tab)
            }
        }
        .toolbarBackground(Color.primaryBG, for: .tabBar)
        .tint(Color.brandPrimaryBG)
    }
}

