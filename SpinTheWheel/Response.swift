//
//  Response.swift
//  SpinTheWheel
//
//  Created by steve on 8/4/21.
//

import Foundation

// MARK: - ResponseElement
struct ResponseElement: Codable, Equatable {
    let id, displayText: String?
    let value: Int?
    let currency: String?
}

typealias Response = [ResponseElement]
