//
//  HospitalsViewModel.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

protocol HospitalsViewModelDelegate {
    func hospitalViewModelDidUpdate()
}
enum FilterOption {
    case sector
    case subType
}

class HospitalsViewModel {
    // MARK: - Public properties
    var delegate: HospitalsViewModelDelegate?
    
    // MARK: - Public methods
    func allHospitals() -> [Hospital]? {
        return HospitalBridge.allHospitals()
    }
    
    func hospital(at index: Int) -> Hospital? {
        return HospitalBridge.hospitalAt(index: index)
    }
    
    func filter(by option: FilterOption, value: String) {
        HospitalBridge.filter(by: option, value: value)
        self.delegate?.hospitalViewModelDidUpdate()
    }

    func resetFilter() {
        HospitalBridge.resetFilter()
        self.delegate?.hospitalViewModelDidUpdate()
    }
}
