
import SwiftUI

struct SetCustomNavigationBar: ViewModifier {
    @State private var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .setCustomNavBackButton()
    }
}
