//
//  CarrierViewModel.swift
//  Travel Schedule
//
//  Created by Mac on 12.03.2025.
//

import SwiftUI
@MainActor

final class CarrierViewModel: ObservableObject {
   
    let title = "Информация о перевозчике"
    @State var carrier: Carrier
    var imageDownloader: ImageDownloader
    
    init(carrier: Carrier, imageDownloader: ImageDownloader) {
        self.carrier = carrier
        self.imageDownloader = imageDownloader
    }

        enum ContactType {
            case email, phone, contacts

            var title: String {
                switch self {
                    case .email: "E-mail"
                    case .phone: "Телефон"
                    case .contacts: "Контакты"
                }
            }
        }
        var carrierTitle: String { "ОАО «\(carrier.title)»" }
        var emailUrl: String { "mailto:" + carrier.email }
        var phoneUrl: String { "tel:" + carrier.phone }

    
    

    
}
