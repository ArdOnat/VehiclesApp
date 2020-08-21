//
//  MockVehicleListModuleBuilder.swift
//  VIPERArchitectureTests
//
//  Created by Arda Onat on 21.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit
import XCTest
@testable import VIPERArchitecture

class MockVehicleListModuleBuilder: VehicleListModuleBuilderProtocol {
    
    var vc: VehicleListViewController!
    var interactor: VehicleListInteractor!
    var router: VehicleListRouter!
    
    init (vc: VehicleListViewController, interactor: VehicleListInteractor, router: VehicleListRouter) {
        self.vc = vc
        self.interactor = interactor
        self.router = router
    }
    
    func createModule() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc!)
        
        XCTAssertNotNil(vc)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        
        let presenter = VehicleListPresenter(view: WeakRef(vc), interactor: interactor, router: router)
        
        return navigationController
    }
    
    func createModuleWithRetainCycle() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc!)
        
        XCTAssertNotNil(vc)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        
        let presenter = VehicleListPresenter(view: vc!, interactor: interactor!, router: router!)
        presenter.view = vc
        vc?.presenter = presenter
        
        return navigationController
    }
    
}
