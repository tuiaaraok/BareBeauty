import Foundation
import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var back
    
    var body: some View {
        Button(action: {
            back()
        }) {
            Image("backButtonIcon")
                .frame(maxWidth: 33, maxHeight: 33)
        }
    }
}
