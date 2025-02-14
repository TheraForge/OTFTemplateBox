/*
Copyright (c) 2024, Hippocrates Technologies Sagl. All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of the copyright holder(s) nor the names of any contributor(s) may
be used to endorse or promote products derived from this software without specific
prior written permission. No license is granted to the trademarks of the copyright
holders even if such marks are included in this software.

4. Commercial redistribution in any form requires an explicit license agreement with the
copyright holder(s). Please contact support@hippocratestech.com for further information
regarding licensing.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
OF SUCH DAMAGE.
 */

import XCTest
@testable import OTFTemplateBox

class OTFTemplateBoxTests: XCTestCase {
    // MARK: - Test case to test OTFProtection level
    func testOTFProtectionLevels() {
        let shared = OTFConfigManager.shared
        do {
            let bundle = Bundle(for: type(of: self))
            try shared.loadDataFromFile(bundle)
            let mode = shared.defaultOTFProtectionLevel()
            XCTAssertEqual(mode, .runToCompletionBeyond10Seconds)
        } catch OTFError.fileNotFound(let err) {
            XCTFail(err)
        } catch OTFError.unableToConvertDataIntoString {
            XCTFail("Unable to convert data into string.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    // MARK: - Test cases for HealthKit Permissions identifiers
    func testHealthKitPermissionsQuantity() {
        let shared = OTFConfigManager.shared
        do {
            let bundle = Bundle(for: type(of: self))
            try shared.loadDataFromFile(bundle)
            let identifiers = shared.healthKitPermissionIdentifiers(for: .quantity)
            XCTAssertNotEqual(identifiers, nil)
            XCTAssertEqual(identifiers?.count, 90)
        } catch OTFError.fileNotFound(message: let error) {
            XCTFail(error)
        } catch OTFError.unableToConvertDataIntoString {
            XCTFail("Unable to convert data into string.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testHealthKitPermissionsCategory() {
        let shared = OTFConfigManager.shared
        do {
            let bundle = Bundle(for: type(of: self))
            try shared.loadDataFromFile(bundle)
            let identifiers = shared.healthKitPermissionIdentifiers(for: .category)
            XCTAssertNotEqual(identifiers, nil)
            XCTAssertEqual(identifiers?.count, 59)
        } catch OTFError.fileNotFound(message: let error) {
            XCTFail(error)
        } catch OTFError.unableToConvertDataIntoString {
            XCTFail("Unable to convert data into string.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testHealthKitPermissionsCorrelation() {
        let shared = OTFConfigManager.shared
        do {
            let bundle = Bundle(for: type(of: self))
            try shared.loadDataFromFile(bundle)
            let identifiers = shared.healthKitPermissionIdentifiers(for: .correlation)
            XCTAssertNotEqual(identifiers, nil)
            XCTAssertEqual(identifiers?.count, 2)
        } catch OTFError.fileNotFound(message: let error) {
            XCTFail(error)
        } catch OTFError.unableToConvertDataIntoString {
            XCTFail("Unable to convert data into string.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testHealthKitPermissionsCharacteristics() {
        let shared = OTFConfigManager.shared
        do {
            let bundle = Bundle(for: type(of: self))
            try shared.loadDataFromFile(bundle)
            let identifiers = shared.healthKitPermissionIdentifiers(for: .characteristic)
            XCTAssertNotEqual(identifiers, nil)
            XCTAssertEqual(identifiers?.count, 6)
        } catch OTFError.fileNotFound(message: let error) {
            XCTFail(error)
        } catch OTFError.unableToConvertDataIntoString {
            XCTFail("Unable to convert data into string.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testHealthKitPermissionsWorkout() {
        let shared = OTFConfigManager.shared
        do {
            let bundle = Bundle(for: type(of: self))
            try shared.loadDataFromFile(bundle)
            let identifiers = shared.healthKitPermissionIdentifiers(for: .workout)
            XCTAssertEqual(identifiers, []) // There is no identifiers for workout
        } catch OTFError.fileNotFound(message: let error) {
            XCTFail(error)
        } catch OTFError.unableToConvertDataIntoString {
            XCTFail("Unable to convert data into string.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testHealthKitPermissionAll() {
        let shared = OTFConfigManager.shared
        do {
            let bundle = Bundle(for: type(of: self))
            try shared.loadDataFromFile(bundle)
            let identifiers = shared.healthKitPermissionIdentifiers(for: .allPermissions)
            XCTAssertNotEqual(identifiers, nil)
            XCTAssertEqual(identifiers?.count, 158)
        } catch OTFError.fileNotFound(message: let error) {
            XCTFail(error)
        } catch OTFError.unableToConvertDataIntoString {
            XCTFail("Unable to convert data into string.")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    // MARK: -
}
