
import SwiftUI

struct ErrorView: View {
    @State private var errorType: ErrorType
    
    init(errorType: ErrorType) {
        self.errorType = errorType
    }
    
    var body: some View {
        Image(errorType.imageName)
        Text(errorType.description)
            .font(.boldMedium)
    }
}

#Preview {
    ErrorView(errorType: ErrorType.serverError)
}
