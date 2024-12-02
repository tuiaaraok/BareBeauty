import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct CancelButton: View {
    @Binding var navigationPath: [Screens]
    
    var body: some View {
        
        HStack(spacing: 0) {
            Button(action: {
                if !navigationPath.isEmpty {
                    navigationPath.removeLast(navigationPath.count)
                }
            }) {
                Text("Cancel")
                    .customFont(.mainText)
                    .foregroundStyle(Color.buttonsDeepRed)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 8, leading: 25, bottom: 0, trailing: 0))
    }
}

