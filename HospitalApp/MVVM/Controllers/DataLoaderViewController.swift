//
//  DataLoaderViewController.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import UIKit

class DataLoaderViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var dataLoaderView: DataLoaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
    }
    
    // MARK: - Private methods
    private func loadData() {
        print("Load data here...")
    }
}
