//
//  HospitalsViewModel.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

protocol HospitalsViewModelDelegate {
    func hospitalViewModel(_ hospitalViewModel: HospitalsViewModel, didUpdate hospitals: [Hospital]?)
}
class HospitalsViewModel {
    // MARK: - Private properties
    private var originalCopy: [Hospital]?
    private var hospitals: [Hospital]?
    
    // MARK: - Public properties
    var delegate: HospitalsViewModelDelegate?
    
    // MARK: init
    init(hospitals: [Hospital]) {
        self.hospitals = hospitals
        self.originalCopy = hospitals
    }
    
    // MARK: - Public methods
    func allHospitals() -> [Hospital]? {
        return self.hospitals
    }
    
    func hospital(at index: Int) -> Hospital? {
        if let hospitals = hospitals {
            if index < hospitals.count {
                return hospitals[index]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func filter(by key: String) {
        self.hospitals = self.originalCopy?.filter{ $0.sector == key }
        self.delegate?.hospitalViewModel(self, didUpdate: self.hospitals)
    }
    
    func resetFilter() {
        self.hospitals = self.originalCopy
        self.delegate?.hospitalViewModel(self, didUpdate: self.hospitals)
    }
}
