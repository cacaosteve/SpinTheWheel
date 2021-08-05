import SwiftUI

extension UIColor {
	static var accent: UIColor { UIColor(named: "AccentColor")! }
}

extension Color {
	var overlay : Color { opacity(0.85) }
	var light   : Color { opacity(0.5) }
	var subtle  : Color { opacity(0.25) }
	var faint   : Color { opacity(0.1) }

	static var accent: Color { Color(.accent) }
	static var background: Color { Color(.systemBackground) }
	static var secondaryBackground: Color { Color(.secondarySystemBackground) }
	static var tertiaryBackground: Color { Color(.tertiarySystemBackground) }
	static var groupedBackground: Color { Color(.systemGroupedBackground) }
	static var secondaryGroupedBackground: Color { Color(.secondarySystemGroupedBackground) }
	static var fill: Color { Color(.systemFill) }
	static var secondaryFill: Color { Color(.secondarySystemFill) }
	static var tertiaryFill: Color { Color(.tertiarySystemFill) }
	static var label: Color { Color(.label) }
	static var secondaryLabel: Color { Color(.secondaryLabel) }
	static var tertiaryLabel: Color { Color(.tertiaryLabel) }
	static var placeholder: Color { Color(.placeholderText) }
	static var shadow: Color { Color(.sRGBLinear, white: 0, opacity: 0.33) }
	static var highlight: Color { Color(.sRGBLinear, white: 1, opacity: 0.33) }
	static var separator: Color { Color(.separator) }
}

extension Color {
    static let backgroundColor = Color("backgroundColor")
    static let buttonPinkColor = Color("buttonPinkColor")
    static let lighterBackground = Color("lighterBackground")
}
