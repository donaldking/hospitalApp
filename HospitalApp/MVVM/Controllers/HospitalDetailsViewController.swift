//
//  HospitalDetailsViewController.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import UIKit

private enum HospitalDetailsSections: Int {
    case detailsSection
    
    // MARK: - enum init
    init?(_ index: Int) {
        switch index {
        case 0:
            self = .detailsSection
        default:
            return nil
        }
    }
}

class HospitalDetailsViewController: UITableViewController {
    // MARK: - Properties
    public var viewModel: HospitalDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Datasource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = HospitalDetailsSections(indexPath.section)
        let cell = UITableViewCell()
        
        switch section {
        case .detailsSection:
            cell.textLabel?.text = viewModel?.valueForHospital(at: indexPath.row)
        default:
            fatalError("Invalid section")
        }
        return cell
    }
}
