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

@testable import OTFTemplateBox

struct OTFYAMLDecoderEngineTests {
        
    let engine = OTFYAMLDecoderEngine(bundle: .testTemplateBox)
    
    // MARK: - Initialization Tests
    
    @Test func initializationWithDefaultBundle() async throws {
        let engine = OTFYAMLDecoderEngine()
        #expect(type(of: engine) == OTFYAMLDecoderEngine.self)
    }
    
    @Test func initializationWithCustomBundle() async throws {
        #expect(type(of: engine) == OTFYAMLDecoderEngine.self)
    }
    
    // MARK: - Happy Path Tests
    
    @Test func decodeValidYAMLWithCurrentVersion() async throws {
        let config = try engine.decode("TestAppConfig", as: TestAppConfig.self)
        
        #expect(config.version == "2.0.0")
        #expect(config.apiKey == "He3zxB6mkyevlP1KnIzKJk2vEKFgZMMfhuRwdNt")
        #expect(config.theme == "Blue Sky")
        #expect(config.protectionLevel == "runToCompletionBeyond10Seconds")
        #expect(config.enableLogging == false)
        #expect(config.animationSpeed == 0.75)
        #expect(config.extraFeatureEnabled == true)
        #expect(config.titleFont == OTFFont.largeTitle)
        #expect(config.titleFontWeight == OTFFontWeight.black)
    }
    
    @Test func decodeValidYAMLWithNewerVersion() async throws {
        let config = try engine.decode("TestAppConfigNewVersion", as: TestAppConfig.self)
        
        #expect(config.version == "4.0.0")
        #expect(config.apiKey == "NewApiKey123")
        #expect(config.theme == "dark")
        // Should use direct decoding since version >= fallback
    }
    
    @Test func decodeYAMLWithOlderVersionRequiresMigration() async throws {
        let config = try engine.decode("TestAppConfigOldVersion", as: TestAppConfig.self)
        
        // Should trigger migration from version 1.0.0
        #expect(config.version == "1.0.0")
        #expect(config.theme == "classic") // Should be migrated
        #expect(config.enableLogging == true) // Should be migrated
    }
    
    // MARK: - Error Tests
    
    @Test func decodeThrowsFileNotFoundError() async throws {
        #expect {
            try engine.decode("NonExistentFile", as: TestAppConfig.self)
        } throws: { error in
            guard let decodingError = error as? OTFYAMLDecodingError else { return false }
            if case .fileNotFound(let file) = decodingError {
                return file == "NonExistentFile"
            }
            return false
        }
    }
    
    @Test func decodeThrowsInvalidVersionFormatError() async throws {
        #expect {
            try engine.decode("TestAppConfigInvalidVersion", as: TestAppConfig.self)
        } throws: { error in
            guard let decodingError = error as? OTFYAMLDecodingError else { return false }
            if case .invalidVersionFormat(let found) = decodingError {
                return found == "invalid"
            }
            return false
        }
    }
    
    @Test func decodeThrowsMissingVersionError() async throws {
        #expect {
            try engine.decode("TestAppConfigMissingVersion", as: TestAppConfig.self)
        } throws: { error in
            guard let decodingError = error as? OTFYAMLDecodingError else { return false }
            if case .invalidVersionFormat(let found) = decodingError {
                return found == nil
            }
            return false
        }
    }
    
    @Test func decodeThrowsYAMLParsingFailedError() async throws {
        #expect {
            try engine.decode("TestAppConfigInvalidYAML", as: TestAppConfig.self)
        } throws: { error in
            guard let decodingError = error as? OTFYAMLDecodingError else { return false }
            if case .yamlParsingFailed = decodingError {
                return true
            }
            return false
        }
    }
    
    @Test func decodeThrowsMigrationFailedError() async throws {
        #expect {
            try engine.decode("TestAppConfigMigrationFail", as: FailingMigrationConfig.self)
        } throws: { error in
            guard let decodingError = error as? OTFYAMLDecodingError else { return false }
            if case .migrationFailed = decodingError {
                return true
            }
            return false
        }
    }
    
    @Test func decodeThrowsFallbackVersionInvalidError() async throws {
        #expect {
            try engine.decode("TestAppConfigSimple", as: InvalidFallbackVersionConfig.self)
        } throws: { error in
            guard let decodingError = error as? OTFYAMLDecodingError else { return false }
            if case .fallbackVersionInvalid = decodingError {
                return true
            }
            return false
        }
    }
    
    // MARK: - Localization Tests
    
    @Test func decodeLocalizedStringsCorrectly() async throws {
        let config = try engine.decode("TestAppConfig", as: TestAppConfig.self)
        
        // Test localized strings are properly decoded
        #expect(config.welcomeMessage.localized == "Welcome")
        #expect(config.goodbyeMessage.localized == "Goodbye")
    }
    
    // MARK: - Complex Migration Tests
    
    @Test func migrationFromVersion1HandlesThemeCorrectly() async throws {
        let config = try engine.decode("TestAppConfigVersion1", as: TestAppConfig.self)
        
        #expect(config.version == "1.0.0")
        #expect(config.theme == "classic")
        #expect(config.enableLogging == true)
    }
    
    @Test func migrationFromVersion2HandlesAnimationSpeedCorrectly() async throws {
        let config = try engine.decode("TestAppConfigVersion2", as: TestAppConfig.self)
        
        #expect(config.version == "2.5.0")
        #expect(config.animationSpeed == 1.5)
    }
    
    // MARK: - Edge Cases
    
    @Test func decodeWithEmptyOptionalFields() async throws {
        let config = try engine.decode("TestAppConfigMinimal", as: TestAppConfig.self)
        
        // Should fall back to default values for missing fields
        #expect(config.theme == "light")
        #expect(config.enableLogging == false)
    }
    
    @Test func decodeHandlesMultipleDecodingCalls() async throws {
        let config1 = try engine.decode("TestAppConfig", as: TestAppConfig.self)
        let config2 = try engine.decode("TestAppConfig", as: TestAppConfig.self)
        
        #expect(config1.version == config2.version)
        #expect(config1.apiKey == config2.apiKey)
    }
    
    @Test func decodeWithExactFallbackVersion() async throws {
        let config = try engine.decode("TestAppConfigFallbackVersion", as: TestAppConfig.self)
        
        // Should use direct decoding since version == fallback
        #expect(config.version == "3.0.0")
    }
    
    @Test func decodeVersionComparisonEdgeCases() async throws {        
        // Test version 2.9.9 < 3.0.0 (requires migration)
        let config = try engine.decode("TestAppConfigVersion299", as: TestAppConfig.self)
        #expect(config.version == "2.9.9")
    }
}
