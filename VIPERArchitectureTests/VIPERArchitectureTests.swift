//
//  VIPERArchitectureTests.swift
//  VIPERArchitectureTests
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import XCTest
@testable import VIPERArchitecture

class VIPERArchitectureTests: XCTestCase {
    private weak var SUT: MockVehicleListModuleBuilder?
    private weak var weakVC: VehicleListViewController?
    
    override func tearDown() {
        super.tearDown()
        
        // MARK: Check retain cycle
        assertNoMemoryLeaks()
    }
    
    private func assertNoMemoryLeaks() {
        XCTAssertNil(weakVC)
        XCTAssertNil(SUT)
    }
    
    func testCreateModuleRetainCycle() {
        let vc = makeViewController()
        let sut = makeSUT(withViewController: vc)
        
        sut.createModule()
    }
    
    func makeSUT(withViewController vc: VehicleListViewController) -> MockVehicleListModuleBuilder {
        let interactor = VehicleListInteractor()
        let router = VehicleListRouter()
        let sut = MockVehicleListModuleBuilder(vc: vc, interactor: interactor, router: router)
        self.SUT = sut
        
        return sut
    }
    
    func makeViewController() -> VehicleListViewController {
        let vc = VehicleListViewController()
        vc.loadViewIfNeeded()
        self.weakVC = vc
        
        return vc
    }

}
