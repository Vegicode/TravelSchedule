
import SwiftUI

extension View {
    func setRowElement() -> some View {
        modifier(SetRowElement())
    }
    
    func setCustomNavBackButton() -> some View {
        modifier(SetCustomNavBackButton())
    }
    
    func setCustomNavigationBar(title: String = "") -> some View {
        modifier(SetCustomNavigationBar(title: title))
    }
}
