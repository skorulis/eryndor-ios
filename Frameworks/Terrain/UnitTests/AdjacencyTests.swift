//  Created by Alexander Skorulis on 7/5/2023.

import Foundation
import XCTest
import Terrain

public final class AdjacencyTests: XCTestCase {
    
    func testIsValid() {
        XCTAssertTrue(Adjacency.bottom.isValid)
        XCTAssertTrue(Adjacency.cornerTopLeft.isValid)
        
        let adj1: Adjacency = [Adjacency.bottom,Adjacency.cornerBottomLeft]
        XCTAssertFalse(adj1.isValid)
    }
    
    func testComponents() {
        XCTAssertEqual(
            Adjacency.bottom.components,
            [.bottom]
        )
        
        XCTAssertEqual(
            Adjacency(rawValue: 73).components,
            [[.top, .right], .cornerBottomLeft]
        )
        
    }
    
}
