//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import SpriteKit

public extension AllTerrain {
    
    var image: NSImage {
        let bundle = Bundle.workaround
        return bundle.image(forResource: filename)!
    }
}
