//
//  RouteViewModel.swift
//  Travel Schedule
//
//  Created by Mac on 12.03.2025.
//


import SwiftUI
@MainActor
final class RouteViewModel: ObservableObject {
    let route: Route
    let carrier: Carrier
    var imageDownloader: ImageDownloader
    @State var carrierIcon = Image(systemName: "nosign.app")
    init(route: Route, carrier: Carrier, imageDownloader: ImageDownloader) {
        self.route = route
        self.carrier = carrier
        self.imageDownloader = imageDownloader
    }
    
}
