import SwiftUI

struct CustomTabButton<T: TabBarItemProtocol>: View {
    
    var currentTab: T
    @Binding var selectedTab: T
    
    init(currentTab: T,
         selectedTab: Binding<T>) {
        self.currentTab = currentTab
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        customButtonView
            .onTapGesture {
                selectedTab = currentTab
            }
    }
    
    private var customButtonView: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(systemName: currentTab.imageName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 15, height: 15)
            
            Text(currentTab.text)
                .font(Font.sfProMedium(size: 10))
        }
        .frame(alignment: .center)
        .foregroundStyle(selectedTab == currentTab ? currentTab.selectedColor : currentTab.unSelectedColor)
    }
}

