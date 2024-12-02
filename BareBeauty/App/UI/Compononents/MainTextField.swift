import SwiftUI

@available(iOS 16.0, *)
struct MainTextField: View {
    @Binding var text: String
    var placeholder: String
    var axis: Axis = .horizontal
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        TextField(text: $text, axis: axis) {
            Text(placeholder)
                .italic()
                .customFont(.mainText)
                .foregroundStyle(Color.gray)
        }
        .keyboardType(keyboardType)
        .foregroundStyle(Color.black)
        .customFont(.mainText)
        .padding(EdgeInsets(top: 14, leading: 19, bottom: 15, trailing: 19))
        .frame(maxHeight: 50)
        .background(Color.white)
        .cornerRadius(20)
    }
}
