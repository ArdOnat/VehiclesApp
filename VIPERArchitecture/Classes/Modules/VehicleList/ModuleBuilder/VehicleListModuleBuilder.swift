//
//  VehicleListModuleBuilder.swift
//  CaseProject
//
//  Created by Arda Onat on 15.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

class VehicleListModuleBuilder {
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("VehicleListRouter creates the Vehicle List module.")
        let viewController = VehicleListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: VehicleListViewToPresenterProtocol & VehicleListInteractorToPresenterProtocol = VehicleListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = VehicleListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = VehicleListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
}
