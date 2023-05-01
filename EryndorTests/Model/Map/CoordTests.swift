//Created by Alexander Skorulis on 1/5/2023.

@testable import Eryndor
import Foundation
import XCTest

final class CoordTests: XCTestCase {
    
    func test_alignment() {
        let c1 = Coord(x: 0, y: 0).align(gridSize: 128)
        XCTAssertEqual(c1.x, 0)
        XCTAssertEqual(c1.y, 0)
        
        let c2 = Coord(x: 10, y: 10).align(gridSize: 128)
        XCTAssertEqual(c2.x, 0)
        XCTAssertEqual(c2.y, 0)
        
        let c3 = Coord(x: -10, y: -10).align(gridSize: 128)
        XCTAssertEqual(c3.x, -128)
        XCTAssertEqual(c3.y, -128)
        
        let c4 = Coord(x: 127, y: 128).align(gridSize: 128)
        XCTAssertEqual(c4.x, 0)
        XCTAssertEqual(c4.y, 128)
        
        let c5 = Coord(x: -129, y: -128).align(gridSize: 128)
        XCTAssertEqual(c5.x, -256)
        XCTAssertEqual(c5.y, -128)
        
        let c6 = Coord(x: -1, y: -1).align(gridSize: 128)
        XCTAssertEqual(c6.x, -128)
        XCTAssertEqual(c6.y, -128)
    }
    
}
