//  Created by Alexander Skorulis on 13/5/2023.

import Foundation

public struct Adjacency: OptionSet, Hashable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let top  = Adjacency(rawValue: 1 << 0)
    public static let bottom  = Adjacency(rawValue: 1 << 1)
    public static let left  = Adjacency(rawValue: 1 << 2)
    public static let right  = Adjacency(rawValue: 1 << 3)
    
    static let all: Adjacency = [.top, .left, .bottom, .right]
    
    public var fileExtension: String {
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
        return result
    }
    
    public static var inputAdjacency: [Adjacency] {
        return [
            .bottom,
            .top,
            .left,
            .right,
            [.top, .left],
            [.top, .right],
            [.bottom, .left],
            [.bottom, .right],
        ]
    }
    
    public static var allOptions: [Adjacency] {
        return (0..<16).map { value in
            return Adjacency(rawValue: value)
        }
    }
    
    public var idOffset: Int {
        return rawValue
    }
}
