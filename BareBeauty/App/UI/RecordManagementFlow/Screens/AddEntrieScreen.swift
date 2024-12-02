import SwiftUI

@available(iOS 17.0, *)
struct AddEntrieScreen: View {
    @Binding var navigationPath: [Screens]
    
    let clientId: UUID
    
    @State private var client = Client(name: "", phoneNumber: "", email: "")
    @State private var typeOfRemoval = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var cost = 0
    
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    private let storage = Storage.shared
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            CancelButton(navigationPath: $navigationPath)
            
            ClientTextFieldStack(name: client.name, email: client.email, phoneNumber: client.phoneNumber)
                .padding(EdgeInsets(top: 30, leading: 25, bottom: 0, trailing: 25))
            
            VStack(spacing: 20) {
                MainTextField(text: $typeOfRemoval, placeholder: "Type of hair removal")
                
                HStack(spacing: 18) {
                    
                    Button(action: {
                        showTimePicker = false
                        withAnimation { showDatePicker.toggle() }
                    }) {
                        HStack(spacing: 0) {
                            Text(formattedDate(date))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .customFont(.mainText)
                        .padding(19)
                        .frame(maxHeight: 50)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                    
                    
                    Button(action: {
                        showDatePicker = false
                        withAnimation { showTimePicker.toggle() }
                    }) {
                        HStack(spacing: 0) {
                            Text(formattedTime(time))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .customFont(.mainText)
                        .padding(19)
                        .frame(maxHeight: 50)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                }
                
                TextField(value: $cost, formatter: NumberFormatter.currency) {
                    Text("Cost")
                        .italic()
                        .customFont(.mainText)
                        .foregroundStyle(Color.gray)
                }
                .keyboardType(.decimalPad)
                .foregroundStyle(Color.black)
                .customFont(.mainText)
                .padding(EdgeInsets(top: 14, leading: 19, bottom: 15, trailing: 19))
                .frame(maxHeight: 50)
                .background(Color.white)
                .cornerRadius(20)
                
                
                if showDatePicker {
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(.buttons)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .onChange(of: date) {
                            withAnimation {
                                showDatePicker = false
                            }
                        }
                }
                
                if showTimePicker {
                    DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .padding()
                        .background(.buttons)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .onChange(of: time) { _ in
                            withAnimation {
                                showTimePicker = false
                            }
                        }
                }
            }
            .padding(EdgeInsets(top: 20, leading: 25, bottom: 0, trailing: 25))
            
            Spacer()
            
            SaveButton(action: saveEntrieAndNavigateToRecordManagerScreen)
                .padding(.bottom, 60)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.background).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            client = storage.getClientById(id: clientId) ?? Client(name: "", phoneNumber: "", email: "")
        }
    }

    private func saveEntrieAndNavigateToRecordManagerScreen() {
        let entrie = Entrie(
            client: client,
            typeOfRemoval: typeOfRemoval,
            date: date,
            time: time,
            cost: cost
        )
        storage.saveEntrie(entrie: entrie)
        if !navigationPath.isEmpty {
            navigationPath.removeLast(navigationPath.count)
        }
    }
}

@available(iOS 16.0, *)
private struct ClientTextFieldStack: View {
    
    var name: String
    var email: String
    var phoneNumber: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(name)
                .padding(EdgeInsets(top: 14, leading: 19, bottom: 15, trailing: 19))
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
            Text(email)
                .padding(EdgeInsets(top: 14, leading: 19, bottom: 15, trailing: 19))
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
            Text(phoneNumber)
                .padding(EdgeInsets(top: 14, leading: 19, bottom: 15, trailing: 19))
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
        }
        .foregroundStyle(Color.black)
        .customFont(.mainText)
    }
}

private struct NumberFormatter {
    static var currency: Formatter {
        let formatter = Foundation.NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }
}
