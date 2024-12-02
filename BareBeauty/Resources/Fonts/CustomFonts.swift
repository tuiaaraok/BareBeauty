import Foundation
import SwiftUI

enum CustomFonts: String {
    case futura = "Futura"
}

struct FontBuilder {
    
    let font: Font
    let tracking: Double
    let lineSpacing: Double
    let verticalPadding: Double
    
    init(
        customFont: CustomFonts,
        fontSize: Double,
        weight: Font.Weight = .regular,
        letterSpacing: Double = 0,
        lineHeight: Double
    ) {
        self.font = Font.custom(customFont, size: fontSize).weight(weight)
        self.tracking = fontSize * letterSpacing

        let uiFont = UIFont(name: customFont.rawValue, size: fontSize) ?? .systemFont(ofSize: fontSize)
        self.lineSpacing = lineHeight - uiFont.lineHeight
        self.verticalPadding = self.lineSpacing / 2
    }
    
}

extension FontBuilder {
    
    static let analyticsMainText = FontBuilder(
        customFont: .futura,
        fontSize: 32,
        weight: .thin,
        lineHeight: 38
    )
    
    static let analyticsTitleText = FontBuilder(
        customFont: .futura,
        fontSize: 18,
        weight: .thin,
        lineHeight: 21
    )
    
    static let portfolioItemText = FontBuilder(
        customFont: .futura,
        fontSize: 10,
        weight: .thin,
        lineHeight: 12
    )
    
    static let materialsScreenMainText = FontBuilder(
        customFont: .futura,
        fontSize: 14,
        weight: .thin,
        lineHeight: 19
    )
    
    static let saveButtonText = FontBuilder(
        customFont: .futura,
        fontSize: 20,
        weight: .thin,
        lineHeight: 30
    )
    
    static let infoButtonText = FontBuilder(
        customFont: .futura,
        fontSize: 38,
        weight: .thin,
        lineHeight: 48
    )
    
    static let mainText = FontBuilder(
        customFont: .futura,
        fontSize: 14,
        weight: .thin,
        lineHeight: 21
    )
}

extension Font {
    static func custom(_ fontName: CustomFonts, size: Double) -> Font {
        Font.custom(fontName.rawValue, size: size)
    }
}


@available(iOS 16.0, *)
struct CustomFontsModifire: ViewModifier {

    private let fontBuilder: FontBuilder

    init(_ fontBuilder: FontBuilder) {
        self.fontBuilder = fontBuilder
    }

    func body(content: Content) -> some View {
        content
            .font(fontBuilder.font)
            .lineSpacing(fontBuilder.lineSpacing)
            .padding([.vertical], fontBuilder.verticalPadding)
            .tracking(fontBuilder.tracking)
    }

}

@available(iOS 16.0, *)
extension View {
    func customFont(_ fontBuilder: FontBuilder) -> some View {
        modifier(CustomFontsModifire(fontBuilder))
    }
}

