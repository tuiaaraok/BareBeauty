import SwiftUI

struct RoundedCorner: Shape {
    private let radius: CGFloat
    private let corners: UIRectCorner

    init(
        radius: CGFloat = .infinity,
        corners: UIRectCorner = .allCorners
    ) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
