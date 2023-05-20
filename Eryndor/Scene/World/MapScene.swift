//Created by Alexander Skorulis on 22/4/2023.

import Foundation
import GameplayKit
import SpriteKit
import AppKit

class MapScene: SKScene {
    
    let map = MapNode()
    
    let mouseIndicator = SKSpriteNode(color: SKColor.red, size: .init(width: 128 * 0.4, height: 128 * 0.4))
    
    override func didMove(to view: SKView) {
        addChild(map)
        map.xScale = 0.4
        map.yScale = 0.4
        scaleMode = .aspectFill
        
        mouseIndicator.alpha = 0.5
        addChild(mouseIndicator)
    }
    
    func coord(windowPosition: CGPoint) -> Coord {
        let position = CGPoint(x: windowPosition.x, y: size.height - windowPosition.y)
        let adjusted = map.convert(position, from: self)
        let x = map.bottomLayer.tileColumnIndex(fromPosition: adjusted)
        let y = map.bottomLayer.tileRowIndex(fromPosition: adjusted)
        return Coord(x: x, y: y)
    }
    
    func windowPosition(coord: Coord) -> CGPoint {
        let center = map.bottomLayer.centerOfTile(atColumn: coord.x, row: coord.y)
        let adjusted = map.convert(center, to: self)
        let screen = CGPoint(x: adjusted.x, y: size.height - adjusted.y)
        return screen
    }
    
    
    

}
