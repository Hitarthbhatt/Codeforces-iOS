//
//  File.swift
//  Platform
//
//  Created by Ankit Panchotiya on 10/02/25.
//
import SwiftUI

// MARK: - Preference to capture each item's frame
private struct SegItemFrameKey: PreferenceKey {
    static var defaultValue: [Int: Anchor<CGRect>] = [:]
    static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

public struct SegmentedView<Data, Content>: View where Data: Hashable, Content: View {

    public let sources: [Data]
    public let selection: Data?
    private let itemBuilder: (Data) -> Content

    @State private var pickerHeight: CGFloat = 36
    @State private var backgroundColor: Color = .white
    @State private var cornerRadius: CGFloat? = nil
    @State private var borderColor: Color? = nil
    @State private var borderWidth: CGFloat? = nil
    @State private var itemSpacing: CGFloat = 0
    @State private var horizontalPadding: CGFloat = 0
    @State private var verticalPadding: CGFloat = 0
    @State private var selectionBackgroundColor: Color? = Color.black.opacity(0.08)

    private var customIndicator: AnyView? = nil
    @State private var frames: [Int: Anchor<CGRect>] = [:]

    public init(
        _ sources: [Data],
        selection: Data?,
        indicatorBuilder: @escaping () -> some View,
        @ViewBuilder itemBuilder: @escaping (Data) -> Content
    ) {
        self.sources = sources
        self.selection = selection
        self.itemBuilder = itemBuilder
        self.customIndicator = AnyView(indicatorBuilder())
    }

    public init(
        _ sources: [Data],
        selection: Data?,
        @ViewBuilder itemBuilder: @escaping (Data) -> Content
    ) {
        self.sources = sources
        self.selection = selection
        self.itemBuilder = itemBuilder
    }

    public var body: some View {
        ZStack(alignment: .leading) {

            // Selection rounded-rectangle indicator (sizes/positions from measured item frame)
            GeometryReader { proxy in
                if
                    let selection,
                    let idx = sources.firstIndex(of: selection),
                    let anchor = frames[idx]
                {
                    let rect = proxy[anchor]
                    Group {
                        if let customIndicator {
                            customIndicator
                        } else {
                            RoundedRectangle(cornerRadius: (cornerRadius ?? 6), style: .continuous)
                                .fill(selectionBackgroundColor ?? .clear)
                                .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 1)
                        }
                    }
                    .frame(width: rect.width, height: rect.height)
                    .position(x: rect.midX, y: rect.midY)
                    .animation(.spring(response: 0.3, dampingFraction: 0.9), value: selection)
                }
            }

            // Items (horizontally scrolling, intrinsic width)
            ScrollViewReader { _ in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: itemSpacing) {
                        ForEach(sources.indices, id: \.self) { index in
                            let item = sources[index]

                            itemBuilder(item)
                                .frame(height: pickerHeight)
                                .padding(.horizontal, horizontalPadding)
                                .padding(.vertical, verticalPadding)
                                .background(
                                    GeometryReader { geo in
                                        Color.clear
                                            .anchorPreference(key: SegItemFrameKey.self,
                                                              value: .bounds) { anchor in
                                                [index: anchor]
                                            }
                                    }
                                )
                        }
                    }
                }
            }
        }
        .onPreferenceChange(SegItemFrameKey.self) { frames = $0 }
        .roundedBackground(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
            bgColor: backgroundColor,
            borderColor: borderColor ?? .clear,
            borderWidth: borderWidth ?? .zero,
            cornerRadius: cornerRadius ?? 6
        )
        .frame(height: pickerHeight + (verticalPadding * 2))
    }
}

extension SegmentedView {
    
    public func setPickerHeight(_ height: CGFloat) -> SegmentedView {
        var view = self
        view._pickerHeight = State(initialValue: height)
        return view
    }
    
    public func pickerBackgroundColor(_ color: Color) -> SegmentedView {
        var view = self
        view._backgroundColor = State(initialValue: color)
        return view
    }
    
    public func cornerRadius(_ cornerRadius: CGFloat) -> SegmentedView {
        var view = self
        view._cornerRadius = State(initialValue: cornerRadius)
        return view
    }
    
    public func borderColor(_ borderColor: Color) -> SegmentedView {
        var view = self
        view._borderColor = State(initialValue: borderColor)
        return view
    }
    
    public func borderWidth(_ borderWidth: CGFloat) -> SegmentedView {
        var view = self
        view._borderWidth = State(initialValue: borderWidth)
        return view
    }
    
    public func setItemSpacing(_ padding: CGFloat) -> SegmentedView {
        var view = self
        view._itemSpacing = State(initialValue: padding)
        return view
    }
    
    public func setSelectionBackgroundColor(_ color: Color) -> SegmentedView {
        var view = self
        view._selectionBackgroundColor = State(initialValue: color)
        return view
    }
    
    public func setPickerPadding(
        horizontalPadding: CGFloat,
        verticalPadding: CGFloat
    ) -> SegmentedView {
        var view = self
        view._horizontalPadding = State(initialValue: horizontalPadding)
        view._verticalPadding = State(initialValue: verticalPadding)
        return view
    }
}

extension Shape {
    public func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 0) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}
