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

/// A type that encapsulates localized string values and resolves the best match based on the user's preferred language settings.
public struct OTFStringLocalized: Codable {
    
    /// A dictionary mapping language codes (e.g., "en", "es") to localized strings.
    private let values: [String: String]
    
    /// Returns the best-matched localized string using the user's preferred languages.
    ///
    /// If no direct match is found, it falls back to:
    /// 1. The base language (e.g., "en" from "en-US")
    /// 2. The English ("en") string
    /// 3. An empty string if nothing matches
    public var localized: String {
        Self.resolveBestMatch(from: values, preferredLanguages: Locale.preferredLanguages)
    }
    
    /// Resolves the best-matched string for a given language preference list.
    ///
    /// This allows overriding language context for unit testing.
    static func resolveBestMatch(from values: [String: String], preferredLanguages: [String]) -> String {
        for lang in preferredLanguages {
            if let exact = values[lang] {
                return exact
            }
            if let base = lang.split(separator: "-").first, let match = values[String(base)] {
                return match
            }
        }
        return values["en"] ?? ""
    }
    
    /// Creates a `OTFStringLocalized` using an English string as the default.
    /// - Parameter defaultValue: The default string to use for English (`"en"`).
    public init(_ defaultValue: String) {
        self.values = ["en": defaultValue]
    }
    
    /// Creates a `OTFStringLocalized` using a dictionary of localized values.
    /// - Parameter localized: A dictionary of language codes to localized strings.
    public init(localized: [String: String]) {
        self.values = localized
    }
    
    public init(from decoder: Decoder) throws {
        self.values = try [String: String](from: decoder)
    }
    
    public func encode(to encoder: Encoder) throws {
        try values.encode(to: encoder)
    }
}

extension OTFStringLocalized: ExpressibleByStringLiteral {
    /// Allows initialization via string literals. Defaults to English.
    /// - Parameter value: The string literal value for English.
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
