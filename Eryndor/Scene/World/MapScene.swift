//Created by Alexander Skorulis on 22/4/2023.

import Foundation
import SpriteKit
import AppKit

class MapScene: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        addBox(location: .init(x: 50, y: 50))
        
    }
    
    
    
    override func touchesBegan(with event: NSEvent) {
        let location = event.location(in: self)
        addBox(location: location)
    }
    
    private func addBox(location: CGPoint) {
        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }

}
