//
//  Hospital.swift
//  HospitalApp
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import Foundation

public struct Hospital {
    // MARK: - Private properties
    private let organisationIDKey = "OrganisationID"
    private let organisationCodeKey = "OrganisationCode"
    private let organisationTypeKey = "OrganisationType"
    private let subTypeKey = "SubType"
    private let sectorKey = "Sector"
    private let organisationStatusKey = "OrganisationStatus"
    private let isPimsManagedKey = "IsPimsManaged"
    private let organisationNameKey = "OrganisationName"
    private let address1Key = "Address1"
    private let address2Key = "Address2"
    private let address3Key = "Address3"
    private let cityKey = "City"
    private let countyKey = "County"
    private let postcodeKey = "Postcode"
    private let latitudeKey = "Latitude"
    private let longitudeKey = "Longitude"
    private let parentODSCodeKey = "ParentODSCode"
    private let parentNameKey = "ParentName"
    private let phoneKey = "Phone"
    private let emailKey = "Email"
    private let websiteKey = "Website"
    private let faxKey = "Fax"
    
    // MARK: - Public properties
    private (set) var organisationID: String?
    private (set) var organisationCode: String?
    private (set) var organisationType: String?
    private (set) var subType: String?
    private (set) var sector: String?
    private (set) var organisationStatus: String?
    private (set) var isPimsManaged: String?
    private (set) var organisationName: String?
    private (set) var address1: String?
    private (set) var address2: String?
    private (set) var address3: String?
    private (set) var city: String?
    private (set) var county: String?
    private (set) var postcode: String?
    private (set) var latitude: String?
    private (set) var longitude: String?
    private (set) var parentODSCode: String?
    private (set) var parentName: String?
    private (set) var phone: String?
    private (set) var email: String?
    private (set) var website: String?
    private (set) var fax: String?
    
    // MARK: - init
    public init(with dictionary: [String:String]) {
        self.organisationID = dictionary[organisationIDKey]
        self.organisationCode = dictionary[organisationCodeKey]
        self.organisationType = dictionary[organisationTypeKey]
        self.subType = dictionary[subTypeKey]
        self.sector = dictionary[sectorKey]
        self.organisationStatus = dictionary[organisationStatusKey]
        self.isPimsManaged = dictionary[isPimsManagedKey]
        self.organisationName = dictionary[organisationNameKey]
        self.address1 = dictionary[address1Key]
        self.address2 = dictionary[address2Key]
        self.address3 = dictionary[address3Key]
        self.city = dictionary[cityKey]
        self.county = dictionary[countyKey]
        self.postcode = dictionary[postcodeKey]
        self.latitude = dictionary[latitudeKey]
        self.longitude = dictionary[longitudeKey]
        self.parentODSCode = dictionary[parentODSCodeKey]
        self.parentName = dictionary[parentNameKey]
        self.phone = dictionary[phoneKey]
        self.email = dictionary[emailKey]
        self.website = dictionary[websiteKey]
        self.fax = dictionary[faxKey]
    }
    
    // Making sure this struct can only be initialised with [String : String]
    @available(*, unavailable, message: "Please use init with [String : String]")
    init() {}
}
