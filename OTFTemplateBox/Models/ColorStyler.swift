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
import OTFCareKitUI
import OTFUtilities

struct ColorStyler: OCKColorStyler {
    static var label: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "label") {
            return colorText.color()
        }
        OTFLog("Cannot find label color, use default")
        return .label
    }

    static var secondaryLabel: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "secondaryLabel") {
            return colorText.color()
        }
        OTFLog("Cannot find secondaryLabel color, use default")
        return .secondaryLabel
    }

    static var tertiaryLabel: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "tertiaryLabel") {
            return colorText.color()
        }
        OTFLog("Cannot find tertiaryLabel color, use default")
        return .tertiaryLabel
    }

    static var customBackground: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customBackground") {
            return colorText.color()
        }
        OTFLog("Cannot find customBackground color, use default")
        return .systemBackground
    }

    static var secondaryCustomBackground: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "secondaryCustomBackground") {
            return colorText.color()
        }
        OTFLog("Cannot find secondaryCustomBackground color, use default")
        return .secondarySystemBackground
    }

    static var customGroupedBackground: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customGroupedBackground") {
            return colorText.color()
        }
        OTFLog("Cannot find customGroupedBackground color, use default")
        return .systemGroupedBackground
    }

    static var secondaryCustomGroupedBackground: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "secondaryCustomGroupedBackground") {
            return colorText.color()
        }
        OTFLog("Cannot find secondaryCustomGroupedBackground color, use default")
        return .secondarySystemGroupedBackground
    }

    static var tertiaryCustomGroupedBackground: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "tertiaryCustomGroupedBackground") {
            return colorText.color()
        }
        OTFLog("Cannot find tertiaryCustomGroupedBackground color, use default")
        return .tertiarySystemGroupedBackground
    }

    static var separator: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "separator") {
            return colorText.color()
        }
        OTFLog("Cannot find separator color, use default")
        return .separator
    }

    static var customFill: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customFill") {
            return colorText.color()
        }
        OTFLog("Cannot find customFill color, use default")
        return .tertiarySystemFill
    }

    static var secondaryCustomFill: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "secondaryCustomFill") {
            return colorText.color()
        }
        OTFLog("Cannot find secondaryCustomFill color, use default")
        return .secondarySystemFill
    }

    static var tertiaryCustomFill: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "tertiaryCustomFill") {
            return colorText.color()
        }
        OTFLog("Cannot find tertiaryCustomFill color, use default")
        return .tertiarySystemFill
    }

    static var quaternaryCustomFill: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "quaternaryCustomFill") {
            return colorText.color()
        }
        OTFLog("Cannot find quaternaryCustomFill color, use default")
        return .quaternarySystemFill
    }

    static var customBlue: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customBlue") {
            return colorText.color()
        }
        OTFLog("Cannot find customBlue color, use default")
        return .systemBlue
    }

    static var customGray: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customGray") {
            return colorText.color()
        }
        OTFLog("Cannot find customGray color, use default")
        return .systemGray
    }

    static var customGray2: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customGray2") {
            return colorText.color()
        }
        OTFLog("Cannot find customGray2 color, use default")
        return .systemGray2
    }

    static var customGray3: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customGray3") {
            return colorText.color()
        }
        OTFLog("Cannot find customGray3 color, use default")
        return .systemGray3
    }

    static var customGray4: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customGray4") {
            return colorText.color()
        }
        OTFLog("Cannot find customGray4 color, use default")
        return .systemGray4
    }

    static var customGray5: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "customGray5") {
            return colorText.color()
        }
        OTFLog("Cannot find customGray5 color, use default")
        return .systemGray5
    }

    static var white: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "white") {
            return colorText.color()
        }
        OTFLog("Cannot find white color, use default")
        return .white
    }

    static var black: UIColor {
        if let colorText = OTFConfigManager.shared.getValue(for: "black") {
            return colorText.color()
        }
        OTFLog("Cannot find black color, use default")
        return .black
    }
    static var clear: UIColor { .clear }
}
