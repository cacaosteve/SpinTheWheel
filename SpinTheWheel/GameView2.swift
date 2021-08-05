//
//  ContentView.swift
//  SpinTheWheel
//
//  Created by steve on 8/3/21.
//

import SwiftUI

struct GameView2: View {
    @State private var degrees = 0.0
    
    var body: some View {
        ZStack {
//            Color.backgroundColor
//                .ignoresSafeArea()
            VStack{
                Image("wheelOfFortune")
                    .resizable()
                    .frame(width: 400.0, height: 400.0)
                    .rotationEffect(.degrees(degrees))
                
                Button("Spin") {
                    let d = Double.random(in: 720...7200)
                    let baseAnimation =
                    Animation.easeInOut(duration: d / 360)
                    withAnimation (baseAnimation) {
                        self.degrees += d
                    }
                }
                .buttonStyle(SpinButton())
                
                //            Button("Spin") {
                //                let d = Double.random(in: 720...7200)
                //                let baseAnimation =
                //                Animation.easeInOut(duration: d / 360)
                //                withAnimation (baseAnimation) {
                //                    self.degrees += d
                //                }
                //            }
            }
        }
    }
}

struct SpinButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.buttonPinkColor)
            .foregroundColor(Color.black)
    }
}


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView2()
    }
}
