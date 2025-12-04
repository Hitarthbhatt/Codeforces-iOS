//
//  ProblemListView.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 03/12/25.
//

import SwiftUI
import Platform

struct ProblemListView: View {
    @State private var viewModel: ProblemsViewModel = .init()
    @State private var sheetDestination: SheetDestination?
    
    var body: some View {
        mainView
            .task {
                viewModel.fetchProblems()
            }
            .customToolBar(title: "Problems")
            .withSheetDestinations(sheetDestinations: $sheetDestination)
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
        case .finished:
            listView
        case .error:
            EmptyView()
        case .emptyState:
            EmptyView()
        }
    }
    
    private var listView: some View {
        List(viewModel.problems) { problem in
            problemsCellView(problem: problem)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(.init())
        }
        .listStyle(.plain)
    }
    
    private func problemsCellView(problem: Problem) -> some View {
        VStack(spacing: 4) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    if let level = problem.index {
                        Text(level + ":")
                            .font(.appFont(.headline, .semibold))
                            .foregroundStyle(Color.primaryLabel)
                    }
                    
                    Text(problem.name ?? "NA")
                        .font(.appFont(.headline, .regular))
                        .lineLimit(3)
                        .foregroundStyle(Color.primaryLabel)
                    
                    Spacer(minLength: 5)
                    if let rating = problem.rating {
                        Text(String(rating))
                            .font(.appFont(.headline, .regular))
                            .foregroundStyle(Color.secondaryLabel)
                    }
                } // HStack
                
                HStack {
                    Text("Tags")
                        .foregroundStyle(Color.primaryLabel.opacity(0.5))
                        .font(Font.appFont(.subHeadline, .regular))
                        .roundedBackground(
                            vertical: 4,
                            horizontal: 10,
                            bgColor: .primary700,
                            borderColor: .brandSecondaryBG,
                            cornerRadius: 7
                        )
                        .onTapGesture {
                            if let tags = problem.tags, !tags.isEmpty {
                                sheetDestination = .problemTags(tags: tags)
                            }
                        }
                    
                    Spacer(minLength: 0)
                    Image(systemName: "document.on.document")
                        .foregroundStyle(Color.primaryLabel.opacity(0.5))
                        .roundedBackground(
                            vertical: 4,
                            horizontal: 10,
                            bgColor: .primary700,
                            borderColor: .brandSecondaryBG,
                            cornerRadius: 7
                        )
                } // HStack
            } // VStack
            .roundedBackground(
                vertical: 12,
                horizontal: 12,
                bgColor: Color.quaternaryBG.opacity(0.2),
                borderColor: .clear,
                cornerRadius: 10
            )
            
            Button(action: {
            }, label: {
                Text("Open Problem")
                    .foregroundStyle(Color.primaryLabel)
                    .font(Font.appFont(.subHeadline, .regular))
                    .roundedBackground(
                        vertical: 4,
                        horizontal: 0,
                        bgColor: .clear,
                        borderColor: .brandSecondaryBG,
                        cornerRadius: 7
                    )
            })
        } // VStack
        .padding(.horizontal, 20)
        .padding(.vertical, 7)
    }
}

#Preview {
    NavigationTab {
        ProblemListView()
    }
}
