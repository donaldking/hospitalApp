//
//  HospitalService.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

public class HospitalService: ServiceRequestable, ServiceParsable {
    public typealias T = [Hospital]

    public var endPoint: URL {
        guard let url = URL(string: "https://media.nhschoices.nhs.uk/data/foi/Hospital.csv") else { fatalError("Unable to prepare URL")}
        return url
    }

    public func requestData(completed: @escaping ([Hospital]?) -> Void) {
                DispatchQueue.global().async { [weak self] in
            guard let self = self else { completed(nil); return }
            let task = URLSession.shared.downloadTask(with: self.endPoint) { localURL, urlResponse, error in
                // Load local data if error getting remote data
                if let _ = error {
                    self.loadLocalData {(data) in
                        if let data = data {
                            self.parse(data: data) { (hospitals) in
                                DispatchQueue.main.async {
                                    completed(hospitals)
                                }
                            }
                        } else {
                            completed(nil)
                        }
                    }
                }
                // Check for correct response
                if let urlResponse = urlResponse {
                    let response = urlResponse as! HTTPURLResponse
                    switch (response.statusCode) {
                    case 200 ... 299:
                        if let localURL = localURL {
                            if let data = try? Data(contentsOf: localURL) {
                                self.parse(data: data) { (hospitals) in
                                    DispatchQueue.main.async {
                                        completed(hospitals)
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    completed(nil)
                                }
                            }
                        }
                    default:
                        self.loadLocalData {(data) in
                            DispatchQueue.main.async {
                                completed(nil)
                            }
                        }
                        break
                    }
                }}
            task.resume()
        }
    }

    public func parse(data: Data, completed: @escaping ([Hospital]?) -> Void) {
        DispatchQueue.global().async {
            if let csvString = String(data: data, encoding: .ascii) {
                let csvExtractor = DKCSVExtractor(csv: csvString, delimiter: "¬")
                csvExtractor.getAllHeadersAndRows { (headersAndRows) in
                    if let headersAndRows = headersAndRows {
                        let hospitals = headersAndRows.map(Hospital.init)
                        DispatchQueue.main.async {
                            completed(hospitals)
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completed(nil)
                }
            }
        }
    }

    // MARK: - Private methods
    private func loadLocalData(_ completed:@escaping(Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let fileUrl = Bundle.main.url(forResource: "Hospital", withExtension: "csv") {
                    let data = try Data(contentsOf: fileUrl)
                    DispatchQueue.main.async {
                        completed(data)
                    }
                } else {
                    completed(nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completed(nil)
                }
            }
        }
    }
}
