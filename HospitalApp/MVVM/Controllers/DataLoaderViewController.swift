//
//  DataLoaderViewController.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import UIKit

private struct DataLoaderViewControllerSegues {
    static let toHospitalsSegue = "toHospitals"
    
    @available(*, unavailable, message: "You can only access the static properties of this enum.")
    init(){}
}

public class DataLoaderViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var dataLoaderView: DataLoaderView!
    
    // MARK: - Private properties
    private var dataLoaderViewModel: DataLoaderViewModel?
    private var hospitalsViewModel: HospitalsViewModel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
    }
    
    // MARK: - Public methods
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DataLoaderViewControllerSegues.toHospitalsSegue {
            let viewController = segue.destination as? HospitalsViewController
            viewController?.navigationItem.setHidesBackButton(true, animated: true)
            viewController?.hospitalsViewModel = self.hospitalsViewModel
            hospitalsViewModel?.delegate = viewController
        }
    }
    
    // MARK: - Private methods
    private func loadData() {
        dataLoaderViewModel = DataLoaderViewModel(dataLoaderView: dataLoaderView,
                                                  service: HospitalService())
        dataLoaderViewModel?.delegate = self
        dataLoaderViewModel?.loadData()
    }
    
    private func navigateToHospitalsViewController() {
        perform(#selector(performSegue(withIdentifier:sender:)), with: DataLoaderViewControllerSegues.toHospitalsSegue, afterDelay: 3)
    }
}

// MARK: - Extensions
extension DataLoaderViewController: DataLoaderViewModelDelegate {
    func dataLoaderViewModel(_ dataLoaderViewModel: DataLoaderViewModel, didFinishLoading data: [Hospital]?) {
        // Create hospital view model here with the hospital array and pass it!!
        if let hospitals = data {
            hospitalsViewModel = HospitalsViewModel(hospitals: hospitals)
            navigateToHospitalsViewController()
        }
    }
}
