//
//  RouteViewModel.swift
//  Travel Schedule
//
//  Created by Mac on 12.03.2025.
//

import Foundation

class RouteViewModel: ObservableObject {
    let route: Route
    let carrier: Carrier
    var imageDownloader: ImageDownloader
    
    init(route: Route, carrier: Carrier, imageDownloader: ImageDownloader) {
        self.route = route
        self.carrier = carrier
        self.imageDownloader = imageDownloader
    }
    
}
