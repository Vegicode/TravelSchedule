
import SwiftUI

struct SearchResultEmptyView: View {
    let notification: String

    var body: some View {
        Spacer()
        Text(notification)
            .font(AppFonts.Bold.medium)
        Spacer()
    }
}

#Preview {
    SearchResultEmptyView(notification: "Nothing is here")
}
