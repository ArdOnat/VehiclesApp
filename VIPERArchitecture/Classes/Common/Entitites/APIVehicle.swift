//
//  VehicleModel.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation

struct GetVehicleListResult: Decodable {
    let poiList: [VehicleInformation]
}

struct VehicleInformation: Decodable {
    let id: Int
    let coordinate: Coordinate
    let state: String
    let type: String
    let heading: Float
}

struct Coordinate: Decodable {
    let latitude: Float
    let longitude: Float
}
