//  Created by Alexander Skorulis on 13/5/2023.

import Foundation

public struct Adjacency: OptionSet, Hashable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let top       = Adjacency(rawValue: 1 << 0)
    public static let bottom    = Adjacency(rawValue: 1 << 1)
    public static let left      = Adjacency(rawValue: 1 << 2)
    public static let right     = Adjacency(rawValue: 1 << 3)
    
    public static let cornerTopLeft = Adjacency(rawValue: 1 << 4)
    public static let cornerTopRight = Adjacency(rawValue: 1 << 5)
    public static let cornerBottomLeft = Adjacency(rawValue: 1 << 6)
    public static let cornerBottomRight = Adjacency(rawValue: 1 << 7)
    
    static let all: Adjacency = [.top, .left, .bottom, .right]
    
    public var fileExtension: String {
        if rawValue == 0 {
            return "_Center"
        }
        var result = ""
        if self.contains(Self.top) {
            result += "_Top"
        }
        if self.contains(Self.bottom) {
            result += "_Bottom"
        }
        if self.contains(Self.left) {
            result += "_Left"
        }
        if self.contains(Self.right) {
            result += "_Right"
        }
        if self.contains(Self.cornerTopLeft) {
            result += "_CnrTopLeft"
        }
        if self.contains(Self.cornerTopRight) {
            result += "_CnrTopRight"
        }
        if self.contains(Self.cornerBottomLeft) {
            result += "_CnrBottomLeft"
        }
        if self.contains(Self.cornerBottomRight) {
            result += "_CnrBottomRight"
        }
        return result
    }
    
    public static var inputAdjacency: [Adjacency] {
        return [
            .init(rawValue: 0),
            .bottom,
            .top,
            .left,
            .right,
            [.top, .left],
            [.top, .right],
            [.bottom, .left],
            [.bottom, .right],
            .cornerTopLeft,
            .cornerTopRight,
            .cornerBottomLeft,
            .cornerBottomRight
        ]
    }
    
    public static var allOptions: [Adjacency] {
        return (0..<256).compactMap { value in
            let adj = Adjacency(rawValue: value)
            return adj.isValid ? adj : nil
        }
    }
    
    public var isValid: Bool {
        if contains(.cornerTopLeft) && (contains(.top) || contains(.left)) {
            return false
        }
        if contains(.cornerTopRight) && (contains(.top) || contains(.right)) {
            return false
        }
        if contains(.cornerBottomLeft) && (contains(.bottom) || contains(.left)) {
            return false
        }
        if contains(.cornerBottomRight) && (contains(.bottom) || contains(.right)) {
            return false
        }
        return true
    }
    
    public var idOffset: Int {
        return rawValue
    }
}
