//
//  ResponseFetcher.swift
//  SpinTheWheel
//
//  Created by steve on 8/4/21.
//

import SwiftUI

public class ResponseFetcher: ObservableObject {
    @Published var responses = [ResponseElement]()
    @Published var showingAlert = false
    
    public init() {
        startLoad()
    }
    
    func startLoad() {
        let httpUrl = "https://mockbin.org/bin/dc24c4de-102f-49bf-9c80-9ed52d4ea7f6"
        guard let url = URL(string: httpUrl) else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.showingAlert = true
                return
            }
               DispatchQueue.main.async {
                do {
                    let decoder = JSONDecoder()
                    self.responses = try decoder.decode(Response.self, from: data!)
                }
                catch {
                    self.showingAlert = true
                    print("Failed to read JSON data: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
