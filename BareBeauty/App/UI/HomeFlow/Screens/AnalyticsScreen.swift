import SwiftUI

import SwiftUI

@available(iOS 16.0, *)
struct AnalyticsScreen: View {
    
    @State private var date: Date = Date()
    @State private var showDatePicker = false
    @State private var isDateSet = false
    
    @State private var entries: [Entrie] = []
    
    private let storage = Storage.shared
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack {
                HStack(spacing: 0) {
                    BackButton()
                        .padding(.leading, 25)
                    Spacer()
                }
                .padding(.top, 8)
                MainDatePickerView(date: $date, showDatePicker: $showDatePicker, isDateSet: $isDateSet, entries: $entries)
            }
            
            CardView(title: "Income", mainText: "\(entries.reduce(0) { $0 + $1.cost }) $")
            CardView(title: "Records", mainText: "\(entries.count)")
            

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background( LinearGradient(
            stops: [
                Gradient.Stop(color: Color.buttons, location: 0.25),
                Gradient.Stop(color: Color.background, location: 0.25)
            ],
            startPoint: .top,
            endPoint: .bottom
        ).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            entries = storage.getEntries()
        }
    }
}

@available(iOS 16.0, *)
private struct CardView: View {
    
    var title: String
    var mainText: String
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 14) {
                Text(title)
                    .customFont(.analyticsTitleText)
                    .padding(EdgeInsets(top: 10, leading: 12, bottom: 0, trailing: 0))
                
                Text(mainText)
                    .customFont(.analyticsMainText)
                    .padding(.leading, 12)

                Spacer()
            }
            Spacer()
        }
        .foregroundStyle(Color.black)
        .frame(maxWidth: .infinity, maxHeight: 161)
        .background(Color.white)
        .cornerRadius(20)
        .padding(EdgeInsets(top: 30, leading: 25, bottom: 0, trailing: 25))
    }
}
