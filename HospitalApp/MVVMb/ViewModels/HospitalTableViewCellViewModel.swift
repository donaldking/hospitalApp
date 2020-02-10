//
//  HospitalTableViewCellViewModel.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

class HospitalTableViewCellViewModel {
    // MARK: - Private properties
    private var hospital: Hospital?
    private var cellView: HospitalTableViewCell?
    
    // MARK: - init
    init(with hospital: Hospital,
         cellView: HospitalTableViewCell) {
        self.hospital = hospital
        self.cellView = cellView
    }
    
    @available(*, unavailable, message: "Please use init:with:hospital cellView:")
    init(){ }
    
    func configure() {
        self.cellView?.organisationNameLabel.text = hospital?.organisationName
        self.cellView?.subTypeLabel.text = hospital?.subType
        self.cellView?.sectorLabel.text = hospital?.sector
    }
}
