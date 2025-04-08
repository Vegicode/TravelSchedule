
import Foundation

// MARK: - Model structure
struct Story: Identifiable {
    let id = UUID()
    let imageName: String
    var isShowed: Bool = false
    let title: String
    let storyPages: [StoryPage]
}
