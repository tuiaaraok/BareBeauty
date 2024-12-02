import SwiftUI

@available(iOS 16.0, *)
struct ClientSelectionScreen: View {
    @Binding var navigationPath: [Screens]
    
    @State private var clients: [Client] = []
    
    private let storage = Storage.shared
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            CancelButton(navigationPath: $navigationPath)
            
            AddNewClientButton(action: navigateToAddClientScreen)
                .padding(25)
            
            List {
                Section {
                    ForEach(clients) { client in
                        ClientView(name: client.name, phoneNumber: client.phoneNumber)
                            .listRowBackground(Color.background)
                            .listRowInsets(EdgeInsets(top: 0, leading: 25, bottom: 25, trailing: 25))
                            .onTapGesture {
                                navigationPath.append(Screens.addEntrie(client.id))
                            }
                    }
                }
            }
            .padding(.bottom, 1)
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            clients = storage.getClients()
        }
    }
    private func navigateToAddClientScreen() {
        navigationPath.append(Screens.addClient)
    }
}

@available(iOS 16.0, *)
private struct AddNewClientButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Image("plusButtonIcon")
                    .frame(maxWidth: 25, maxHeight: 25)
                Text("Add a new client")
                    .padding(.leading, 7)
                Spacer()
            }
            .customFont(.mainText)
            .foregroundStyle(.white)
            .padding(EdgeInsets(top: 14, leading: 16, bottom: 15, trailing: 16))
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.buttons)
            .cornerRadius(20)
        }
    }
}

@available(iOS 16.0, *)
private struct ClientView: View {
    
    var name: String
    var phoneNumber: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(name)
            
            Spacer()
            
            Text(phoneNumber)
            
        }
        .customFont(.mainText)
        .foregroundStyle(.black)
        .padding(EdgeInsets(top: 14, leading: 16, bottom: 15, trailing: 16))
        .frame(maxHeight: 50)
        .background(.white)
        .cornerRadius(20)
    }
}
