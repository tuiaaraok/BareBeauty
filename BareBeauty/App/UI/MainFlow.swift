import SwiftUI

enum MainFlowTab {
    case home
    case recordManagement
    case portfolio
    case stocksOfMaterials
}

@available(iOS 17.0, *)
struct MainFlow: View {
    @State var currentTab: MainFlowTab = .home
        
    private let buttons = [
        TabBarButtonConfiguration(title: "Home", tab: .home),
        TabBarButtonConfiguration(title: "Record management", tab: .recordManagement),
        TabBarButtonConfiguration(title: "Portfolio", tab: .portfolio),
        TabBarButtonConfiguration(title: "Stocks of materials", tab: .stocksOfMaterials),
    ]
    
    @available(iOS 17.0, *)
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeFlow()
                    .tag(MainFlowTab.home)
                RecordManagementFlow()
                    .tag(MainFlowTab.recordManagement)
                PortfolioFlow()
                    .tag(MainFlowTab.portfolio)
                StocksOfMaterialsFlow()
                    .tag(MainFlowTab.stocksOfMaterials)
            }
            TabBar(currentTab: $currentTab, buttons: buttons)
        }
        .background(Color.background)
    }
}


@available(iOS 17.0, *)
private struct TabBar: View {
    @Binding var currentTab: MainFlowTab
    let buttons: [TabBarButtonConfiguration]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(buttons.enumerated()), id: \.element.id) { (index, button) in
                let style: TabBarButtonStyle = button.tab == currentTab ? .active : .unactive
                TabBarButton(
                    configuration: button,
                    style: style,
                    roundedCorners: cornerForButton(atIndex: index),
                    action: { currentTab = button.tab }
                )
            }
        }
    }
    
    
    private func cornerForButton(atIndex index: Int) -> UIRectCorner {
        let currentIndex = buttons.firstIndex { $0.id == currentTab }
        guard let currentIndex else { return [] }
        
        if index - 1 == currentIndex {
            return .topLeft
        } else if index + 1 == currentIndex {
            return .topRight
        } else if index == currentIndex {
            return [.topLeft, .topRight]
        } else {
            return []
        }
    }
}

private struct TabBarButtonConfiguration: Identifiable {
    var id: MainFlowTab { tab }
    
    let title: String
    let tab: MainFlowTab
}

private struct TabBarButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    
    static let active = TabBarButtonStyle(backgroundColor: .buttons, foregroundColor: .white)
    static let unactive = TabBarButtonStyle(backgroundColor: .buttons, foregroundColor: .white)
    
}

@available(iOS 17.0, *)
private struct TabBarButton: View {
    let configuration: TabBarButtonConfiguration
    let style: TabBarButtonStyle
    let roundedCorners: UIRectCorner
    let action: () -> Void
    
    var body: some View {
        let height = 56.0
        Button {
            action()
        } label: {
            VStack(spacing: 0) {
                Text(configuration.title)
                    .customFont(.mainText)
                    .lineLimit(2)
            }
            .foregroundColor(Color(style.foregroundColor))
            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height)
            .background(Color(style.backgroundColor))
            .clipShape(RoundedCorner(radius: 10, corners: roundedCorners))
        }
        .background {
            Color(.buttons)
                .padding(.top, height)
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}
