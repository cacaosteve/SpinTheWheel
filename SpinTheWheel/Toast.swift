import SwiftUI

struct Toast<Content>: View where Content: View {
	@Environment(\.colorScheme) var colorScheme
	@Binding var isPresented: Bool
	var perform: (() -> Void)?
	let timeout: TimeInterval
	@State var offset: CGFloat = 0
	@ViewBuilder var content: () -> Content
	@State var currentOffset: CGFloat = 0
	@State var isPressed: Bool = false {
		didSet { if !isPressed { isPresented = false } }
	}

	var body: some View {
		GeometryReader { proxy in
			content()
				.minimumScaleFactor(0.85)
				.lineLimit(4)
				.padding(style: .standard, 15)
				.frame(maxWidth: .infinity)
				.background(
					Color.clear
						.blurEffect(.systemThickMaterial)
				)
				.outline(color: .label.subtle, cornerRadius: 15, width: 0.5)
				.cornerRadius(15)
				.gesture(
					DragGesture(minimumDistance: 0, coordinateSpace: .global)
						.onChanged { gesture in
							isPressed = true
							let translation = gesture.translation.height
							guard (-10 ... 15).contains(translation) else { return }
							offset = translation
						}
						.onEnded { _ in
							isPressed = false
							offset = 0
						}
				)
				.shadow(color: .separator.light, radius: 0.5, x: 0, y: -0.5)
				.shadow(radius: 0.5, x: 0, y: 0.5)
				.shadow(color: .shadow.subtle, radius: 3.5, x: 0.5, y: 1.5)
				.padding(.top, 32)
				.padding(.horizontal)
				.onAppear {
					currentOffset = -proxy.size.height
				}
		}
		.offset(x: 0, y: isPresented ? offset : currentOffset + offset)
		.ignoresSafeArea()
		.zIndex(9999)
		.opacity(isPresented ? 1 : 0)
		.animation(.spring())
		.transition(.slide)
		.onDisappear(perform: perform)
		.onChange(of: isPresented) { newValue in
			DispatchQueue.main
				.asyncAfter(deadline: .now() + timeout) {
					if !isPressed, newValue {
						isPresented = false
					}
				}
		}
	}
}

extension View {
	@ViewBuilder func toast<Content>(
		isPresented: Binding<Bool>,
		onDismiss perform: (() -> Void)? = .none,
		timeout: TimeInterval = 3,
		offset: CGFloat = 0,
		@ViewBuilder content: @escaping () -> Content
	) -> some View
		where Content: View {
		overlay(
			Toast<Content>(
				isPresented: isPresented,
				perform: perform,
				timeout: timeout,
				offset: offset,
				content: content
			), alignment: .top
		)
	}
}
