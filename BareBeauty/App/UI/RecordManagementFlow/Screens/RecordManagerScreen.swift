import SwiftUI

@available(iOS 16.0, *)
struct RecordManagerScreen: View {
    @Binding var navigationPath: [Screens]
    
    @State private var date: Date = Date()
    @State private var showDatePicker = false
    @State private var isDateSet = false
    
    @State private var entries: [Entrie] = []
    
    private let storage = Storage.shared
    
    var body: some View {
        
        VStack(spacing: 0) {
            MainDatePickerView(date: $date, showDatePicker: $showDatePicker, isDateSet: $isDateSet, entries: $entries)
            List {
                ForEach(entries) { entrie in
                    EntrieView(entrie: entrie)
                        .listRowBackground(Color.background)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    
                }
                .onDelete { indexSet in
                    entries.remove(atOffsets: indexSet)
                    storage.saveEntries(entries)
                }
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 30, leading: 23, bottom: 0, trailing: 23))
            
            PlusButton(action: navigateClientSelectionScreen)
                .padding(.bottom, 209)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
        .onAppear {
            entries = storage.getEntries()
        }
    }
    private func navigateClientSelectionScreen() {
        navigationPath.append(Screens.clientSelection)
    }
    
}

@available(iOS 16.0, *)
private struct EntrieView: View {
    
    let entrie: Entrie
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(entrie.client.name)
                Spacer()
                Text(formattedDate(entrie.date))
            }
            .padding(.top, 12)
            Divider()
            
            HStack(spacing: 0) {
                Text(entrie.client.phoneNumber)
                Spacer()
                Text(formattedTime(entrie.time))
            }
            .padding(.top, 10)
            Divider()
            
            HStack(spacing: 0) {
                Text(entrie.typeOfRemoval)
                Spacer()
                Text("\(entrie.cost)$")
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 12, trailing: 0))
            
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .customFont(.mainText)
        .background(.white)
        .foregroundStyle(.black)
        .cornerRadius(20)
        
        
    }
}
