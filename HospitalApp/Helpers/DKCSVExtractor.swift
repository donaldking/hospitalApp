//
//  DKCSVExtractor.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

struct DKCSVExtractor {
    // MARK: - Private properties
    private let returnNewline = String.Element("\r\n")
    private var delimiter: String.Element
    private var csv: [String]
    
    // MARK: - init
    init(csv: String, delimiter: String.Element) {
        self.delimiter = delimiter
        self.csv = csv.split(separator: returnNewline).map(String.init)
    }
    
    // MARK: - Public methods
    public func getAllHeaders(completion: @escaping([String]?) -> Void) {
        DispatchQueue.global().async {
            if let csvData = self.csv.first {
                let headers = csvData.split(separator: self.delimiter, maxSplits: Int.max, omittingEmptySubsequences: false).map(String.init)
                DispatchQueue.main.async {
                    completion(headers)
                }
            }
            else {
                completion(nil)
            }
        }
    }
    
    public func getAllRows(completion: @escaping([String]?) -> Void) {
        DispatchQueue.global().async {
            let allRowsWithoutHeader = self.csv.dropFirst()
            let slice = Array<String>(allRowsWithoutHeader)
            DispatchQueue.main.async {
                completion(slice)
            }
        }
    }
}
