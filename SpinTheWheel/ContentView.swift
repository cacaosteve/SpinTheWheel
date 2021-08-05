//
//  ContentView.swift
//  SpinTheWheel
//
//  Created by steve on 8/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: GameView()) {
                    ButtonView()
                }
                .navigationBarTitle("Wheel Game", displayMode: .inline)
            }
        }
    }
}

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
      
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .yellow
        
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.backgroundColor = .yellow
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .yellow
        
        navigationBar.standardAppearance = standardAppearance
        navigationBar.compactAppearance = compactAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}

struct ButtonView: View {
    var body: some View {
        Text("Spin the wheel")
            .padding()
            .background(Color.buttonPinkColor)
            .foregroundColor(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
