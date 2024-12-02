import SwiftUI

@available(iOS 16.0, *)
struct MainDatePickerView: View {
    
    @Binding var date: Date
    @Binding var showDatePicker: Bool
    @Binding var isDateSet: Bool
    @Binding var entries: [Entrie]
    
    private let storage = Storage.shared
    
    var body: some View {
        Button(action: {
            withAnimation { showDatePicker.toggle() }
        }) {
            HStack(spacing: 5) {
                if !isDateSet {
                    Text("Choose a date")
                } else {
                    Text(formattedDate(date))
                }
                Image(systemName: "chevron.down")
                    .frame(maxWidth: 20, maxHeight: 20)
            }
            .customFont(.mainText)
            .foregroundColor(.black)
            .padding(.top, 8)
        }
        if showDatePicker {
            DatePicker("Select Deadline", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(.buttons)
                .cornerRadius(10)
                .transition(.opacity)
                .onChange(of: date) { newDate in
                    withAnimation {
                        showDatePicker = false
                        isDateSet = true
                        entries = storage.getEntriesByDate(date: newDate)
                    }
                }
        }
    }
}
