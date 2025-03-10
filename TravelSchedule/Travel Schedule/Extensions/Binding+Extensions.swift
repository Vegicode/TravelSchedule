
import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !wrappedValue },
            set: { wrappedValue = !$0 }
        )
    }
}
