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
                .listRowSeparator(.hidden, edges: .top)
                .listRowSeparator(.visible, edges: .bottom)
        }
        .listStyle(.plain)
    }
    
    private func problemsCellView(problem: Problem) -> some View {
        VStack(spacing: 4) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .center, spacing: 15) {
                    if let level = problem.index {
                        Text("Level \(level)")
                            .font(.appFont(.subHeadline, .medium))
                            .foregroundStyle(Color.primaryLabel)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "tag")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(Color.brandLabel)
                        .onTapGesture {
                            if let tags = problem.tags, !tags.isEmpty {
                                sheetDestination = .problemTags(tags: tags)
                            }
                        }
                    
                    Image(systemName: "document.on.document")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(Color.brandLabel)
                } // HStack
                
                Text(problem.name ?? "NA")
                    .font(.appFont(.title2, .medium))
                    .lineLimit(3)
                    .foregroundStyle(Color.primaryLabel)
                
                if let rating = problem.rating {
                    Text("Problem Rating \(rating)")
                        .font(.appFont(.subHeadline, .medium))
                        .foregroundStyle(Color.secondaryLabel)
                }
            } // VStack
            
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
            .padding(.top, 10)
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
