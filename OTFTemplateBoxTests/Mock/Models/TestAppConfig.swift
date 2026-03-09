/*
 Copyright (c) 2025, Hippocrates Technologies Sagl. All rights reserved.
 
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

import SwiftUI
@testable import OTFTemplateBox

struct RawTestAppConfig: Codable {
    let version: String?
    let apiKey: String?
    var theme: String?
    let protectionLevel: String?
    var enableLogging: Bool?
    var animationSpeed: Double?
    var extraFeatureEnabled: Bool?
    var welcomeMessage: OTFStringLocalized?
    var goodbyeMessage: OTFStringLocalized?
    var titleFont: OTFFont?
    var titleFontWeight: OTFFontWeight?
    var titleColor: OTFColor?
    var subtitleColor: OTFColor?
    var cardBackgroundColor: OTFColor?
}

struct TestAppConfig: Codable {
    let version: String
    let apiKey: String
    let theme: String
    let protectionLevel: String
    let enableLogging: Bool
    let animationSpeed: Double
    let extraFeatureEnabled: Bool
    let welcomeMessage: OTFStringLocalized
    let goodbyeMessage: OTFStringLocalized
    let titleFont: OTFFont
    let titleFontWeight: OTFFontWeight
    let titleColor: OTFColor
    let subtitleColor: OTFColor
    let cardBackgroundColor: OTFColor
}

extension TestAppConfig: OTFVersionedDecodable {
    typealias Raw = RawTestAppConfig

    static let fallback = TestAppConfig(
        version: "3.0.0",
        apiKey: "<your-api-key>",
        theme: "light",
        protectionLevel: "runToCompletionWithIn10Seconds",
        enableLogging: false,
        animationSpeed: 1.0,
        extraFeatureEnabled: false,
        welcomeMessage: OTFStringLocalized("Welcome"),
        goodbyeMessage: OTFStringLocalized("Goodbye"),
        titleFont: OTFFont.title,
        titleFontWeight: OTFFontWeight.bold,
        titleColor: OTFColor.label,
        subtitleColor: OTFColor.secondaryLabel,
        cardBackgroundColor: OTFColor.systemBackground
    )

    init(from raw: RawTestAppConfig) {
        let fallback = TestAppConfig.fallback
        self.version = raw.version ?? fallback.version
        self.apiKey = raw.apiKey ?? fallback.apiKey
        self.theme = raw.theme ?? fallback.theme
        self.protectionLevel = raw.protectionLevel ?? fallback.protectionLevel
        self.enableLogging = raw.enableLogging ?? fallback.enableLogging
        self.animationSpeed = raw.animationSpeed ?? fallback.animationSpeed
        self.extraFeatureEnabled = raw.extraFeatureEnabled ?? fallback.extraFeatureEnabled
        self.welcomeMessage = raw.welcomeMessage ?? fallback.welcomeMessage
        self.goodbyeMessage = raw.goodbyeMessage ?? fallback.goodbyeMessage
        self.titleFont = raw.titleFont ?? fallback.titleFont
        self.titleFontWeight = raw.titleFontWeight ?? fallback.titleFontWeight
        self.titleColor = raw.titleColor ?? fallback.titleColor
        self.subtitleColor = raw.subtitleColor ?? fallback.subtitleColor
        self.cardBackgroundColor = raw.cardBackgroundColor ?? fallback.cardBackgroundColor
    }

    static func migrate(from version: OTFSemanticVersion, raw: RawTestAppConfig) throws -> TestAppConfig {
        var migrated = raw
        
        switch version.major {
        case 1:
            migrated.theme = migrated.theme == nil ? "classic" : migrated.theme
            migrated.enableLogging = migrated.enableLogging ?? true
            
        case 2:
            migrated.theme = migrated.theme == nil ? "default" : migrated.theme
            migrated.animationSpeed = migrated.animationSpeed ?? 1.5
            
        default:
            break
        }
        return TestAppConfig(from: migrated)
    }
}
