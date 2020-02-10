//
//  Webservice.swift
//  HospitalApp
//
//  Created by Donald King on 07/02/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

public class Webservice {
    static public func download<T: ServiceResource>(resource: T, success: @escaping () -> Void, failure: @escaping () -> Void)  {
        URLSession.shared.downloadTask(with: resource.url) { (localUrl, response, error) in
            guard let localUrl = localUrl else { failure(); return }

                let data = try! Data(contentsOf: localUrl)
                self.parseDataToResource(data: data, resource: resource, success: {
                    success()
                }) {
                    failure()
                }
        }.resume()
    }
    
    static public func load<T: ServiceResource>(resource: T, success: @escaping () -> Void, failure: @escaping () -> Void) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            guard let data = data else { failure(); return }
            
            self.parseDataToResource(data: data, resource: resource, success: {
                success()
            }) {
                failure()
            }
            
        }.resume()
    }
    
    // MARK: - Private methods
    static private func parseDataToResource<T: ServiceResource>(data: Data, resource: T, success: @escaping () -> Void, failure: @escaping () -> Void) {
        resource.parse(data: data, success: {
            DispatchQueue.main.async {
                success()
            }
        }) {
            DispatchQueue.main.async {
                failure()
            }
        }
    }
}
