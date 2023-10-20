/*
Copyright (c) 2021, Hippocrates Technologies S.r.l.. All rights reserved.

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

import UIKit
import OTFToolBoxCore
import OTFUtilities

public class OTFConfigManager: OTFConfigManagerProtocol {
    public static let shared: OTFConfigManagerProtocol = OTFConfigManager()
    private var configs = [OTFConfig]()

    public func getValue(for key: String) -> String? {
        return configs.filter { $0.name == key }.first?.textValue
    }

    public func loadDataFromFile(_ bundle: Bundle? = nil) throws {
        let mainBundle = bundle ?? Bundle(for: type(of: self))
        guard let fileUrlString = mainBundle.path(forResource: Constants.sysConfigFileName, ofType: nil) else {
            OTFLog("File cannot found: %{public}@ ", Constants.sysConfigFileName)
            throw OTFError.fileNotFound(message: Constants.sysConfigFileName)
        }
        let fileUrl = URL(fileURLWithPath: fileUrlString)
        do {
            let data = try Data(contentsOf: fileUrl)
            guard let string = String(data: data, encoding: .utf8) else {
                throw OTFError.unableToConvertDataIntoString
            }
            self.configs = try YAMLManager.shared.decode([OTFConfig].self, from: string)
        }
    }

    public func healthKitPermissionIdentifiers(for type: HKSampleTypes) -> [String]? {
        var permissionKey: String?
        switch type {
        case .quantity:
            permissionKey = Constants.HKPermission.quantity
        case .category:
            permissionKey = Constants.HKPermission.category
        case .correlation:
            permissionKey = Constants.HKPermission.correlation
        case .workout:
            permissionKey = Constants.HKPermission.workout
        case .characteristic:
            permissionKey = Constants.HKPermission.characteristic
        case .document:
            permissionKey = Constants.HKPermission.document
        case .allPermissions:
            return allHealthPermissions()
        }
        guard let key = permissionKey else { return nil }
        if let sampleIdentifiersString = getValue(for: key) {
            return sampleIdentifiersString.components(separatedBy: ",")
        }
        return []
    }

    private func allHealthPermissions() -> [String]? {
        var identifiers = [String]()
        for permissionKey in Constants.HKPermission.all {
            if let samplesString = getValue(for: permissionKey) {
                identifiers.append(contentsOf: samplesString.components(separatedBy: ","))
            }
        }
        return identifiers
    }

    public func loadDatabaseFromFile() -> Bool {
        if let boolString = getValue(for: Constants.TCMConfig.importDatabaseFromFileKey) {
            return boolString.boolValue
        }
        return false
    }

    public func offset() -> CGFloat? {
        if let floatString = getValue(for: Constants.TCMConfig.offsetKey) {
            return floatString.floatValue
        }
        return nil
    }

    public func startDate() -> Date? {
        if let dateString = getValue(for: Constants.TCMConfig.startDateKey) {
            return dateString.date()
        }
        return nil
    }

    public func tintColor() -> UIColor? {
        if let stringColor = getValue(for: Constants.TCMConfig.tintColorKey) {
            return stringColor.color()
        }
        return nil
    }

    public func defaultOTFProtectionLevel() -> OTFProtectionLevel? {
        if let mode = getValue(for: Constants.ProtectionLevel.otfProtectionLevel) {
            return mode.toOTFProtection
        }
        return nil
    }

    func testConfig() {
        OTFLog("====Start testing====")
        // test color
        _ = ColorStyler.label
        _ = ColorStyler.secondaryLabel
        _ = ColorStyler.tertiaryLabel
        _ = ColorStyler.customBackground
        _ = ColorStyler.secondaryCustomBackground
        _ = ColorStyler.customGroupedBackground
        _ = ColorStyler.secondaryCustomGroupedBackground
        _ = ColorStyler.tertiaryCustomGroupedBackground
        _ = ColorStyler.separator
        _ = ColorStyler.customFill
        _ = ColorStyler.secondaryCustomFill
        _ = ColorStyler.tertiaryCustomFill
        _ = ColorStyler.quaternaryCustomFill
        _ = ColorStyler.customBlue
        _ = ColorStyler.customGray
        _ = ColorStyler.customGray2
        _ = ColorStyler.customGray3
        _ = ColorStyler.customGray4
        _ = ColorStyler.customGray5
        _ = ColorStyler.white
        _ = ColorStyler.black
        _ = ColorStyler.clear
        // test font
        _ = FontStyler.largeTitle
        _ = FontStyler.title
        _ = FontStyler.title2
        _ = FontStyler.title3
        _ = FontStyler.headline
        _ = FontStyler.subheadline
        _ = FontStyler.body
        _ = FontStyler.callout
        _ = FontStyler.caption
        _ = FontStyler.footnote
        _ = FontStyler.caption2
        OTFLog("====End testing====")
    }
}
