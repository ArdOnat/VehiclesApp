//
//  CountryCoordinate.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

public struct CountryCoordinate {
    
    var p2Lat: Float
    var p1Lon: Float
    var p1Lat: Float
    var p2Lon: Float
    
    init(p2Lat: Float, p1Lon: Float, p1Lat: Float, p2Lon: Float) {
        self.p2Lat = p2Lat
        self.p1Lon = p1Lon
        self.p1Lat = p1Lat
        self.p2Lon = p2Lon
    }
    
}
