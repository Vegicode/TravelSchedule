
import Foundation

enum ErrorType: Error {
    case serverError
    case connectionError
    
    var description: String {
        switch self {
        case .serverError: return String(localized: "Ошибка сервера")
        case .connectionError: return String(localized: "Нет интернета")
        }
    }
    
    var imageName: String {
        switch self {
        case .serverError: return "serverError"
        case .connectionError: return "noInternet"
        }
    }
}
