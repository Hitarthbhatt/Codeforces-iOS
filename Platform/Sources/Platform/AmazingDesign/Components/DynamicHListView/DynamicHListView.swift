//
//  DynamicHListView.swift
//  Platform
//
//  Created by Ankit Panchotiya on 14/10/25.
//

import SwiftUI

public struct DynamicHListView<Content: View, T: Identifiable & Equatable>: View {

    var items: [T]
    private var content: (T?, Bool) -> Content
    private var didSelect: (T) -> Void
    private var spacing: Double
    private var topPadding: Double
    private var bottomPadding: Double
    private var horizontalPadding: Double
    private var performRefresh: (() -> Void)?
    private var performPagination: () -> Void
    private var totalCells: Int = 20
    private var showIndicators : Bool = false
    private var isMultiSelectOnLongGesture: Bool
    private var isMultiSelect: Bool
    private var isSingleSelection: Bool
    private var maximumCellSelection: Int
    private var onTapOfSelectedItem: (T) -> Void
    var columnGrid: [GridItem]
    @ViewBuilder private var headerView: DynamicHeaderView
    @ViewBuilder private var footerView: DynamicHeaderView
    @Binding private var isSelecting: Bool
    @Binding private var selected: [T]
    @Binding var isShimmering: Bool
    @State var offset: CGFloat = 0
    @Binding var scrollOffset: CGFloat

    // MARK: - Initializer.
    /// - Parameters:
    ///   - items: the items to be displayed
    ///   - selected: the currently selected items
    ///   - modified: callback, called when the selection changes
    ///   - content: method to get a displayable string label for a given item
    ///   - performRefresh: an optional callback that is called when the view needs to be refreshed
    public init(
        columnGrid: [GridItem] = [GridItem(.flexible())],
        items: [T],
        isSelecting: Binding<Bool>,
        selected: Binding<[T]>,
        @ViewBuilder content: @escaping (T?, Bool) -> Content,
        showIndicators: Bool = false,
        performRefresh: (() -> Void)? = nil
    ) {

        self.items = items
        self.content = content
        _isSelecting = isSelecting
        _selected = selected
        self.showIndicators = showIndicators
        self.didSelect = {_ in }
        self.spacing = 0
        self.topPadding = 0
        self.bottomPadding = 0
        self.horizontalPadding = 0
        self.performRefresh = performRefresh
        self.performPagination = {}
        self.isMultiSelectOnLongGesture = false
        self.isMultiSelect = false
        self.isSingleSelection = false
        self.columnGrid = columnGrid
        self.headerView = DynamicHeaderView()
        self.footerView = DynamicHeaderView()
        self.maximumCellSelection = items.count
        self.onTapOfSelectedItem = {_ in }
        _isShimmering = .constant(false)
        _scrollOffset = .constant(.zero)
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: showIndicators) {
            ScrollViewReader { _ in
                HStack(alignment: .center) {
                    scrollContentView
                }
            }
        }
    }

    var scrollContentView: some View {
        LazyHGrid(
            rows: [GridItem(.adaptive(minimum: .infinity))],
            spacing: spacing
        ) {
            Section(content: {
                ForEach(0..<(items.isEmpty ? totalCells : items.count), id: \.self) { index in

                    let data = items.isEmpty ? (nil, false) : (items[index], selected.contains(items[index]))
                    content(data.0, data.1)
                        .onTapGesture {
                            onTapOfSelectedItem(items[index])
                            if isSingleSelection {
                                if selected.contains(items[index]) {
                                    selected.remove(at: getIndex(selectedItem: items[index]))
                                } else {
                                    selected = [items[index]]
                                }
                            } else if isSelecting {
                                itemSelection(item: items[index])
                            } else if isMultiSelect {
                                isSelecting = true
                                itemSelection(item: items[index])
                            } else {
                                didSelect(items[index])
                            }
                        } // Tap Gesture
                        .onLongPressGesture {
                            if isMultiSelectOnLongGesture {
                                withAnimation(.easeInOut) {
                                    isSelecting = true
                                    itemSelection(item: items[index])
                                }
                            }
                        } // Long Gesture
                        .disabled(items.isEmpty && isShimmering)
                } // ForEach
            }, header: {
                headerView
            }, footer: {
                footerView
            })
        }
        .frame(maxHeight: .infinity)
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .padding(.horizontal, horizontalPadding)
        .onChange(of: offset) { oldValue, newValue in
            scrollOffset = newValue
        }
        .onChange(of: isMultiSelect) { oldValue, newValue in
            if !newValue {
                withAnimation {
                    isSelecting = false
                    selected.removeAll()
                }
            }
        } // onChange
        .onChange(of: isMultiSelectOnLongGesture) { oldValue, newValue in
            if !newValue {
                withAnimation {
                    isSelecting = false
                    selected.removeAll()
                }
            }
        } // onChange
    }

    func itemSelection(item: T) {
        withAnimation(.easeInOut) {
            if selected.contains(item) {
                selected.remove(at: getIndex(selectedItem: item))
                isSelecting = selected.isEmpty ? false : true
            } else {
                if maximumCellSelection == selected.count {
                    if let lastIndex = selected.last {
                        selected.remove(at: getIndex(selectedItem: lastIndex))
                    }
                }
                selected.append(item)
            }
        }
    }

    func getIndex(selectedItem: T) -> Int {
        let index = selected.firstIndex { item in
            item.id == selectedItem.id
        } ?? 0
        return index
    }
}

