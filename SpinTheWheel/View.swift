import Introspect
import SwiftUI

extension View {
	func color(_ newValue: Color) -> some View {
		foregroundColor(newValue)
	}

	func backgroundColor(_ color: Color) -> some View {
		background(color)
	}

	func dismissKeyboard() {
		UIApplication.shared.sendAction(
			#selector(
				UIApplication.resignFirstResponder
			), to: nil, from: nil, for: nil
		)
	}

	func outline(
		color: Color = .separator,
		corners: UIRectCorner = .allCorners,
		cornerRadius: CGFloat = 0,
		width: CGFloat = 0.5
	) -> some View {
		overlay(
			RoundedPath(radius: cornerRadius, corners: corners)
				.stroke(color, lineWidth: width)
		)
	}

	func inset(
		color: Color? = .none,
		corners: UIRectCorner = .allCorners,
		cornerRadius: CGFloat = 15
	) -> some View {
		background(
			RoundedPath(radius: cornerRadius, corners: corners)
				.fill(color ?? .secondaryFill)
		)
	}
}

#if canImport(VisualEffects)
	import VisualEffects

	extension View {
		func blurEffect(_ style: UIBlurEffect.Style = .regular) -> some View {
			VisualEffectBlur(blurStyle: style) { self }
		}
	}
#endif

// extension Mirror {
//	func withReflection<T, Result>(
//		with label: String,
//		of type: T.Type = T.self,
//		result: (T) -> Result
//	) -> Result? {
//		for case let (label, value) in children where value is T && label == label {
//			return result(value as! T)
//		}
//		return nil
//	}
// }
