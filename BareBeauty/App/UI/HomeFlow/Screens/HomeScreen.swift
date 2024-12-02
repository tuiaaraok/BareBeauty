import SwiftUI

@available(iOS 16.0, *)
struct HomeScreen: View {
    
    var body: some View {
        VStack(spacing: 0) {
            TopBarView()
                .padding(.top, 8)
            
            Image("homeMainIcon")
                .frame(maxWidth: 393, maxHeight: 393)
                .padding(.top, 82)
            
            Spacer()
        }

        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
    }
}

@available(iOS 16.0, *)
private struct TopBarView: View {
    var body: some View {
        HStack(spacing: 0) {
            NavigationLink {
                AnalyticsScreen()
            } label: {
                Image("analyticsButtonIcon")
                    .frame(maxWidth: 37, maxHeight: 34)
                    .padding(.leading, 25)
            }
            
            Spacer()
            
            NavigationLink {
                InfoScreen()
            } label: {
                Image("infoButtonIcon")
                    .frame(maxWidth: 35, maxHeight: 35)
                    .padding(.trailing, 25)
            }
        }
    }
}
