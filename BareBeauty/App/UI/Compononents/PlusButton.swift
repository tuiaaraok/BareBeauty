import Foundation
import SwiftUI

struct PlusButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("plusButtonIcon")
                .frame(maxWidth: 25, maxHeight: 25)
        }
    }
}
