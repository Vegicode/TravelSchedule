
import Foundation

struct Filter: Hashable {
    var isWithTransfers = true
    var isAtNight = true
    var isMorning = true
    var isAfternoon = true
    var isEvening = true
}

extension Filter {
    static let fullSearch = Filter()
}
