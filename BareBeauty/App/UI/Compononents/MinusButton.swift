import Foundation
import SwiftUI

struct MinusButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image("minusButtonIcon")
                .frame(maxWidth: 25, maxHeight: 25)
        }
    }
}
