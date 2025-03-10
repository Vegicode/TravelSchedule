
import Foundation

// MARK: - Model structure
struct StoryPage: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    var description: String
}
