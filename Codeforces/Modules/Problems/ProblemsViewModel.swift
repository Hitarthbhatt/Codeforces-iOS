//
//  ProblemsViewModel.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 03/12/25.
//

import Observation
import Combine
import Platform
import SwiftUI

@Observable
final class ProblemsViewModel {
    
    // MARK: - Properties
    var problems: [Problem] = []
    var problemStatistics: [ProblemStatistic] = []
    var viewState: ViewState = .loading
    var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager: NetworkControllerProtocol
    
    // MARK: - Initialization
    init(networkManager: NetworkControllerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    // MARK: - Public Methods
    func fetchProblems(tags: String = "dp") {
        viewState = .loading
        
        networkManager.apiCall(
            requestItem: .getProblems(tags: tags),
            triesLeft: 2,
            params: nil,
            type: BaseModel<ProblemList>.self
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
    
    private func handleResponse(_ response: BaseModel<ProblemList>) {
        guard response.status == "OK" else {
            viewState = .emptyState
            return
        }
        problems = response.result.problems ?? []
        problemStatistics = response.result.problemStatistics ?? []
    }
}
