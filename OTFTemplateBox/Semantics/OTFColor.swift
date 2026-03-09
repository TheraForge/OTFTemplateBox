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
import SwiftUI

#if os(iOS)
import UIKit
#endif

/// Represents a standardized set of colors used within the OTF framework, compatible with both SwiftUI and UIKit.
public enum OTFColor: String, Codable {

    /// A private backing store for the last raw color string that failed to decode.
    private static var _lastDecodedRawValue: String?

    /// A serial dispatch queue used to synchronize access to the `_lastDecodedRawValue`.
    private static let syncQueue = DispatchQueue(label: "OTFColor.syncQueue")

    /// Thread-safe access to the last raw value that failed to decode.
    static var lastDecodedRawValue: String? {
        get { syncQueue.sync { _lastDecodedRawValue } }
        set { syncQueue.sync { _lastDecodedRawValue = newValue } }
    }

    // MARK: - Basic Colors
    case black, white, clear, darkGray, lightGray, gray
    case red, green, blue, cyan, mint, pink, teal, indigo, yellow, orange, purple, brown

    // MARK: - System Colors
    case systemRed, systemBlue, systemGreen, systemOrange, systemYellow, systemBrown
    case systemPink, systemPurple, systemTeal, systemIndigo, systemMint, systemCyan

    // MARK: - System Grays
    case systemGray, systemGray2, systemGray3, systemGray4, systemGray5, systemGray6

    // MARK: - Label Colors
    case label, secondaryLabel, tertiaryLabel, quaternaryLabel
    case placeholderText, link

    // MARK: - Separator Colors
    case separator, opaqueSeparator

    // MARK: - Fill Colors
    case systemFill, secondarySystemFill, tertiarySystemFill, quaternarySystemFill

    // MARK: - Background Colors
    case systemBackground, secondarySystemBackground, tertiarySystemBackground
    case systemGroupedBackground, secondarySystemGroupedBackground, tertiarySystemGroupedBackground

    // MARK: - Fallback
    case unknown

    // MARK: - SwiftUI Color Representation
    public var color: Color {
        #if os(watchOS)
        switch self {
        case .black: return .black
        case .white: return .white
        case .gray, .systemGray: return .gray
        case .red, .systemRed: return .red
        case .green, .systemGreen: return .green
        case .blue, .systemBlue: return .blue
        case .orange, .systemOrange: return .orange
        case .yellow, .systemYellow: return .yellow
        case .purple, .systemPurple: return .purple
        case .cyan, .systemCyan: return .cyan
        case .mint, .systemMint: return .mint
        case .pink, .systemPink: return .pink
        case .clear: return .clear
        case .unknown:
            return Color(hex: OTFColor.lastDecodedRawValue ?? "") ?? .primary
        default:
            return Color(hex: rawValue) ?? .primary
        }
        #else
        switch self {
        case .black: return Color(.black)
        case .white: return Color(.white)
        case .clear: return Color(.clear)
        case .darkGray: return Color(.darkGray)
        case .lightGray: return Color(.lightGray)
        case .green, .systemGreen: return Color(.systemGreen)
        case .blue, .systemBlue: return Color(.systemBlue)
        case .red, .systemRed: return Color(.systemRed)
        case .orange, .systemOrange: return Color(.systemOrange)
        case .yellow, .systemYellow: return Color(.systemYellow)
        case .purple, .systemPurple: return Color(.systemPurple)
        case .brown, .systemBrown: return Color(.systemBrown)
        case .pink, .systemPink: return Color(.systemPink)
        case .teal, .systemTeal: return Color(.systemTeal)
        case .indigo, .systemIndigo: return Color(.systemIndigo)
        case .mint, .systemMint: return Color(.systemMint)
        case .cyan, .systemCyan: return Color(.systemCyan)
        case .gray, .systemGray: return Color(.systemGray)
        case .systemGray2: return Color(.systemGray2)
        case .systemGray3: return Color(.systemGray3)
        case .systemGray4: return Color(.systemGray4)
        case .systemGray5: return Color(.systemGray5)
        case .systemGray6: return Color(.systemGray6)
        case .label: return Color(.label)
        case .secondaryLabel: return Color(.secondaryLabel)
        case .tertiaryLabel: return Color(.tertiaryLabel)
        case .quaternaryLabel: return Color(.quaternaryLabel)
        case .placeholderText: return Color(.placeholderText)
        case .link: return Color(.link)
        case .separator: return Color(.separator)
        case .opaqueSeparator: return Color(.opaqueSeparator)
        case .systemFill: return Color(.systemFill)
        case .secondarySystemFill: return Color(.secondarySystemFill)
        case .tertiarySystemFill: return Color(.tertiarySystemFill)
        case .quaternarySystemFill: return Color(.quaternarySystemFill)
        case .systemBackground: return Color(.systemBackground)
        case .secondarySystemBackground: return Color(.secondarySystemBackground)
        case .tertiarySystemBackground: return Color(.tertiarySystemBackground)
        case .systemGroupedBackground: return Color(.systemGroupedBackground)
        case .secondarySystemGroupedBackground: return Color(.secondarySystemGroupedBackground)
        case .tertiarySystemGroupedBackground: return Color(.tertiarySystemGroupedBackground)
        case .unknown:
            return Color(hex: OTFColor.lastDecodedRawValue ?? "") ?? .primary
        }
        #endif
    }

