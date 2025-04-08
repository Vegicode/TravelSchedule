//
//  FilterViewModel.swift
//  Travel Schedule
//
//  Created by Mac on 12.03.2025.
//
import SwiftUI
@MainActor


final class FilterViewModel: ObservableObject {
    //var filter: [Filter] = []
    var viewModelFilter: Filter
    @State var currentFilter = Filter()
    
    init(viewModelFilter: Filter, currentFilter: Filter = Filter()) {
        self.viewModelFilter = viewModelFilter
        self.currentFilter = currentFilter
    }
        var morningBinding: Binding<Bool> {
            Binding(
                get: { self.currentFilter.isMorning },
                set: { newValue in
                    self.currentFilter = Filter(
                        isWithTransfers: self.currentFilter.isWithTransfers,
                        isAtNight: self.currentFilter.isAtNight,
                        isMorning: newValue,
                        isAfternoon: self.currentFilter.isAfternoon,
                        isEvening: self.currentFilter.isEvening
                    )
                }
            )
        }
        
        var afternoonBinding: Binding<Bool> {
            Binding(
                get: { self.currentFilter.isAfternoon },
                set: { newValue in
                    self.currentFilter = Filter(
                        isWithTransfers: self.currentFilter.isWithTransfers,
                        isAtNight: self.currentFilter.isAtNight,
                        isMorning: self.currentFilter.isMorning,
                        isAfternoon: newValue,
                        isEvening: self.currentFilter.isEvening
                    )
                }
            )
        }
        
        var eveningBinding: Binding<Bool> {
            Binding(
                get: { self.currentFilter.isEvening },
                set: { newValue in
                    self.currentFilter = Filter(
                        isWithTransfers: self.currentFilter.isWithTransfers,
                        isAtNight: self.currentFilter.isAtNight,
                        isMorning: self.currentFilter.isMorning,
                        isAfternoon: self.currentFilter.isAfternoon,
                        isEvening: newValue
                    )
                }
            )
        }
        
        var atNightBinding: Binding<Bool> {
            Binding(
                get: { self.currentFilter.isAtNight },
                set: { newValue in
                    self.currentFilter = Filter(
                        isWithTransfers: self.currentFilter.isWithTransfers,
                        isAtNight: newValue,
                        isMorning: self.currentFilter.isMorning,
                        isAfternoon: self.currentFilter.isAfternoon,
                        isEvening: self.currentFilter.isEvening
                    )
                }
            )
        }
        
        var withTransfersBinding: Binding<Bool> {
            Binding(
                get: { self.currentFilter.isWithTransfers },
                set: { newValue in
                    self.currentFilter = Filter(
                        isWithTransfers: newValue,
                        isAtNight: self.currentFilter.isAtNight,
                        isMorning: self.currentFilter.isMorning,
                        isAfternoon: self.currentFilter.isAfternoon,
                        isEvening: self.currentFilter.isEvening
                    )
                }
            )
        }
    
    
 
    func loadFilter() {
        currentFilter = viewModelFilter
    }
    
    func saveFilter() {
        viewModelFilter = currentFilter
    }
    
    
    
}
