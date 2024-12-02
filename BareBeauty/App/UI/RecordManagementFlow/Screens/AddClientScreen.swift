import SwiftUI

@available(iOS 16.0, *)
struct AddClientScreen: View {
    @Binding var navigationPath: [Screens]
    
    @State private var name = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    private let storage = Storage.shared
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            CancelButton(navigationPath: $navigationPath)
            
            VStack(spacing: 20) {
                MainTextField(text: $name, placeholder: "Full name")
                MainTextField(text: $email, placeholder: "Email", keyboardType: .emailAddress)
                MainTextField(text: $phoneNumber, placeholder: "Phone number", keyboardType: .phonePad)
            }
            .padding(EdgeInsets(top: 30, leading: 25, bottom: 0, trailing: 25))
            
            Spacer()
            
            SaveButton(action: saveClientAndNavigateToAddEnrtieScreen)
                .padding(.bottom, 130)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func saveClientAndNavigateToAddEnrtieScreen() {
        let client = Client(
            name: name,
            phoneNumber: phoneNumber,
            email: email
        )
        storage.saveClient(client: client)
        navigationPath.append(Screens.addEntrie(client.id))
    }
}


