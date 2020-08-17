//
//  VehicleModel.swift
//  VIPERArchitectureProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

class VehicleModel {
    
    var id: Int
    var coordinate: Coordinate
    var state: String
    var type: VehicleType
    var heading: Float
    
    public init (fromVehicleInformation vehicleInformation: VehicleInformation) {
        self.id = vehicleInformation.id
        self.coordinate = vehicleInformation.coordinate
        self.state = vehicleInformation.state
        self.type = VehicleType(rawValue: vehicleInformation.type) ?? .OTHER
        self.heading = vehicleInformation.heading
    }
    
}
