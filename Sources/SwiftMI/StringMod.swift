import SwiftUI

public extension String {
    
    /// Remove white space before & after of a String, then return if the string is empty.
    var isBlank: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Remove white space before & after of a String.
    var trimSpaces: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
