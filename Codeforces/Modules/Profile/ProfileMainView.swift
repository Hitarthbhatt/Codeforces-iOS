//
//  ProfileMainView.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 10/12/25.
//

import SwiftUI
import Platform

struct ProfileMainView: View {
    @State private var viewModel: ProfileViewModel = .init()
    var body: some View {
        mainView
            .task {
                viewModel.fetchUserInfo()
            }
            .customToolBar(title: "Profile")
    }
    
    @ViewBuilder
    private var mainView: some View {
        VStack {
            userImageView
            userDetailView
            
            HStack {
                detailView(header: "Max", value: "Master")
                detailView(header: "Max", value: "Master")
            } // HStack
            Spacer()
        } // VStack
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var userImageView: some View {
        if let userImage = viewModel.userInfo.first?.titlePhoto {
            AsyncImage(url: URL(string: userImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ZStack {
                    Color.tertiaryBG
                    ProgressView()
                } // ZStack
            }
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var userDetailView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(viewModel.userInfo.first?.handle ?? "N/A")
                    .font(.appFont(.title2, .bold))
                    .foregroundStyle(Color.primaryLabel)
                
                HStack(spacing: 4) {
                    Text(viewModel.userInfo.first?.rank?.capitalized ?? "N/A")
                        .font(.appFont(.headline, .semibold))
                        .foregroundStyle(Color.brandLabel)
                    
                    Text("(\(viewModel.userInfo.first?.rating ?? 0))")
                        .font(.appFont(.subHeadline, .bold))
                        .foregroundStyle(Color.secondaryLabel)
                    
                    Spacer()
                } // HStack
            } // VStack
            
            Spacer()
            
            Text("Online")
                .foregroundStyle(.green)
        } // HStack
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .infiniteWidth(alignment: .top)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
    
    private func detailView(header: String, value: String) -> some View {
        HStack {
            Text(header)
            
            Text(value)
        } // HStack
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .infiniteWidth()
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    NavigationTab {
        ProfileMainView()
    }
}
