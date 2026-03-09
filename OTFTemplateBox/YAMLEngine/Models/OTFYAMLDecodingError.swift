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

import Foundation

/// # Localizing `OTFYAMLDecodingError` in the Client App
///
/// The `OTFYAMLDecodingError` enum provides user-facing error messages that support localization.
/// These messages are constructed using `String(localized:..., bundle: .main)`, which means:
/// Clients can override the messages in their own app by providing localized versions of the error strings.
///
/// ## How to Localize
///
/// ### Option 1: Use `Localizable.strings`
/// 1. In your client app, create or open `Localizable.strings` in each desired language (e.g., `en.lproj/Localizable.strings`, `es.lproj/Localizable.strings`)
/// 2. Add the matching keys from the framework:
///
/// ```plaintext
/// // en.lproj/Localizable.strings
/// "YAML file '%@.yml' was not found in the bundle." = "YAML file '%@.yml' was not found in the bundle.";
/// ```
///
/// ### Option 2: Use a String Catalog (`.xcstrings`)
/// 1. In Xcode, go to `File > New > File > String Catalog` and name it `Localizable`.
/// 2. Build the project and it should extract all the strings automatically.
/// 3. Provide translations in each language directly in the catalog UI.
///
/// ```plaintext
/// - Key: `YAML file '%@.yml' was not found in the bundle.`
/// - Localization: `El archivo '%@.yml' no se encontró en el paquete.` (Spanish)
/// ```
///
/// ## Tip
/// The keys **must match exactly** as used in the `String(localized:)` calls in the framework.
public enum OTFYAMLDecodingError: Error {
    /// The requested YAML file was not found in the provided bundle.
    case fileNotFound(file: String)
    
    /// The YAML data is missing a `version` key or it is malformed.
    case invalidVersionFormat(found: String?)
    
    /// Failed to parse the YAML data into the expected raw type.
    case yamlParsingFailed(underlying: Error)
    
    /// Migration from the older version failed.
    case migrationFailed(version: String, underlying: Error)
    
    /// The fallback version in the model is not a valid semantic version.
    case fallbackVersionInvalid(found: String)
    
    /// The platform does not support YAML decoding (e.g., watchOS).
    case unsupportedPlatform
}

extension OTFYAMLDecodingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let file):
            return String(format: String(localized: "YAML file '%@.yml' was not found in the bundle.", bundle: .main), file)
        case .invalidVersionFormat(let found):
            return String(format: String(localized: "Invalid or missing version string in YAML. Found: '%@'.", bundle: .main), found ?? "nil")
        case .yamlParsingFailed(let error):
            return String(format: String(localized: "Failed to parse YAML data. %@", bundle: .main), error.localizedDescription)
        case .migrationFailed(let version, let error):
            return String(format: String(localized: "Migration from version %@ failed. %@", bundle: .main), version, error.localizedDescription)
        case .fallbackVersionInvalid(let found):
            return String(format: String(localized: "Fallback version string '%@' is not a valid semantic version.", bundle: .main), found)
        case .unsupportedPlatform:
            return String(localized: "YAML decoding is not supported on this platform.", bundle: .main)
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .fileNotFound:
            return String(localized: "The file might not be included in the bundle or the name is misspelled.", bundle: .main)
        case .invalidVersionFormat:
            return String(localized: "The YAML file should contain a top-level 'version' key in semantic format.", bundle: .main)
        case .yamlParsingFailed:
            return String(localized: "The structure of the YAML file does not match the expected model.", bundle: .main)
        case .migrationFailed:
            return String(localized: "There may be a bug in the migration logic or unsupported schema change.", bundle: .main)
        case .fallbackVersionInvalid:
            return String(localized: "Check the fallback.version property in your model for correctness.", bundle: .main)
        case .unsupportedPlatform:
            return String(localized: "This platform does not support the required YAML decoding framework.", bundle: .main)
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .fileNotFound:
            return String(localized: "Ensure the file is present in the bundle and the filename is correct.", bundle: .main)
        case .invalidVersionFormat:
            return String(localized: "Add or fix the 'version' key in the YAML file (e.g., version: 1.0.0).", bundle: .main)
        case .yamlParsingFailed:
            return String(localized: "Make sure your YAML structure matches the expected model format.", bundle: .main)
        case .migrationFailed:
            return String(localized: "Double-check your migration logic for this version transition.", bundle: .main)
        case .fallbackVersionInvalid:
            return String(localized: "Verify that the fallback version string is valid (e.g., 1.2.3).", bundle: .main)
        case .unsupportedPlatform:
            return String(localized: "Avoid using OTFYAMLDecoderEngine on unsupported platforms (e.g., watchOS).", bundle: .main)
        }
    }
}
