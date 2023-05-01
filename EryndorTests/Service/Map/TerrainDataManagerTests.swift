//Created by Alexander Skorulis on 1/5/2023.

@testable import Eryndor
import Foundation
import XCTest

final class TerrainDataManagerTests: XCTestCase {
    
    private let ioc = IOC()
    private lazy var sut = ioc.resolve(TerrainDataManager.self)
    
    func test_blockCreation() async {
        let b1 = await sut.block(for: .zero)
        let b2 = await sut.block(for: .init(x: 1, y: 1))
        
        XCTAssertEqual(b1.id, b2.id)
    }
    
}
