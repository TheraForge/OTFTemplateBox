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

import Testing
import SwiftUI
#if os(iOS)
import UIKit
#endif

@testable import OTFTemplateBox

struct OTFColorTests {
    
    func tearDown() async throws {
        OTFColor.lastDecodedRawValue = nil
    }
    
    @Test func testColorRawValuesExistence() {
        let allCases: [OTFColor] = [.black, .white, .clear, .darkGray, .lightGray, .gray, .red, .green, .blue, .cyan, .mint, .pink, .teal, .indigo, .yellow, .orange, .purple, .brown, .systemRed, .systemBlue, .systemGreen, .systemOrange, .systemYellow, .systemBrown, .systemPink, .systemPurple, .systemTeal, .systemIndigo, .systemMint, .systemCyan, .systemGray, .systemGray2, .systemGray3, .systemGray4, .systemGray5, .systemGray6, .label, .secondaryLabel, .tertiaryLabel, .quaternaryLabel, .placeholderText, .link, .separator, .opaqueSeparator, .systemFill, .secondarySystemFill, .tertiarySystemFill, .quaternarySystemFill, .systemBackground, .secondarySystemBackground, .tertiarySystemBackground, .systemGroupedBackground, .secondarySystemGroupedBackground, .tertiarySystemGroupedBackground, .unknown]
        
        for color in allCases {
            #expect(OTFColor(rawValue: color.rawValue) == color)
        }
    }
    
    @Test func testSwiftUIColorMapping() {
        let color = OTFColor.red.color
        #expect(color == Color(.systemRed))
    }
    
    #if os(iOS)
    @Test func testUIColorMapping() {
        let uiColor = OTFColor.blue.uiColor
        #expect(uiColor == UIColor.systemBlue)
    }
    #endif
    
    @Test func testUnknownDecoding() {
        let json = "\"invalidColorName\""
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(OTFColor.self, from: data)
            #expect(decoded == .unknown)
            #expect(OTFColor.lastDecodedRawValue == "invalidColorName")
        } catch {
            #expect(Bool(false), "Decoding should not fail")
        }
    }
    
    @Test func testKnownDecoding() {
        let json = "\"blue\""
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(OTFColor.self, from: data)
            #expect(decoded == .blue)
        } catch {
            #expect(Bool(false), "Decoding should not fail for known value")
        }
    }
    
    @Test func testFallbackToPrimaryIfHexFails() {
        OTFColor.lastDecodedRawValue = "NotAColor"
        let fallbackColor = OTFColor.unknown.color
        #expect(fallbackColor == .primary)
    }
    
    #if os(iOS)
    @Test func testFallbackToLabelIfHexFailsOnUIColor() {
        OTFColor.lastDecodedRawValue = "NotAColor"
        let fallbackColor = OTFColor.unknown.uiColor
        #expect(fallbackColor == UIColor.label)
    }
    #endif
}
