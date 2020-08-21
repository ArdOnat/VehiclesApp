//
//  VehicleLocationModuleBuilder.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

class VehicleLocationModuleBuilder: VehicleLocationModuleBuilderProtocol {
    
    func createModule() -> UINavigationController {
        let viewController = VehicleLocationViewController()
        let interactor = VehicleLocationInteractor()
        let router = VehicleLocationRouter()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter = VehicleLocationPresenter(view: WeakRef(viewController), interactor: interactor, router :router)
        
        interactor.presenter = WeakRef(presenter)
        
        viewController.presenter = presenter
        
        return navigationController
    }
    
}

extension WeakRef: VehicleLocationInteractorToPresenterProtocol where T: VehicleLocationInteractorToPresenterProtocol {
    
    func fetchVehiclesSuccess(vehicles: [VehicleModel]) {
        object?.fetchVehiclesSuccess(vehicles: vehicles)
    }
    
    func fetchVehiclesFailure(error: Error) {
        object?.fetchVehiclesFailure(error: error)
    }
    
}

extension WeakRef: VehicleLocationPresenterToViewProtocol where T: VehicleLocationPresenterToViewProtocol {
    
    func setupUI() {
        object?.setupUI()
    }
    
    func onFetchVehiclesFailure(error: String) {
        object?.onFetchVehiclesFailure(error: error)
    }
    
    func onFetchVehiclesSuccess(vehicles: [VehicleModel]) {
        object?.onFetchVehiclesSuccess(vehicles: vehicles)
    }
    
}
