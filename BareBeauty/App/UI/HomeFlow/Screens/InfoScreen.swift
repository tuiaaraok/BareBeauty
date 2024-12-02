import SwiftUI

@available(iOS 16.0, *)
struct InfoScreen: View {
    
    private let storage = Storage.shared
    
    @State private var isShowingMailView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                BackButton()
                    .padding(.leading, 25)
                Spacer()
            }
            .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 62) {
                InfoButtonView(buttonText: "Rate Us", action: { openRate(storage.appId) })
                InfoButtonView(buttonText: "Privacy Policy", action: { openPrivacy(storage.privacyPolicyUrl) })
                InfoButtonView(buttonText: "Contact Us", action: { sendEmail(storage.email) })
            }
            .padding(EdgeInsets(top: 180, leading: 46, bottom: 0, trailing: 0))
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
    
    func openRate(_ appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appId)?action=write-review"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func openPrivacy(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func sendEmail(_ email: String) {
        if let url = URL(string: "mailto:\(email)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}





@available(iOS 16.0, *)
private struct InfoButtonView: View {
    
    let buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .customFont(.infoButtonText)
                .foregroundStyle(.black)
        }
    }
}
