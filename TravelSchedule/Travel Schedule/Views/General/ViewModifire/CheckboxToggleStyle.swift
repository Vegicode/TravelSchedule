
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .zero) {
            configuration.label

            Spacer()

            ZStack {
                AppImages.Checkbox.on
                    .resizable()
                    .opacity(configuration.isOn ? 1 : 0)
                AppImages.Checkbox.off
                    .resizable()
                    .opacity(configuration.isOn ? 0 : 1)
            }
            .frame(width: AppSizes.Size.toggle, height: AppSizes.Size.toggle)
            .onTapGesture {
                configuration.isOn.toggle()
            }
        }
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkBox: Self { Self() }
}