// MARK: - Configuration Methods.
extension DynamicHListView {

    public func headerView<HeaderView: View>(@ViewBuilder headerView: () -> HeaderView) -> some View {
        var result = self
        result.headerView.content = AnyView(headerView())
        return result
    }

    public func footerView<FooterView: View>(@ViewBuilder footerView: () -> FooterView) -> some View {
        var result = self
        result.footerView.content = AnyView(footerView())
        return result
    }

    public func cellSpacing(_ spacing: Double) -> DynamicHListView {
        var result = self
        result.spacing = spacing
        return result
    }

    public func topPadding(_ padding: Double) -> DynamicHListView {
        var result = self
        result.topPadding = padding
        return result
    }

    public func bottomPadding(_ padding: Double) -> DynamicHListView {
        var result = self
        result.bottomPadding = padding
        return result
    }

    public func horizontalPadding(_ padding: Double) -> DynamicHListView {
        var result = self
        result.horizontalPadding = padding
        return result
    }

    public func didSelectItem(_ didSelect: @escaping (T) -> Void) -> DynamicHListView {
        var result = self
        result.didSelect = didSelect
        return result
    }

    public func onListRefresh(_ action: @escaping () -> Void) -> DynamicHListView {
        var result = self
        result.performRefresh = action
        return result
    }

    public func skeletonEffect(isShimmering: Binding<Bool>, totalCells: Int = 20) -> DynamicHListView {
        var result = self
        result._isShimmering = isShimmering
        result.totalCells = totalCells
        return result
    }

    public func scrollOffset(scrollOffset: Binding<CGFloat>) -> DynamicHListView {
        var result = self
        result._scrollOffset = scrollOffset
        return result
    }

    public func multiSelectingOnLongGesture(_ isMultiSelect: Bool) -> DynamicHListView {
        var result = self
        result.isMultiSelectOnLongGesture = isMultiSelect
        return result
    }

    public func multiSelecting(_ isMultiSelect: Bool) -> DynamicHListView {
        var result = self
        result.isMultiSelect = isMultiSelect
        return result
    }

    public func singleSelecting(_ isSingleSelection: Bool) -> DynamicHListView {
        var result = self
        result.isSingleSelection = isSingleSelection
        return result
    }

    public func maximumSelectionCount(_ maximumCount: Int) -> DynamicHListView {
        var result = self
        result.maximumCellSelection = maximumCount
        return result
    }

    public func onTapOfSelectedItem(_ didSelect: @escaping (T) -> Void) -> DynamicHListView {
        var result = self
        result.onTapOfSelectedItem = didSelect
        return result
    }
}

struct DynamicHeaderView: View {

    var content: AnyView?

    var body: some View {
        if content != nil {
            content
        }
    }
}
