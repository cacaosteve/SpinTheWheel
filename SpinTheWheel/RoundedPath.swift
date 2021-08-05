import SwiftUI

struct RoundedPath: Shape {
	var radius: CGFloat = .infinity
	var corners: UIRectCorner = .allCorners
	func path(in rect: CGRect) -> Path {
		Path(
			UIBezierPath(
				roundedRect: rect,
				byRoundingCorners: corners,
				cornerRadii: CGSize(width: radius, height: radius)
			)
			.cgPath
		)
	}
}

extension View {
	func cornerRadius(_ corners: UIRectCorner, _ radius: CGFloat) -> some View {
		clipShape(RoundedPath(radius: radius, corners: corners))
	}
}
