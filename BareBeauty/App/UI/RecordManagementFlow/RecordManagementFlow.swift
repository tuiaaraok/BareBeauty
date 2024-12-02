import SwiftUI

@available(iOS 17.0, *)
struct RecordManagementFlow: View {
    @State var navigationPath: [Screens] = []
    
    @available(iOS 17.0, *)
    var body: some View {
        NavigationStack(path: $navigationPath) {
            RecordManagerScreen(navigationPath: $navigationPath)
            .navigationDestination(for: Screens.self) { screen in
                switch screen {
                case .clientSelection:
                    ClientSelectionScreen(navigationPath: $navigationPath)
                case .addClient:
                    AddClientScreen(navigationPath: $navigationPath)
                case .addEntrie(let clientId):
                    AddEntrieScreen(navigationPath: $navigationPath, clientId: clientId)
                }
            }
        }
        
    }
}

enum Screens: Hashable {
    case clientSelection
    case addClient
    case addEntrie(UUID)
}


