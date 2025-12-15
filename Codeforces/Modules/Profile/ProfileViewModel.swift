//
//  ProfileViewModel.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 10/12/25.
//

import Observation
import Combine
import Platform
import SwiftUI

@Observable
final class ProfileViewModel {
    
    // MARK: - Properties
    var userInfo: [UserInfo] = []
    var viewState: ViewState = .loading
    var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager: NetworkControllerProtocol
    
    // MARK: - Initialization
    init(networkManager: NetworkControllerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    
    // MARK: - Public Methods
    func fetchUserInfo() {
        viewState = .loading
        
        networkManager.apiCall(
            requestItem: .getUserInfo(handles: "HitarthBhatt"),
            triesLeft: 2,
            params: nil,
            type: BaseModel<[UserInfo]>.self
        )
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: handleCompletion, receiveValue: handleResponse)
        .store(in: &cancellables)
    }
    
    // MARK: - Private Methods
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        viewState = .finished
        if case .failure = completion {
            viewState = .error("Failed to fetch")
        }
    }
    
    private func handleResponse(_ response: BaseModel<[UserInfo]>) {
        guard response.status == "OK" else {
            viewState = .emptyState
            return
        }
        self.userInfo = response.result
    }
}
