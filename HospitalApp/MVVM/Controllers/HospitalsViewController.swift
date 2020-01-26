//
//  HospitalsViewController.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import UIKit

struct HospitalsViewControllerConstants {
    static let hospitalTableViewCell = "hospitalTableViewCell"
    
    @available(*, unavailable, message: "You can only access the static properties of this enum.")
    init(){}
}
struct HospitalsViewControllerSegues {
    static let hospitalDetailsSegue = "toHospitalDetails"
    
    @available(*, unavailable, message: "You can only access the static properties of this enum.")
    init(){}
}

class HospitalsViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private properties
    private let cellHeight = CGFloat(150)
    private let nhsSectorFilter = "NHS Sector"
    private var selectedHospital: Hospital?
    
    // MARK: - Properties
    public var hospitalsViewModel: HospitalsViewModel?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case HospitalsViewControllerSegues.hospitalDetailsSegue:
            guard let selectedHospital = selectedHospital else { fatalError("Unable to get selected hospital") }
            
            let viewController = segue.destination as! HospitalDetailsViewController
            viewController.viewModel = HospitalDetailsViewModel(with: selectedHospital)
        default:
            break
        }
    }
    
    // MARK: IBAction
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        if sender.isOn {
            hospitalsViewModel?.filter(by: nhsSectorFilter)
        } else {
            hospitalsViewModel?.resetFilter()
        }
    }
}

// MARK: - Extensions
// MARK: - UITableview datasource
extension HospitalsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let rows = hospitalsViewModel?.allHospitals()?.count else { return 0 }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let hospital = hospitalsViewModel?.hospital(at: indexPath.row) else { fatalError("Unable to get hospital at index \(indexPath.row)")}
        
        let hospitalCell = tableView.dequeueReusableCell(withIdentifier: HospitalsViewControllerConstants.hospitalTableViewCell,
                                                         for: indexPath) as! HospitalTableViewCell
        
        let hospitalCellViewModel = HospitalTableViewCellViewModel(with: hospital,
                                                                   cellView: hospitalCell)
        hospitalCellViewModel.configure()
        
        return hospitalCell
    }
}

// MARK: - UITableview delegate
extension HospitalsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedHospital = hospitalsViewModel?.hospital(at: indexPath.row)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: HospitalsViewControllerSegues.hospitalDetailsSegue, sender: self)
    }
}

// MARK: - Hospital view model delegate
extension HospitalsViewController: HospitalsViewModelDelegate {
    func hospitalViewModel(_ hospitalViewModel: HospitalsViewModel, didUpdate hospitals: [Hospital]?) {
        self.tableView.reloadData()
    }
}
