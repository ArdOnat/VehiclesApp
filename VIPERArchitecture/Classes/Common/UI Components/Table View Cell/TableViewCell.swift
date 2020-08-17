//
//  TableViewCell.swift
//  CaseProject
//
//  Created by Arda Onat on 15.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var vehicleTypeImageView: UIImageView!
    @IBOutlet weak var vehicleIdLabel: UILabel!
    @IBOutlet weak var vehicleStateImageView: UIImageView!

    public let rowHeight = 60
    
    override func prepareForReuse() {
        super.prepareForReuse()
        vehicleTypeImageView.image = UIImage()
        vehicleIdLabel.text = ""
        vehicleStateImageView.image = UIImage()
    }
    
    func configureActive(deviceInformation: VehicleModel) {
        vehicleTypeImageView.image = UIImage(named: "\(deviceInformation.type)")
        vehicleIdLabel.text = "\(deviceInformation.id)"
        vehicleStateImageView.image = UIImage(named: "ACTIVE")
    }
    
    func configureInactive(deviceInformation: VehicleModel) {
        vehicleTypeImageView.image = UIImage(named: "\(deviceInformation.type)")
        vehicleIdLabel.text = "\(deviceInformation.id)"
        vehicleStateImageView.image = UIImage(named: "INACTIVE")
    }
    
}
