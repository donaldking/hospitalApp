//
//  DKCSVExtractor.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//
// Runs in background thread and returns completion in background thread

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
        DispatchQueue.global(qos: .background).async {
            if let csvData = self.csv.first {
                let headers = csvData.split(separator: self.delimiter, maxSplits: Int.max, omittingEmptySubsequences: false).map(String.init)
                completion(headers)
            } else {
                completion(nil)
            }
        }
    }
    
    public func getAllRows(completion: @escaping([String]?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let allRowsWithoutHeader = self.csv.dropFirst()
            let slice = Array<String>(allRowsWithoutHeader)
            completion(slice)
        }
    }
    
    public func getAllHeadersAndRows(completion:@escaping([[String:String]]?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var allHeadersAndRows = [[String:String]]()
            self.getAllHeaders { (allHeaders) in
                if let allHeaders = allHeaders {
                    self.getAllRows { (allRows) in
                        if let allRows = allRows {
                            for row in allRows.enumerated() {
                                let columns = row.element.split(separator: self.delimiter, maxSplits: Int.max, omittingEmptySubsequences: false).map(String.init)
                                var columnAndRowDictionary = [String:String]()
                                for (index, column) in columns.enumerated() {
                                    columnAndRowDictionary[allHeaders[index]] = column
                                }
                                allHeadersAndRows.append(columnAndRowDictionary)
                            }
                            completion(allHeadersAndRows)
                        } else {
                            completion(nil)
                        }
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
}
