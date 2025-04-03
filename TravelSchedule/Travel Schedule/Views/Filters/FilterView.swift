import SwiftUI

struct FilterView: View {
    // MARK: - Constants
    
    private let timeSectionTitle = "Время отправления"
    private let connectionSectionTitle = "Показывать варианты с пересадками"
    private let buttonTitle = "Применить"
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: FilterViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            timeSectionView
            connectionSectionView
            Spacer()
            if viewModel.currentFilter != viewModel.viewModelFilter {
                buttonView
            }
        }
        .setCustomNavigationBar()
        .onAppear {
            viewModel.loadFilter()
        }
    }
}

// MARK: - Private views
private extension FilterView {
    var timeSectionView: some View {
        VStack(alignment: .leading, spacing: .zero) {
            show(title: timeSectionTitle)
            CheckboxView(type: .morning, isOn: morningBinding)
            CheckboxView(type: .afternoon, isOn: afternoonBinding)
            CheckboxView(type: .evening, isOn: eveningBinding)
            CheckboxView(type: .night, isOn: atNightBinding)
        }
    }
    
    var connectionSectionView: some View {
        VStack(alignment: .leading, spacing: .zero) {
            show(title: connectionSectionTitle)
            RadioButtonView(isOn: withTransfersBinding)
        }
    }
    
    var buttonView: some View {
        Button {
            viewModel.saveFilter()
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(buttonTitle)
                .setCustomButton(padding: .horizontal)
        }
    }
}

// MARK: - Private methods
private extension FilterView {
    func show(title: String) -> some View {
        Text(title)
            .font(AppFonts.Bold.medium)
            .padding(AppSizes.Spacing.large)
    }
    
}

private extension FilterView {
    var morningBinding: Binding<Bool> {
        Binding(
            get: { self.viewModel.currentFilter.isMorning },
            set: { newValue in
                self.viewModel.currentFilter = Filter(
                    isWithTransfers: self.viewModel.currentFilter.isWithTransfers,
                    isAtNight: self.viewModel.currentFilter.isAtNight,
                    isMorning: newValue,
                    isAfternoon: self.viewModel.currentFilter.isAfternoon,
                    isEvening: self.viewModel.currentFilter.isEvening
                )
            }
        )
    }
    
    var afternoonBinding: Binding<Bool> {
        Binding(
            get: { self.viewModel.currentFilter.isAfternoon },
            set: { newValue in
                self.viewModel.currentFilter = Filter(
                    isWithTransfers: self.viewModel.currentFilter.isWithTransfers,
                    isAtNight: self.viewModel.currentFilter.isAtNight,
                    isMorning: self.viewModel.currentFilter.isMorning,
                    isAfternoon: newValue,
                    isEvening: self.viewModel.currentFilter.isEvening
                )
            }
        )
    }
    
    var eveningBinding: Binding<Bool> {
        Binding(
            get: { self.viewModel.currentFilter.isEvening },
            set: { newValue in
                self.viewModel.currentFilter = Filter(
                    isWithTransfers: self.viewModel.currentFilter.isWithTransfers,
                    isAtNight: self.viewModel.currentFilter.isAtNight,
                    isMorning: self.viewModel.currentFilter.isMorning,
                    isAfternoon: self.viewModel.currentFilter.isAfternoon,
                    isEvening: newValue
                )
            }
        )
    }
    
    var atNightBinding: Binding<Bool> {
        Binding(
            get: { self.viewModel.currentFilter.isAtNight },
            set: { newValue in
                self.viewModel.currentFilter = Filter(
                    isWithTransfers: self.viewModel.currentFilter.isWithTransfers,
                    isAtNight: newValue,
                    isMorning: self.viewModel.currentFilter.isMorning,
                    isAfternoon: self.viewModel.currentFilter.isAfternoon,
                    isEvening: self.viewModel.currentFilter.isEvening
                )
            }
        )
    }
    
    var withTransfersBinding: Binding<Bool> {
        Binding(
            get: { self.viewModel.currentFilter.isWithTransfers },
            set: { newValue in
                self.viewModel.currentFilter = Filter(
                    isWithTransfers: newValue,
                    isAtNight: self.viewModel.currentFilter.isAtNight,
                    isMorning: self.viewModel.currentFilter.isMorning,
                    isAfternoon: self.viewModel.currentFilter.isAfternoon,
                    isEvening: self.viewModel.currentFilter.isEvening
                )
            }
        )
    }
}


