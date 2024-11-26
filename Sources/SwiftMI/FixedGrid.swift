import SwiftUI

/// Create a Grid layout based on fixed numbers of columns
/// - Parameters:
///     - width: Grid item width
///     - gap: [Columns gap, Rows gap]
public struct FixedGrid<Content: View>: View {
    
    private var columns: [GridItem]
    private var gap: [CGFloat]
    @ViewBuilder var content: () -> Content
    
    /// Create a Grid layout based on fixed numbers of columns
    public init(
        _ columns: Int = 2,
        gap: [CGFloat] = [16],
        @ViewBuilder content: @escaping () -> Content
    ) {
        let gapCol = gap.isEmpty ? 16 : gap[0]
        let gapRow = gap.isEmpty ? 16 : (gap.count > 1 ? gap[1] : gap[0])
        self.columns = Array(repeating:  GridItem(.flexible(), spacing: gapCol), count: columns)
        self.gap = [gapCol, gapRow]
        self.content = content
    }
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: gap[1], content: content)
    }
}

// MARK: - FixedGrid Styles (custom modifiers)
public extension View {
    
    /// Turn a single row of FixedGrid into a bottom navigation bar.
    func bottomNavigationCompactStyle() -> some View {
        modifier(BottomNavigationCompactStyle())
    }
}

public struct BottomNavigationCompactStyle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.title2.weight(.light))
            .padding(.top, 10)
            .padding(.bottom, 6)
            .padding(.horizontal)
            .tint(.white.opacity(0.8))
            .background(.black)
            .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
