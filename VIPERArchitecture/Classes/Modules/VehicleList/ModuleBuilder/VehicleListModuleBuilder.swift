//
//  VehicleListModuleBuilder.swift
//  CaseProject
//
//  Created by Arda Onat on 15.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

class VehicleListModuleBuilder {
    
    static func createModule() -> UINavigationController {
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
