//Created by Alexander Skorulis on 22/4/2023.

import Foundation
import GameplayKit
import SpriteKit
import AppKit

class MapScene: SKScene {
    
    let map = MapNode()
    
    override func didMove(to view: SKView) {
        addChild(map)
        map.xScale = 0.4
        map.yScale = 0.4
        scaleMode = .aspectFill
    }
    
    func coord(position: CGPoint) -> Coord {
        let adjusted = map.convert(position, from: self)
        let x = map.bottomLayer.tileColumnIndex(fromPosition: adjusted)
        let y = map.bottomLayer.tileRowIndex(fromPosition: adjusted)
        return Coord(x: x, y: y)
    }
    
    
    

}
