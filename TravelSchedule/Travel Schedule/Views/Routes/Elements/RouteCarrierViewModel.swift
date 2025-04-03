//
//  RouteCarrierViewModel.swift
//  Travel Schedule
//
//  Created by Mac on 12.03.2025.
//

import SwiftUI

class RouteCarrierViewModel: ObservableObject {
    
    
    let route: Route
    let carrier: Carrier
    
    
     var connectionInValue: String { "С пересадкой в \(route.connectionStation)" }

    init( route: Route, carrier: Carrier) {
        
        self.route = route
        self.carrier = carrier
    }
}
