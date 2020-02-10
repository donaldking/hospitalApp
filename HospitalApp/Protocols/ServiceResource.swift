//
//  ServiceResource.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

public protocol ServiceResource {
    associatedtype T
    var url: URL { get }
    func parse(data: Data, success: @escaping () -> Void, failure: @escaping () -> Void)
}
