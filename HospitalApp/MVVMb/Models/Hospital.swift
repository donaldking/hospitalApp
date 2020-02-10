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
    var organisationID: String?
    var organisationCode: String?
    var organisationType: String?
    var subType: String?
    public var sector: String?
    var organisationStatus: String?
    var isPimsManaged: String?
    var organisationName: String?
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var county: String?
    var postcode: String?
    var latitude: String?
    var longitude: String?
    var parentODSCode: String?
    var parentName: String?
    var phone: String?
    var email: String?
    var website: String?
    var fax: String?
    
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
    public init(organisationID: String?,organisationCode: String?,organisationType: String?,
                subType: String?,sector: String?,organisationStatus: String?,
                isPimsManaged: String?,organisationName: String?,address1: String?,
                address2: String?,address3: String?,city: String?,county: String?,
                postcode: String?,latitude: String?,longitude: String?,parentODSCode: String?,
                parentName: String?,phone: String?,email: String?,website: String?,fax: String?) {
        self.organisationID = organisationID
        self.organisationCode = organisationCode
        self.organisationType = organisationType
        self.subType = subType
        self.sector = sector
        self.organisationStatus = organisationStatus
        self.isPimsManaged = isPimsManaged
        self.organisationName = organisationName
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.city = city
        self.county = county
        self.postcode = postcode
        self.latitude = latitude
        self.longitude = longitude
        self.parentODSCode = parentODSCode
        self.parentName = parentName
        self.phone = phone
        self.email = email
        self.website = website
        self.fax = fax
    }
    
    // Making sure this struct can only be initialised with [String : String] or all its parameters
    @available(*, unavailable, message: "Please use the available initializers")
    init() {}
}
