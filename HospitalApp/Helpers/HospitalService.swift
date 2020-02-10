//
//  HospitalService.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

public class HospitalService: ServiceResource {
    private var remoteDataDelimiter: String.Element = "¬";
    private var localDataDelimiter: String.Element = "\t"
    
    // MARK: - Protocol implementation
    public typealias T = [Hospital]
    public var url: URL {
        guard let url = URL(string: "https://media.nhschoices.nhs.uk/data/foi/Hospital.csv") else { fatalError("URL is invalid")}
        
        return url
    }
    
    public func parse(data: Data, success: @escaping () -> Void, failure: @escaping () -> Void) {
        if let csvString = String(data: data, encoding: .ascii) {
            let csvExtractor = DKCSVExtractor(csv: csvString, delimiter: self.remoteDataDelimiter)
            csvExtractor.getAllHeadersAndRows { (headersAndRows) in
                
                if let headersAndRows = headersAndRows {
                        var hospitals = headersAndRows.map(Hospital.init)
                        if let _ = try? HospitalBridge.save(hospitals: &hospitals) {
                            success()
                        } else {
                            self.loadLocalData { (data) in
                                if let data = data,
                                    let csvString = String(data: data, encoding: .ascii) {
                                    let csvExtractor = DKCSVExtractor(csv: csvString, delimiter: self.localDataDelimiter)
                                    csvExtractor.getAllHeadersAndRows { (headersAndRows) in
                                        if let headersAndRows = headersAndRows {
                                                var hospitals = headersAndRows.map(Hospital.init)
                                                if let _ = try? HospitalBridge.save(hospitals: &hospitals) {
                                                    success()
                                                } else {
                                                    failure()
                                                }
                                            }
                                        }
                                    } else {
                                    failure()
                                }
                            }
                    }
                }
            }
        }

        // Load fallback data
        else {
            self.loadLocalData { (data) in
                if let data = data,
                    let csvString = String(data: data, encoding: .ascii) {
                    let csvExtractor = DKCSVExtractor(csv: csvString, delimiter: self.localDataDelimiter)
                    csvExtractor.getAllHeadersAndRows { (headersAndRows) in
                        if let headersAndRows = headersAndRows {
                                var hospitals = headersAndRows.map(Hospital.init)
                                if let _ = try? HospitalBridge.save(hospitals: &hospitals) {
                                    success()
                                } else {
                                    failure()
                            }
                        }
                    }
                } else {
                    failure()
                }
            }
        }
    }

    // MARK: - Private methods
    private func loadLocalData(_ completed:@escaping(Data?) -> Void) {
        DispatchQueue.global().async {
            do {
                if let fileUrl = Bundle.main.url(forResource: "Hospital", withExtension: "csv") {
                    let data = try Data(contentsOf: fileUrl)
                    completed(data)
                } else {
                    completed(nil)
                }
            } catch {
                completed(nil)
            }
        }
    }
}
