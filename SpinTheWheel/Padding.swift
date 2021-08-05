import SwiftUI

enum PaddingStyle {
	case standard, wide, pan
}

extension View {
	/// Semantic padding for views.
	/// - sizes: 1, 4.5, 8, 11.5, 15, 18.5...((multiples of 3.5) + 1)
	@ViewBuilder func padding(
		vertical: Edge.Set = .vertical,
		horizontal: Edge.Set = .horizontal,
		style: PaddingStyle = .wide,
		_ amount: CGFloat = 8
	) -> some View {
		switch style {
		case .standard:
			padding(horizontal, amount / 0.76)
				.padding(vertical, amount)
		case .wide:
			padding(horizontal, amount)
				.padding(vertical, amount / 1.5)
		case .pan:
			padding(horizontal, amount)
				.padding(vertical, amount / 2)
		}
	}
}
