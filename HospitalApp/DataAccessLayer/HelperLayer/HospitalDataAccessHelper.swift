//
//  HospitalDataAccessHelper.swift
//  HospitalApp
//
//  Created by Donald King on 08/02/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

struct HospitalDataAccessHelper: DataAccessHelper {
    typealias T = HospitalDto
    static private var parallelCopy: [T] = []
    static private var hospitalDto: [T] = []
    
    // MARK: - Protocol implementation
    static func insert(item: HospitalDto) throws -> T {
        if !hospitalDto.contains(where: { $0.organisationID == item.organisationID }) {
            hospitalDto.append(item)
            parallelCopy.append(item)
            return item
        } else {
            throw DataAccessError.insertError
        }
    }
    
    static func delete(item: HospitalDto) throws {
        if hospitalDto.contains(where: { $0.organisationID == item.organisationID }) {
            hospitalDto.removeAll(where: { $0.organisationID == item.organisationID })
            parallelCopy.removeAll(where: { $0.organisationID == item.organisationID })
        } else {
            throw DataAccessError.deleteError
        }
    }
    
    static func findAll() throws -> [T]? {
        return hospitalDto
    }
    
    static func find(at index: Int) throws -> T? {
        if index < hospitalDto.count {
            return hospitalDto[index]
        } else {
            throw DataAccessError.searchError
        }
    }
    
    static func find(organisationID: String) throws -> T? {
        if let item = hospitalDto.first(where: { $0.organisationID == organisationID }) {
            return item
        } else {
            throw DataAccessError.searchError
        }
    }
    
    static func filter<V>(by keyPath: KeyPath<T, V>, value: String) throws -> [T]? {
        // IMPORTANT: Copy existing data to original copy first
        parallelCopy = hospitalDto
        
        guard let filteredDtos = try? findAll()?.filter( { $0[keyPath: keyPath] as? String == value } ) else { throw DataAccessError.filterError }
        
        hospitalDto = filteredDtos
        return hospitalDto
    }
    
    static func resetFilter() {
        hospitalDto = parallelCopy
    }
}
