import SwiftUI

/// Create a Grid layout based on the width of grid item.
/// - Parameters:
///     - width: Grid item width
///     - gap: [Columns gap, Rows gap]
public struct AutoGrid<Content: View>: View {
    
    private var columns: [GridItem]
    private var width: CGFloat
    private var gap: [CGFloat]
    @ViewBuilder var content: () -> Content
    
    /// Grid layout based on item width.
    public init(
        _ width: CGFloat = 100,
        gap: [CGFloat] = [16],
        @ViewBuilder content: @escaping () -> Content
    ) {
        let gapCol = gap.isEmpty ? 16 : gap[0]
        let gapRow = gap.isEmpty ? 16 : (gap.count > 1 ? gap[1] : gap[0])
        self.columns = [GridItem(.adaptive(minimum: width, maximum: .infinity), spacing: gapCol)]
        self.width = width
        self.gap = [gapCol, gapRow]
        self.content = content
    }
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: gap[1], content: content)
    }
}
