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
import OTFUtilities

#if os(iOS)
import Yams

/// A default implementation of a version-aware YAML decoder using Yams.
///
/// This engine loads a YAML file from a given bundle, extracts a version from the file,
/// and either decodes it directly or attempts to migrate it based on the version information.
public struct OTFYAMLDecoderEngine: OTFYAMLDecoding {
    
    /// The bundle from which YAML files will be loaded.
    private let bundle: Bundle
    
    /// Initializes a YAML decoding engine.
    ///
    /// - Parameter bundle: The bundle to load YAML resources from. Defaults to `.main`.
    public init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    /// Decodes a versioned YAML file from the bundle.
    ///
    /// This method decodes a raw representation of the data, extracts a semantic version,
    /// compares it to a fallback version, and either returns the decoded object or runs a migration.
    ///
    /// - Parameters:
    ///   - file: The name of the YAML file (without `.yml` extension).
    ///   - type: The type conforming to `OTFVersionedDecodable` to decode into.
    ///
    /// - Throws:
    ///   - `OTFYAMLDecodingError.fileNotFound` if the YAML file can't be located.
    ///   - `OTFYAMLDecodingError.yamlParsingFailed` if the YAML can't be parsed.
    ///   - `OTFYAMLDecodingError.invalidVersionFormat` if the version field is missing or invalid.
    ///   - `OTFYAMLDecodingError.fallbackVersionInvalid` if the fallback version is invalid.
    ///   - `OTFYAMLDecodingError.migrationFailed` if migration fails.
    ///
    /// - Returns: An instance of the decoded and possibly migrated type.
    public func decode<T: OTFVersionedDecodable>(_ file: String, as type: T.Type) throws -> T {
        OTFDebug("Attempting to decode YAML file: %@", file)
        
        guard let url = bundle.url(forResource: file, withExtension: "yml") else {
            OTFError("YAML file '%@.yml' not found", file)
            throw OTFYAMLDecodingError.fileNotFound(file: file)
        }
        
        let data = try Data(contentsOf: url)
        let decoder = YAMLDecoder()
        
        let raw: T.Raw
        do {
            raw = try decoder.decode(T.Raw.self, from: data)
        } catch {
            OTFError("Failed to decode raw type from YAML: %@", error.localizedDescription)
            throw OTFYAMLDecodingError.yamlParsingFailed(underlying: error)
        }
        
        let versionContainer: VersionContainer
        do {
            versionContainer = try decoder.decode(VersionContainer.self, from: data)
        } catch {
            OTFError("Failed to extract version from YAML: %@", error.localizedDescription)
            throw OTFYAMLDecodingError.yamlParsingFailed(underlying: error)
        }
        
        guard let versionString = versionContainer.version else {
            OTFError("Missing version string in YAML")
            throw OTFYAMLDecodingError.invalidVersionFormat(found: nil)
        }
        
        guard let version = OTFSemanticVersion(string: versionString) else {
            OTFError("Invalid version string in YAML: %@", versionString)
            throw OTFYAMLDecodingError.invalidVersionFormat(found: versionString)
        }
        
        guard let fallbackVersion = OTFSemanticVersion(string: T.fallback.version) else {
            OTFError("Invalid fallback version: %@", T.fallback.version)
            throw OTFYAMLDecodingError.fallbackVersionInvalid(found: T.fallback.version)
        }
        
        if version >= fallbackVersion {
            OTFLog("Version %@ is >= fallback %@. Using direct decode.", versionString, T.fallback.version)
            return T(from: raw)
        }
        
        do {
            OTFLog("Migrating version %@ to %@", versionString, T.fallback.version)
            return try T.migrate(from: version, raw: raw)
        } catch {
            OTFError("Migration from version %@ failed: %@", versionString, error.localizedDescription)
            throw OTFYAMLDecodingError.migrationFailed(version: versionString, underlying: error)
        }
    }
    
    /// A helper struct used to extract version metadata from YAML.
    private struct VersionContainer: Codable {
        /// The version string (e.g. "1.0.0") embedded in the YAML.
        let version: String?
    }
}

#endif

#if os(watchOS)

/// A fallback YAML decoder for platforms where YAML parsing is unsupported (e.g. watchOS).
///
/// This implementation always throws an error, since Yams is not available on this platform.
public struct OTFYAMLDecoderEngine: OTFYAMLDecoding {
    
    /// Initializes a fallback YAML decoding engine.
    ///
    /// - Parameter bundle: Unused on this platform. Present to maintain consistent API.
    public init(bundle: Bundle = .main) {}
    
    /// Always throws `OTFYAMLDecodingError.unsupportedPlatform`.
    ///
    /// - Throws: `OTFYAMLDecodingError.unsupportedPlatform`
    public func decode<T: OTFVersionedDecodable>(_ file: String, as type: T.Type) throws -> T {
        OTFError("Attempted to decode YAML on unsupported platform (watchOS)")
        throw OTFYAMLDecodingError.unsupportedPlatform
    }
}

#endif
