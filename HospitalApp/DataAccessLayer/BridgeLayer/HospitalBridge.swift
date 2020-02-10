//
//  HospitalBridge.swift
//  HospitalApp
//
//  Created by Donald King on 08/02/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

struct HospitalBridge {
    // Bridge should NEVER EVER hold a reference to the DTO's data or instance.
    // Access to DTO's data should be via a fresh request! using the DataAccessHelper of the Bridging Type
    
    static func save(hospital: inout Hospital) throws {
        let hospitalDto = toHospitalDto(hospital: hospital)
        _ = try HospitalDataAccessHelper.insert(item: hospitalDto)
    }
    
    static func save(hospitals: inout [Hospital]) throws {
        for var hospital in hospitals {
            _ = try save(hospital: &hospital)
        }
    }
    
    static func delete(hospital: Hospital) throws {
        let hospitalDto = toHospitalDto(hospital: hospital)
        try HospitalDataAccessHelper.delete(item: hospitalDto)
    }
    
    static func retrieve(organisationID: String) throws -> Hospital? {
        guard let hospitalDto = try HospitalDataAccessHelper.find(organisationID: organisationID) else { return nil }
        
        return toHospital(hospitalDto: hospitalDto)
    }
    
    static func filter(by option: FilterOption, value: String) {
        let keyPath = filterOptionToKeyPath(option: option)
        _ = try? HospitalDataAccessHelper.filter(by: keyPath, value: value)
    }
    
    static func resetFilter() {
        HospitalDataAccessHelper.resetFilter()
    }
    
    static func allHospitals() -> [Hospital]? {
        guard let hospitalDtos = try? HospitalDataAccessHelper.findAll() else { return nil }
        
        return hospitalDtos.map(Hospital.init)
    }

    static func hospitalAt(index: Int) -> Hospital? {
        guard let hospitalDto = try? HospitalDataAccessHelper.find(at: index) else { return nil }
        
        return toHospital(hospitalDto: hospitalDto)
    }
    
    // MARK: - Private methods
    static private func filterOptionToKeyPath(option: FilterOption) -> KeyPath<HospitalDto, String?>  {
        switch option {
        case .sector:
            return \HospitalDto.sector
        case .subType:
            return \HospitalDto.subType
        }
    }
    
    static private func toHospitalDto(hospital: Hospital) -> HospitalDto {
        return HospitalDto(organisationID: hospital.organisationID,
                           organisationCode: hospital.organisationCode,
                           organisationType: hospital.organisationType,
                           subType: hospital.subType,
                           sector: hospital.sector,
                           organisationStatus: hospital.organisationStatus,
                           isPimsManaged: hospital.isPimsManaged,
                           organisationName: hospital.organisationName,
                           address1: hospital.address1,
                           address2: hospital.address2,
                           address3: hospital.address3,
                           city: hospital.city,
                           county: hospital.county,
                           postcode: hospital.postcode,
                           latitude: hospital.latitude,
                           longitude: hospital.longitude,
                           parentODSCode: hospital.parentODSCode,
                           parentName: hospital.parentName,
                           phone: hospital.phone,
                           email: hospital.email,
                           website: hospital.website,
                           fax: hospital.fax)
    }
    
    static private func toHospital(hospitalDto: HospitalDto) -> Hospital {
        return Hospital(organisationID: hospitalDto.organisationID,
                        organisationCode: hospitalDto.organisationCode,
                        organisationType: hospitalDto.organisationType,
                        subType: hospitalDto.subType,
                        sector: hospitalDto.sector,
                        organisationStatus: hospitalDto.organisationStatus,
                        isPimsManaged: hospitalDto.isPimsManaged,
                        organisationName: hospitalDto.organisationName,
                        address1: hospitalDto.address1,
                        address2: hospitalDto.address2,
                        address3: hospitalDto.address3,
                        city: hospitalDto.city,
                        county: hospitalDto.county,
                        postcode: hospitalDto.postcode,
                        latitude: hospitalDto.latitude,
                        longitude: hospitalDto.longitude,
                        parentODSCode: hospitalDto.parentODSCode,
                        parentName: hospitalDto.parentName,
                        phone: hospitalDto.phone,
                        email: hospitalDto.email,
                        website: hospitalDto.website,
                        fax: hospitalDto.fax)
    }
}
