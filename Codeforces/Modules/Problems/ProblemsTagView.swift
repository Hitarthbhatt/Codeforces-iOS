//
//  ProblemsTagView.swift
//  Codeforces
//
//  Created by Hitarth Bhatt on 04/12/25.
//

import SwiftUI
import Platform

struct ProblemsTagView: View {
    var tags: [Tag]
    var body: some View {
        HFlowLayout(spacing: 10) {
            ForEach(tags, id: \.self) { tag in
                Text(tag.rawValue.capitalized)
                    .font(.appFont(.callout, .regular))
                    .lineLimit(0)
                    .frame(minWidth: 50)
                    .roundedBackground(
                        vertical: 12,
                        horizontal: 12,
                        bgColor: .secondaryBG,
                        borderColor: .clear,
                        cornerRadius: 10
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 35)
    }
}

#Preview {
    ProblemsTagView(
        tags: [
            .binarySearch,
            .bitmasks,
            .constructiveAlgorithms,
            .dp,
            .dsu,
            .combinatorics
        ]
    )
}
