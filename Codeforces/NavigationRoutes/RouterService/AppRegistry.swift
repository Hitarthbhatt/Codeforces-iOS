import SwiftUI
import Platform

@MainActor
extension View {

    func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            switch destination {
            case .textEditorTool:
                EmptyView()
                .presentationDragIndicator(.hidden)
                .presentationDetents([.height(200)])
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
