import Foundation
import SwiftUI

public protocol TabBarItemProtocol: CaseIterable, Hashable {
    var tag: Int { get }
    var imageName: String { get }
    var text: String { get }
    var selectedColor: Color { get }
    var unSelectedColor: Color { get }
    associatedtype Content: View
    @MainActor @ViewBuilder func getContent() -> Content
}
