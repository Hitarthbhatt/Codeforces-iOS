import Foundation

public enum ViewState: Equatable {
    case loading
    case finished
    case error(String)
    case emptyState
}
