
import SwiftUI

struct SetRowElement: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, AppSizes.Spacing.large)
            .frame(maxWidth: .infinity, maxHeight: AppSizes.Height.row)
            .font(AppFonts.Regular.medium)
    }
}
