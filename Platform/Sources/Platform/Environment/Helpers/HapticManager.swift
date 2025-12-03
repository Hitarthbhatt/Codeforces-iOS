import CoreHaptics
import UIKit

public class HapticManager {
    public static let shared: HapticManager = .init()
    
    public enum HapticType {
        case buttonPress
        case dataRefresh(intensity: CGFloat)
        case notification(_ type: UINotificationFeedbackGenerator.FeedbackType)
        case selection
    }
    
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    private let notificationGenerator = UINotificationFeedbackGenerator()
    
    private init() {
        selectionGenerator.prepare()
        impactGenerator.prepare()
    }
    
    public func fireHaptic(_ type: HapticType) {
        guard supportsHaptics else { return }
        
        switch type {
        case .buttonPress:
            impactGenerator.impactOccurred()
        case let .dataRefresh(intensity):
            impactGenerator.impactOccurred(intensity: intensity)
        case let .notification(type):
            notificationGenerator.notificationOccurred(type)
        case .selection:
            selectionGenerator.selectionChanged()
        }
    }
    
    public var supportsHaptics: Bool {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }
}
