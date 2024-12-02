import SwiftUI

@available(iOS 16.0, *)
struct SaveButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Save")
                .customFont(.saveButtonText)
                .foregroundStyle(.white)
                .padding(EdgeInsets(top: 7, leading: 48, bottom: 7, trailing: 48))
                .background(Color.buttons)
                .cornerRadius(20)
        }
    }
}
