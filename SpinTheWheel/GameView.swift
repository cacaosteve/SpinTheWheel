//
//  ContentView.swift
//  SpinTheWheel
//
//  Created by steve on 8/3/21.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var fetcher = ResponseFetcher()
    
    @State private var isAnimating = false
    @State private var spinDegrees = 0.0
    @State private var rand = 0.0
    @State private var newAngle = 0.0
    
    @State var didUpdate: Bool = false
  
    var spinAnimation: Animation {
        Animation.easeOut(duration: 3.0)
            .repeatCount(1, autoreverses: false)
    }
    
    func getAngle(angle: Double) -> Double {
        let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
        return deg
    }
    
    func sectorFromAngle(angle: Double) -> String {
        var i = 0
        //var sector: Sector = Sector(number: -1, color: .empty)
        var sector: ResponseElement = ResponseElement(id: "", displayText: "", value: -1, currency: "")
        
        while sector == ResponseElement(id: "", displayText: "", value: -1, currency: "") && i < fetcher.responses.count {
            let halfSector = 360.0 / Double(fetcher.responses.count)  / 2.0
            
            let start: Double = halfSector * Double((i*2 + 1)) - halfSector
            let end: Double = halfSector * Double((i*2 + 3))
            
            if(angle >= start && angle < end) {
                sector = fetcher.responses[i]
            }
            i+=1
        }
        return "\(sector.displayText ?? "")"
    }
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            VStack {
                Text(self.isAnimating ? "Spinning" : sectorFromAngle(angle : newAngle))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Image("wheel_ticker")
                PieChart(
                    fetcher.responses
                )
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: spinDegrees))
                    .animation(spinAnimation)
                Button("Spin") {
                    isAnimating = true
                    rand = Double.random(in: 1...360)
                    spinDegrees += 720.0 + rand
                    newAngle = getAngle(angle: spinDegrees)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                        isAnimating = false
                        didUpdate = true
                    }
                }
                .buttonStyle(SpinButton())
                .disabled(isAnimating == true)
            }
            .toast(
                isPresented: $didUpdate,
                onDismiss: { presentationMode.wrappedValue.dismiss() },
                content: {
                    Text(sectorFromAngle(angle : newAngle))
                        .foregroundColor(.black)
                        .padding()
                }
            )
        }
    }
}

struct PieChart: View {
    
    fileprivate var slices: [PieSlice] = []
    
    init(_ values: [ResponseElement]) {
        var colorsArray = [Color]()
        
        for i in 0..<values.count {
            if (i % 2) == 0 {
                colorsArray.append(.lighterBackground)
            }
            else {
                colorsArray.append(.background)
            }
        }
        
        slices = calculateSlices(from: colorsArray)
    }
    
    var body: some View {
        GeometryReader { reader in
            let halfWidth = (reader.size.width / 2)
            let halfHeight = (reader.size.height / 2)
            let radius =  min(halfWidth, halfHeight)
            let center = CGPoint(x: halfWidth, y: halfHeight)
            ZStack(alignment: .center) {
                ForEach(slices, id: \.self) { slice in
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, startAngle: slice.start, endAngle: slice.end, clockwise: false)
                    }
                    .fill(slice.color)
                }
            }
        }
    }
    
    private func calculateSlices(from inputValues: [Color]) -> [PieSlice] {
        guard inputValues.count > 0 else {
            return []
        }
        
        let degreeForOneValue = 360.0 / Double(inputValues.count)
        var currentStartAngle = 0.0
        
        var slices = [PieSlice]()
        inputValues.forEach { inputValue in
            let endAngle = degreeForOneValue + currentStartAngle
            slices.append(PieSlice(start: Angle(degrees: currentStartAngle), end: Angle(degrees: endAngle),color: inputValue))
            currentStartAngle = endAngle
        }

        return slices
    }
}

private struct PieSlice : Hashable {
    var start: Angle
    var end: Angle
    var color: Color
}


struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameView()
        }
    }
}
