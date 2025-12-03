//
//  ADToast.swift
//  IGM
//
//  Created by Ankit Panchotiya on 21/10/24.
//

import SwiftUI
import Toast

public final class ADToast {
    public static func displayToast(message: String, direction: Toast.Direction = .top) {
        ADToast.show(message: message, direction: direction)
    }
    
    public static func displayErrorToast(message: String, subtext: String? = nil, direction: Toast.Direction = .top) {
        ADToast.show(message: message, subtext: subtext, toastType: .error, direction: direction, haptic: .error)
    }
    
    public static func displaySuccessToast(message: String, direction: Toast.Direction = .top) {
        ADToast.show(message: message, toastType: .success, direction: direction, haptic: .success)
    }
    
    public static func displayWarningToast(message: String, direction: Toast.Direction = .top) {
        ADToast.show(message: message, toastType: .warning, direction: direction, haptic: .warning)
    }
    
    public static func dismissToast(completion: (() -> Void)? = nil) {
        ADToast.dismiss(completion: completion)
    }
    
    public static func displayToast<Content: View>(view: Content, direction: Toast.Direction = .top) {
        guard let uiView = UIHostingController(rootView: view).view else { return }
        uiView.backgroundColor = .clear
        ADToast.show(view: uiView, direction: direction, haptic: .success)
    }
}
