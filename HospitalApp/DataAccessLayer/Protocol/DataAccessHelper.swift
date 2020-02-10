//
//  DataAccessHelper.swift
//  HospitalApp
//
//  Created by Donald King on 08/02/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

enum DataAccessError: Error {
    case datastoreConnectionError
    case insertError
    case deleteError
    case searchError
    case nilInData
    case filterError
}

protocol DataAccessHelper {
    associatedtype T
    static func insert(item: T) throws -> T
    static func delete(item: T) throws -> Void
    static func findAll() throws -> [T]?
}
