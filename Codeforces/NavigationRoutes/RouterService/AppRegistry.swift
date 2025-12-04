import SwiftUI
import Platform

@MainActor
extension View {

    func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            switch destination {
            case .problemTags(let tags):
                ProblemsTagView(tags: tags)
                    .presentationDragIndicator(.visible)
                    .dynamicSheetHeight()
            }
        }
    }
    
    func withFullScreenCoverDestinations(destinations: Binding<FullScreenCoverDestination?>) -> some View {
        fullScreenCover(item: destinations) { destination in
            switch destination {
            case .camera:
                EmptyView()
            }
        }
    }
}
