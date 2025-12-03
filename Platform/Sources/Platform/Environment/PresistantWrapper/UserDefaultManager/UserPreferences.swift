//
//  UserPreferences.swift
//  Platform

import SwiftUI

public protocol UserPreferencesManaging: AnyObject {
    var isUserLoggedIn: Bool { get set }
    func clearUserInfo()
}

@Observable
final public class UserPreferences: UserPreferencesManaging {

    class Storage {
        @AppStorage("is_user_logged_in") public var isUserLoggedIn: Bool = true
    }

    private let sharedDefault = UserDefaults.standard
    public static let shared: UserPreferences = .init()
    private let storage: Storage = .init()

    public var isUserLoggedIn: Bool {
        didSet {
            storage.isUserLoggedIn = isUserLoggedIn
        }
    }

    public var testKey: Bool {
        didSet {
            storage.isUserLoggedIn = isUserLoggedIn
        }
    }

    private init () {
        isUserLoggedIn = storage.isUserLoggedIn
        testKey = storage.isUserLoggedIn
    }

    convenience init(_ value: Bool = false) {
        self.init()
    }

    public func clearUserInfo() {
        if let domain = Bundle.main.bundleIdentifier {
            sharedDefault.removePersistentDomain(forName: domain)
        }
        sharedDefault.synchronize()
        self.isUserLoggedIn = false
    }
}

private struct UserPreferencesKey: EnvironmentKey {
    // Expose as protocol so only protocol members are accessible.
    static var defaultValue: UserPreferencesManaging = UserPreferences.shared
}

public extension EnvironmentValues {

    /// Public API: only protocol surface is visible to callers.
    var userPreferences: UserPreferencesManaging {
        get { self[UserPreferencesKey.self] }
        set { self[UserPreferencesKey.self] = newValue }
    }
}
