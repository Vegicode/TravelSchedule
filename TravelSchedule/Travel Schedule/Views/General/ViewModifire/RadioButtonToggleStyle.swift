//
//  RadioButtonToggleStyle.swift
//  Travel Schedule
//
//  Created by Niykee Moore on 13.01.2025.
//

import SwiftUI

struct RadioButtonToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: .zero) {
            configuration.label
            
            Spacer()
            
            (configuration.isOn ? AppImages.RadioButton.on : AppImages.RadioButton.off)
                .resizable()
                .frame(width: AppSizes.Size.toggle, height: AppSizes.Size.toggle)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

extension ToggleStyle where Self == RadioButtonToggleStyle {
    static var radioButton: Self { Self() }
}
