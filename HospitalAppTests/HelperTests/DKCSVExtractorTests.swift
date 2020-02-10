//
//  DKCSVExtractorTests.swift
//  HospitalAppTests
//
//  Created by Donald King on 26/01/2020.
//  Copyright © 2020 Donald King. All rights reserved.
//

import XCTest
@testable import HospitalApp

class DKCSVExtractorTests: XCTestCase {
    var sut: DKCSVExtractor!
    
    override func setUp() {
        let csvString = loadLocalCSVData()
        self.sut = DKCSVExtractor(csv: csvString, delimiter: "\t")//"¬")
    }

    override func tearDown() {
        self.sut = nil
    }
    
    // MARK: - Tests
    func testGetAllHeadersReturns22HeadersCount() {
        let exp = expectation(description: "csvJob")
        self.sut.getAllHeaders { (headers) in
            let count = headers!.count
            XCTAssertEqual(count, 22, "Headers count should be 22")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }
    
    func testGetAllRowsReturns1093RowCount() {
        let exp = expectation(description: "csvJob")
        self.sut.getAllRows { (rows) in
            let count = rows!.count
            XCTAssertEqual(count, 1093, "Rows count should be 1093")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }
    
    func testGetAllHeadersAndRowsReturns1093RowCount() {
        let exp = expectation(description: "csvJob")
        self.sut.getAllHeadersAndRows { (headersAndRows) in
            let count = headersAndRows!.count
            XCTAssertEqual(count, 1093, "Headers and Rows count should be 1093")
            exp.fulfill()
        }
        wait(for: [exp], timeout: 3)
    }

    // MARK: - Private methods
    private func loadLocalCSVData() -> String {
        let fileUrl = Bundle.main.url(forResource: "Hospital", withExtension: "csv")!
        let data = try! Data(contentsOf: fileUrl)
        let csvString = String(data: data, encoding: .ascii)!
        return csvString
    }
}
