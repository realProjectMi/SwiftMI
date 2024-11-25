import SwiftUI

/// Use icon (SF Symbol) as a button.
/// - Parameters:
///     - systemName: SF Symbol name
public struct ButtonIcon: View {
    
    private var systemName: String
    private var action: () -> Void
    
    /// Use icon (SF Symbol) as a button.
    public init(
        _ systemName: String,
        action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
        }
    }
}
