//
//  HospitalTableViewCell.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import UIKit

class HospitalTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var organisationNameLabel: UILabel!
    @IBOutlet weak var subTypeLabel: UILabel!
    @IBOutlet weak var sectorLabel: UILabel!
    
    // MARK: - View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
