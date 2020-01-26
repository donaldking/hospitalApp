//
//  ServiceParsable.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

public protocol ServiceParsable {
    associatedtype T
    func parse(data: Data, completed: @escaping (T?) -> Void)
}
