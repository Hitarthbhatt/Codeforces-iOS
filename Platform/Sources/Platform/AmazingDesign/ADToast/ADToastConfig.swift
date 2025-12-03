//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 08/03/25.
//

import Toast
import UIKit
import SwiftUI

extension ADToast {
    enum ToastType {
        case normal
        case success
        case warning
        case error
        
        var textColor: UIColor {
            switch self {
            case .normal:
                return UIColor.black
            default:
                return UIColor.white
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .normal:
                return UIColor.white
            case .success:
                return UIColor(Color.green)
            case .warning:
                return UIColor(Color.yellow)
            case .error:
                return UIColor(Color.red)
            }
        }
    }
}

// MARK: - Toast Configuration Methods.
extension ADToast {
    private static var toast: Toast?
    
    static func show(
        message: String,
        subtext: String? = nil,
        toastType: ToastType = .normal,
        after time: TimeInterval = 0.0,
        direction: Toast.Direction = .top,
        autoHide: Bool = true,
        enablePanToClose: Bool = true,
        displayTime: TimeInterval = 4.0,
        animationTime: TimeInterval = 0.2,
        enteringAnimation: Toast.AnimationType = .default,
        exitingAnimation: Toast.AnimationType = .default,
        attachTo view: UIView? = nil,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil,
        cornerRadius: CGFloat = 15
    ) {
        DispatchQueue.main.async {
            self.toast?.close()
            self.toast = nil
            var dismissables : [Toast.Dismissable] = []
            if autoHide {
                dismissables.append(.time(time: displayTime))
            }
            
            if enablePanToClose  {
                switch direction {
                case .top:
                    dismissables.append(.swipe(direction: .toTop))
                    break
                default:
                    dismissables.append(.swipe(direction: .toBottom))
                }
            }
            
            let config = ToastConfiguration(direction: direction,
                                            dismissBy: dismissables,
                                            animationTime: animationTime,
                                            enteringAnimation: enteringAnimation,
                                            exitingAnimation: exitingAnimation,
                                            attachTo: view)
            
            let viewConfig = ToastViewConfiguration(
                darkBackgroundColor: toastType.backgroundColor,
                lightBackgroundColor: toastType.backgroundColor,
                titleNumberOfLines: 0,
                cornerRadius: cornerRadius)
            
            let textAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: toastType.textColor
            ]
            let textString = NSMutableAttributedString(string: message, attributes: textAttributes)
            
            let subtextAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: toastType.textColor.withAlphaComponent(0.7)
            ]
            
            var subtextString: NSAttributedString?
            if let subtext {
                subtextString = NSMutableAttributedString(string: subtext, attributes: subtextAttributes)
            }
            
            self.toast = Toast.text(textString,
                                    subtitle: subtextString,
                                    viewConfig: viewConfig,
                                    config: config)
            
            if let haptic {
                self.toast?.show(haptic: haptic, after: time)
            } else {
                self.toast?.show(after: time)
            }
        }
    }
    
    static func show(
        view: UIView,
        after time: TimeInterval = 0.0,
        direction: Toast.Direction = .top,
        autoHide: Bool = true,
        enablePanToClose: Bool = true,
        displayTime: TimeInterval = 4.0,
        animationTime: TimeInterval = 0.2,
        enteringAnimation: Toast.AnimationType = .default,
        exitingAnimation: Toast.AnimationType = .default,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil
    ) {
        DispatchQueue.main.async {
            self.toast?.close()
            self.toast = nil
            var dismissables : [Toast.Dismissable] = []
            if autoHide {
                dismissables.append(.time(time: displayTime))
            }
            
            if enablePanToClose  {
                switch direction {
                case .top:
                    dismissables.append(.swipe(direction: .toTop))
                    break
                default:
                    dismissables.append(.swipe(direction: .toBottom))
                }
            }
            
            let toastConfiguration = ToastConfiguration(
                direction: direction,
                dismissBy: dismissables,
                animationTime: animationTime,
                enteringAnimation: enteringAnimation,
                exitingAnimation: exitingAnimation,
                background: .none
            )
            
            let adToastView = ADToastView(child: view)
            self.toast = Toast.custom(view: adToastView, config: toastConfiguration)
            
            if let haptic {
                self.toast?.show(haptic: haptic, after: time)
            } else {
                self.toast?.show(after: time)
            }
        }
    }
    
    static func dismiss(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.toast?.close(completion: completion)
            self.toast = nil
        }
    }
}
