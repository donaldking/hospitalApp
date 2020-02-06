//
//  DataLoaderViewModel.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

protocol DataLoaderViewModelDelegate: class {
    func dataLoaderViewModel(_ dataLoaderViewModel: DataLoaderViewModel, didFinishLoading data: [Hospital]?)
}

private enum LoadingStatus: String {
    case notLoading
    case loading
    case completedWithData
    case completedWithNoData
    
    var description: String {
        switch self {
        case .notLoading:
            return ""
        case .loading:
            return "Loading data, please wait..."
        case .completedWithData:
            return "Geat!, data downloaded,\ntaking you in..."
        case .completedWithNoData:
            return "Sorry, we are unable to load the data.\nPlease try again later..."
        }
    }
}

public class DataLoaderViewModel {
    // MARK: - Private properties
    private var model: DataLoaderModel = DataLoaderModel(hospitals: [])
    private var service: HospitalService?
    private var dataLoaderView: DataLoaderView?
    private var loadingState: LoadingStatus = .notLoading {
        didSet {
            switch self.loadingState {
            case.notLoading:
                updateLoadingStatus(with: "")
                dataLoaderView?.activityIndicator.stopAnimating()
            case .loading:
                updateLoadingStatus(with: LoadingStatus.loading.description)
                dataLoaderView?.activityIndicator.startAnimating()
            case .completedWithData:
                updateLoadingStatus(with: LoadingStatus.completedWithData.description)
                dataLoaderView?.activityIndicator.stopAnimating()
            case .completedWithNoData:
                updateLoadingStatus(with: LoadingStatus.completedWithNoData.description)
                dataLoaderView?.activityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Public properties
    weak var delegate: DataLoaderViewModelDelegate?
    
    // MARK: - Custom init
    init(dataLoaderView: DataLoaderView,
         service: HospitalService) {
        self.dataLoaderView = dataLoaderView
        self.service = service
    }
    
    @available(*, unavailable, message: "Please use init with model: webService:")
    init() { }
    
    // MARK: - Public methods
    public func loadData() {
        self.loadHospitalData(completed: { [weak self] (hospitals) in
            if let self = self {
                self.loadingState = .loading
                if let hospitals = hospitals {
                    if hospitals.count > 0 {
                        self.model.hospitals = hospitals
                        self.loadingState = .completedWithData
                    } else {
                        self.loadingState = .completedWithNoData
                    }
                }
                self.delegate?.dataLoaderViewModel(self, didFinishLoading: self.model.hospitals)
            }
            else {
                fatalError("self is nil.")
            }
        })
    }
    
    // MARK: - Private methods
    private func updateLoadingStatus(with message: String) {
        self.dataLoaderView?.loadingStatusLabel.text = message
    }

    private func loadHospitalData(completed: @escaping([Hospital]?)->Void) {
        if let service = service {
            service.requestData { (hospitals) in
                if let hospitals = hospitals {
                    completed(hospitals)
                } else {
                    self.loadingState = .completedWithNoData
                    completed(nil)
                }
            }
        } else {
            fatalError("Service is nil")
        }
    }
}
