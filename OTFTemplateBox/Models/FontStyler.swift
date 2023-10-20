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
import OTFUtilities

struct FontStyler {
    static var largeTitle: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "largeTitleFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "largeTitleFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of largeTitleFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find largeTitleFontName or largeTitleFontSize, use default")
        return defaultFont
    }

    static var title: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "titleFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "titleFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of titleFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find titleFontName or titleFontSize, use default")
        return defaultFont
    }

    static var title2: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "title2FontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "title2FontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of title2FontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find title2FontName or title2FontSize, use default")
        return defaultFont
    }

    static var title3: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "title3FontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "title3FontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of title3FontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find title3FontName or title3FontSize, use default")
        return defaultFont
    }

    static var headline: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "headlineFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "headlineFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of headlineFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find title3FontName or title3FontSize, use default")
        return defaultFont
    }

    static var subheadline: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "subheadlineFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "subheadlineFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of subheadlineFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find subheadlineFontName or subheadlineFontSize, use default")
        return defaultFont
    }

    static var body: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "bodyFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "bodyFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of bodyFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find bodyFontName or bodyFontSize, use default")
        return defaultFont
    }

    static var callout: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "calloutFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "calloutFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of calloutFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find calloutFontName or calloutFontSize, use default")
        return defaultFont
    }

    static var caption: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "captionFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "captionFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of calloutFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find captionFontName or captionFontSize, use default")
        return defaultFont
    }

    static var caption2: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "caption2FontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "caption2FontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of caption2FontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find caption2FontName or caption2FontSize, use default")
        return defaultFont
    }

    static var footnote: UIFont {
        let defaultFont = UIFont.systemFont(ofSize: 20, weight: .regular)
        if let fontName = OTFConfigManager.shared.getValue(for: "footnoteFontName"),
            let fontSizeText = OTFConfigManager.shared.getValue(for: "footnoteFontSize") {
            if let font = UIFont(name: fontName, size: fontSizeText.floatValue) {
                return font
            }
            OTFLog("Cannot init font with name of footnoteFontName: %{public}@ ", fontName)
            return defaultFont
        }
        OTFLog("Cannot find footnoteFontName or footnoteFontSize, use default")
        return defaultFont
    }
}
