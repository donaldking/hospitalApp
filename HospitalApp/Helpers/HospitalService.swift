//
//  HospitalService.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

public class HospitalService {
    
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
