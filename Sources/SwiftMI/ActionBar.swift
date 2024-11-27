import SwiftUI

public extension View {
    
    /// Create action bottom/side bar
    /// - Parameters:
    ///     - position: Bar position either at bottom or right side
    ///     - iconColor: Color for all items in the bar
    ///     - barColor: Background color for action bar
    ///     - blurColor: Create a blur effect for bottom action bar (side bar does not need this parameter)
    func actionBar<T: View>(
        position: ActionBarPosition,
        iconColor: Color,
        barColor: Color,
        blurColor: Color = .clear,
        @ViewBuilder content: @escaping () -> T
    ) -> some View {
        modifier(ActionBar(position: position, iconColor: iconColor, barColor: barColor, blurColor: blurColor, menuContent: content))
    }
}

public enum ActionBarPosition {
    case bottom, side
}

public struct ActionBar<T: View>: ViewModifier {
    
    var position: ActionBarPosition
    var iconColor: Color
    var barColor: Color
    var blurColor: Color
    @ViewBuilder var menuContent: () -> T
    
    public init(
        position: ActionBarPosition,
        iconColor: Color,
        barColor: Color,
        blurColor: Color,
        @ViewBuilder menuContent: @escaping () -> T
    ) {
        self.position = position
        self.iconColor = iconColor
        self.barColor = barColor
        self.blurColor = blurColor
        self.menuContent = menuContent
    }
    
    public func body(content: Content) -> some View {
        if position == .bottom {
            content
                .safeAreaPadding(.bottom, 60)
                .overlay {
                    LinearGradient(colors: [
                        blurColor.opacity(0),
                        blurColor.opacity(1)
                    ], startPoint: .top, endPoint: .bottom)
                    .frame(height: 80)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .ignoresSafeArea()
                }
                .overlay {
                    HStack(spacing: 32) {
                        menuContent()
                    }
                    .tint(iconColor)
                    .font(.title2.weight(.light))
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(barColor)
                    .clipShape(.capsule)
                    .shadow(color: .black.opacity(0.1), radius: 2)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
        } else {
            content
                .safeAreaPadding(.trailing, 60)
                .overlay {
                    VStack(spacing: 32) {
                        menuContent()
                    }
                    .tint(iconColor)
                    .font(.title2.weight(.light))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 24)
                    .background(barColor)
                    .clipShape(.capsule)
                    .shadow(color: .black.opacity(0.1), radius: 2)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 10)
                }
        }
    }
}

