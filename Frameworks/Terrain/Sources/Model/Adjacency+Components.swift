//  Created by Alexander Skorulis on 15/5/2023.

import Foundation

public extension Adjacency {
    
    var components: [Adjacency] {
        var result = sideComponents
        if contains(.cornerTopLeft) {
            result.append(.cornerTopLeft)
        }
        if contains(.cornerTopRight) {
            result.append(.cornerTopRight)
        }
        if contains(.cornerBottomLeft) {
            result.append(.cornerBottomLeft)
        }
        if contains(.cornerBottomRight) {
            result.append(.cornerBottomRight)
        }
        return result
    }
    
    private var sideComponents: [Adjacency] {
        if contains([.top, .bottom, .left, .right]) {
            return [[.bottom, .left], [.top, .right]]
        } else if contains([.top, .bottom, .left]) {
            return [[.bottom, .left], .top]
        } else if contains([.top, .bottom, .right]) {
            return [[.bottom, .right], .top]
        } else if contains([.bottom, .left, .right]) {
            return [[.bottom, .left], .right]
        } else if contains([.top, .left, .right]) {
            return [[.top, .right], .left]
        } else if contains([.top, .bottom]) {
            return [.top, .bottom]
        } else if contains([.top, .right]) {
            return [[.top, .right]]
        } else if contains([.top, .left]) {
            return [[.top, .left]]
        }  else if contains([.bottom, .left]) {
            return [[.bottom, .left]]
        }  else if contains([.bottom, .right]) {
            return [[.bottom, .right]]
        } else if contains([.left, .right]) {
            return [.left, .right]
        } else if contains(.top) {
            return [.top]
        } else if contains(.bottom) {
            return [.bottom]
        } else if contains(.left) {
            return [.left]
        } else if contains(.right) {
            return [.right]
        }
        return []
    }
    
}
