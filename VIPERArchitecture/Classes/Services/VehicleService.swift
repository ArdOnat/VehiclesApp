//
//  VehicleService.swift
//  CaseProject
//
//  Created by Arda Onat on 13.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import Foundation

class VehicleService {
    
    public static func getVehicleList(coordinate: CountryCoordinate, completion: @escaping (Result<GetVehicleListResult, ErrorResponse>) -> ()) {
        
        guard let url = URL(string: "https://poi-api.mytaxi.com/PoiService/poi/v1?" + "p2Lat=\(coordinate.p2Lat)&p1Lon=\(coordinate.p1Lon)&p1Lat=\(coordinate.p1Lat)&p2Lon=\(coordinate.p2Lon)") else {
            completion(.failure(.badURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let _ = error {
                completion(.failure(.httpRequestError))
            }
            else {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        break
                    default:
                        completion(.failure(.httpResponseError))
                    }
                }
                else {
                    completion(.failure(.httpResponseError))
                }
            
                if let data = data {
                    let response = try? JSONDecoder().decode(GetVehicleListResult.self, from: data)
                    
                    if let response = response {
                        completion(.success(response))
                    }
                    else {
                        completion(.failure(.httpResponseError))
                    }
                }
            }
        })
        task.resume()
    }
    
}
