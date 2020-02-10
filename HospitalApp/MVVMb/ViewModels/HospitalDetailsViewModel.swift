//
//  HospitalDetailsViewModel.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

class HospitalDetailsViewModel {
    // MARK: - Private properties
    private var hospital: Hospital?
    
    // MARK: - init
    init(with hospital: Hospital) {
        self.hospital = hospital
    }
    
    @available(*, unavailable, message: "Please use the available init method.")
    init(){}
    
    // MARK: - Public methods
    func valueForHospital(at index: Int) -> String? {
        guard let hospital = hospital else { fatalError("Hospital is nil")}
        
        switch index {
        case 0:
            return hospital.organisationName
        case 1:
            return hospital.subType
        case 2:
            return hospital.sector
        case 3:
            return hospital.organisationType
        case 4:
            return hospital.organisationCode
        case 5:
            return hospital.address1
        case 6:
            return hospital.address2
        case 7:
            return hospital.address3
        case 8:
            return hospital.postcode
        case 9:
            return hospital.phone
        default:
            break
        }
        return nil
    }
}
