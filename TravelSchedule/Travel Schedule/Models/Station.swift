
import Foundation

// MARK: - Struct
struct Station: Hashable, Identifiable, Sendable {
    let id = UUID()
    let title: String
    let type: String
    let code: String
    let latitude: Double
    let longitude: Double
}
