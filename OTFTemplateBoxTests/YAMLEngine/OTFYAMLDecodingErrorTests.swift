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

struct OTFYAMLDecodingErrorTests {
    
    // MARK: - LocalizedError Tests
    
    @Test func fileNotFoundErrorDescription() async throws {
        let error = OTFYAMLDecodingError.fileNotFound(file: "MissingFile")
        let description = error.localizedDescription
        
        #expect(description.contains("MissingFile.yml"))
        #expect(description.contains("not found"))
    }
    
    @Test func invalidVersionFormatErrorDescription() async throws {
        let error = OTFYAMLDecodingError.invalidVersionFormat(found: "1.2.x")
        let description = error.localizedDescription
        
        #expect(description.contains("1.2.x"))
        #expect(description.contains("Invalid"))
    }
    
    @Test func yamlParsingFailedErrorDescription() async throws {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test parsing error"])
        let error = OTFYAMLDecodingError.yamlParsingFailed(underlying: underlyingError)
        let description = error.localizedDescription
        
        #expect(description.contains("Failed to parse"))
        #expect(description.contains("Test parsing error"))
    }
    
    @Test func migrationFailedErrorDescription() async throws {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Migration error"])
        let error = OTFYAMLDecodingError.migrationFailed(version: "1.0.0", underlying: underlyingError)
        let description = error.localizedDescription
        
        #expect(description.contains("Migration from version 1.0.0"))
        #expect(description.contains("Migration error"))
    }
    
    @Test func fallbackVersionInvalidErrorDescription() async throws {
        let error = OTFYAMLDecodingError.fallbackVersionInvalid(found: "invalid.version")
        let description = error.localizedDescription
        
        #expect(description.contains("invalid.version"))
        #expect(description.contains("not a valid semantic version"))
    }
    
    @Test func unsupportedPlatformErrorDescription() async throws {
        let error = OTFYAMLDecodingError.unsupportedPlatform
        let description = error.localizedDescription
        
        #expect(description.contains("not supported"))
        #expect(description.contains("platform"))
    }
    
    // MARK: - Error Recovery Suggestions Tests
    
    @Test func fileNotFoundRecoverySuggestion() async throws {
        let error = OTFYAMLDecodingError.fileNotFound(file: "MissingFile")
        let suggestion = error.recoverySuggestion
        
        #expect(suggestion?.contains("Ensure the file is present") == true)
        #expect(suggestion?.contains("filename is correct") == true)
    }
    
    @Test func invalidVersionFormatRecoverySuggestion() async throws {
        let error = OTFYAMLDecodingError.invalidVersionFormat(found: "bad")
        let suggestion = error.recoverySuggestion
        
        #expect(suggestion?.contains("Add or fix the 'version' key") == true)
        #expect(suggestion?.contains("1.0.0") == true)
    }
    
    @Test func yamlParsingFailedRecoverySuggestion() async throws {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [:])
        let error = OTFYAMLDecodingError.yamlParsingFailed(underlying: underlyingError)
        let suggestion = error.recoverySuggestion
        
        #expect(suggestion?.contains("YAML structure matches") == true)
        #expect(suggestion?.contains("expected model format") == true)
    }
    
    @Test func migrationFailedRecoverySuggestion() async throws {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [:])
        let error = OTFYAMLDecodingError.migrationFailed(version: "1.0.0", underlying: underlyingError)
        let suggestion = error.recoverySuggestion
        
        #expect(suggestion?.contains("migration logic") == true)
        #expect(suggestion?.contains("version transition") == true)
    }
    
    @Test func fallbackVersionInvalidRecoverySuggestion() async throws {
        let error = OTFYAMLDecodingError.fallbackVersionInvalid(found: "bad")
        let suggestion = error.recoverySuggestion
        
        #expect(suggestion?.contains("fallback version string") == true)
        #expect(suggestion?.contains("valid") == true)
    }
    
    @Test func unsupportedPlatformRecoverySuggestion() async throws {
        let error = OTFYAMLDecodingError.unsupportedPlatform
        let suggestion = error.recoverySuggestion
        
        #expect(suggestion?.contains("Avoid using") == true)
        #expect(suggestion?.contains("unsupported platforms") == true)
    }
    
    // MARK: - Error Failure Reason Tests
    
    @Test func fileNotFoundFailureReason() async throws {
        let error = OTFYAMLDecodingError.fileNotFound(file: "TestFile")
        let reason = error.failureReason
        
        #expect(reason?.contains("not be included") == true)
        #expect(reason?.contains("misspelled") == true)
    }
    
    @Test func invalidVersionFormatFailureReason() async throws {
        let error = OTFYAMLDecodingError.invalidVersionFormat(found: nil)
        let reason = error.failureReason
        
        #expect(reason?.contains("top-level 'version' key") == true)
        #expect(reason?.contains("semantic format") == true)
    }
    
    @Test func yamlParsingFailedFailureReason() async throws {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [:])
        let error = OTFYAMLDecodingError.yamlParsingFailed(underlying: underlyingError)
        let reason = error.failureReason
        
        #expect(reason?.contains("structure") == true)
        #expect(reason?.contains("expected model") == true)
    }
    
    @Test func migrationFailedFailureReason() async throws {
        let underlyingError = NSError(domain: "TestDomain", code: 1, userInfo: [:])
        let error = OTFYAMLDecodingError.migrationFailed(version: "1.0.0", underlying: underlyingError)
        let reason = error.failureReason
        
        #expect(reason?.contains("bug in the migration logic") == true)
        #expect(reason?.contains("unsupported schema change") == true)
    }
    
    @Test func fallbackVersionInvalidFailureReason() async throws {
        let error = OTFYAMLDecodingError.fallbackVersionInvalid(found: "bad")
        let reason = error.failureReason
        
        #expect(reason?.contains("fallback.version property") == true)
        #expect(reason?.contains("correctness") == true)
    }
    
    @Test func unsupportedPlatformFailureReason() async throws {
        let error = OTFYAMLDecodingError.unsupportedPlatform
        let reason = error.failureReason
        
        #expect(reason?.contains("platform does not support") == true)
        #expect(reason?.contains("YAML decoding framework") == true)
    }
}