    #if os(iOS)
    /// Converts `OTFColor` to a UIKit `UIColor` representation.
    public var uiColor: UIColor {
        switch self {
        case .black: return .black
        case .white: return .white
        case .clear: return .clear
        case .darkGray: return .darkGray
        case .lightGray: return .lightGray
        case .green, .systemGreen: return .systemGreen
        case .blue, .systemBlue: return .systemBlue
        case .red, .systemRed: return .systemRed
        case .orange, .systemOrange: return .systemOrange
        case .yellow, .systemYellow: return .systemYellow
        case .purple, .systemPurple: return .systemPurple
        case .brown, .systemBrown: return .systemBrown
        case .pink, .systemPink: return .systemPink
        case .teal, .systemTeal: return .systemTeal
        case .indigo, .systemIndigo: return .systemIndigo
        case .mint, .systemMint: return .systemMint
        case .cyan, .systemCyan: return .systemCyan
        case .gray, .systemGray: return .systemGray
        case .systemGray2: return .systemGray2
        case .systemGray3: return .systemGray3
        case .systemGray4: return .systemGray4
        case .systemGray5: return .systemGray5
        case .systemGray6: return .systemGray6
        case .label: return .label
        case .secondaryLabel: return .secondaryLabel
        case .tertiaryLabel: return .tertiaryLabel
        case .quaternaryLabel: return .quaternaryLabel
        case .placeholderText: return .placeholderText
        case .link: return .link
        case .separator: return .separator
        case .opaqueSeparator: return .opaqueSeparator
        case .systemFill: return .systemFill
        case .secondarySystemFill: return .secondarySystemFill
        case .tertiarySystemFill: return .tertiarySystemFill
        case .quaternarySystemFill: return .quaternarySystemFill
        case .systemBackground: return .systemBackground
        case .secondarySystemBackground: return .secondarySystemBackground
        case .tertiarySystemBackground: return .tertiarySystemBackground
        case .systemGroupedBackground: return .systemGroupedBackground
        case .secondarySystemGroupedBackground: return .secondarySystemGroupedBackground
        case .tertiarySystemGroupedBackground: return .tertiarySystemGroupedBackground
        case .unknown:
            return UIColor(hex: OTFColor.lastDecodedRawValue ?? "") ?? .label
        }
    }
    #endif

    /// Decodes an `OTFColor` from a `Decoder`, falling back to `.unknown` if the value is invalid.
    ///
    /// - Parameter decoder: The decoder instance.
    /// - Throws: An error if the container can't decode a string.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        if let value = OTFColor(rawValue: rawValue) {
            self = value
        } else {
            OTFColor.lastDecodedRawValue = rawValue
            OTFLog("Unknown OTFColor %@, falling back to .unknown", rawValue)
            self = .unknown
        }
    }
}
