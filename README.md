# OTFTemplateBox

TheraForge's OTFTemplateBox is a comprehensive template framework for zero-code app customization. It can be used by developers and non-developers to fully customize their digital health app just by editing a YAML file in a text editor.

## Change Log

<details open>
<summary>Release 2.0.0</summary>
<ul>
<li><strong>BREAKING:</strong> Complete framework rewrite - not backwards compatible</li>
<li>iOS 16.0+ and watchOS 9.0+ minimum deployment targets</li>
<li>Version-aware YAML parsing with automatic migration</li>
<li>Enhanced internationalization system with OTFStringLocalized</li>
<li>Comprehensive design system with 50+ predefined colors</li>
<li>Complete HealthKit integration for digital health applications</li>
<li>Robust error handling with localized error messages</li>
<li>Cross-platform SwiftUI and UIKit compatibility</li>
</ul>
</details>

<details>
<summary>Release 1.0.5-beta</summary>
<ul>
<li>Improved Readme file</li>
<li>Updated company name and copyright date</li>
</ul>
</details>

<details>
<summary>Release 1.0.4-beta</summary>
<ul>
<li>Added the new OTFDesignSystem pod</li>
<li>Added the watchOS target</li>
</ul>
</details>

<details>
<summary>Release 1.0.3-beta</summary>
<ul>
<li>Added new OTFUtilities pod</li>
<li>Added watchOS support</li>
</ul>
</details>

<details>
<summary>Release 1.0.2-beta</summary>
<ul>
<li>Updated the dependencies of the internal pods to better compensate the Care and Health flags in schemes</li>
</ul>
</details>

<details>
<summary>Release 1.0.0-beta</summary>
<ul>
<li>First beta release of the pods</li>
</ul>
</details>

## Breaking Changes in Version 2.0.0

**WARNING:** Version 2.0.0 is not backwards compatible with any previous versions. The framework has been completely rewritten from the ground up with significant architectural changes.

### New Platform Requirements
- **iOS 16.0+** (previously iOS 13.0+)
- **watchOS 9.0+** (previously watchOS 6.0+)
- **Swift 5.5+**
- **Xcode 14.0+**

## Key Features

### Zero-Code Customization
Configure your entire digital health application through YAML files without writing code. Perfect for healthcare professionals, researchers, and non-technical users.

### Version-Aware Configuration
Automatic parsing and migration of YAML configuration files. The framework intelligently handles version differences and migrates older configurations to the latest schema.

### Comprehensive Design System
- 50+ predefined colors including system colors and semantic color schemes
- Cross-platform font system supporting both SwiftUI and UIKit
- Font weight management with fallback handling
- Adaptive design

### Built-in Internationalization
Native localization support through `OTFStringLocalized` with automatic language resolution based on user preferences.

### Robust Error Handling
Comprehensive error management with localized error messages that can be customized for each supported language locally on your main app's target.

## Installation

You can create your own template application in a few minutes using the OTFTemplate framework. You need to have a **macOS computer** and the **Xcode tool**.

If you are new to Xcode, then follow this [Xcode](https://developer.apple.com/documentation/xcode/creating-an-xcode-project-for-an-app) article to understand the steps to create a new application. 

Add OTFTemplateBox to your project using CocoaPods. Add the following line to your `Podfile`:

```ruby
pod 'OTFTemplateBox'
```

Then run:
```bash
pod install
```

If you are new to Cocoapods then refer here for the [Cocoapods](https://guides.cocoapods.org/using/using-cocoapods.html) installation.

## Configuration

### Basic Configuration File Structure

Create a YAML configuration file (e.g., `AppConfiguration.yml`) in your app bundle:

```yaml
version: "2.0.0"
apiKey: "XXXXXXXXXXXXXXXXX"
protectionLevel: "runToCompletionBeyond10Seconds"
theme: "Blue Sky"
enableLogging: false
animationSpeed: 0.75
extraFeatureEnabled: true
titleFont: "largeTitle"
titleFontWeight: "black"
titleColor: "#CCCCCC"
subtitleColor: "systemIndigo"
cardBackgroundColor: "systemBackground"

welcomeMessage:
  en: "Welcome"
  pt: "Bem-vindo"
  es: "Bienvenido"
  fr: "Bienvenue"
  
goodbyeMessage:
  en: "Goodbye"
  pt: "Adeus"
  es: "Adiós"
  fr: "Au revoir"
```

### Swift Implementation

```swift
import OTFTemplateBox

// Define your model
struct AppConfiguration: Codable, OTFVersionedDecodable {
    let version: String?
    let apiKey: String?
    let theme: String?
    let protectionLevel: String?
    let enableLogging: Bool?
    let animationSpeed: Double?
    let extraFeatureEnabled: Bool?
    let welcomeMessage: OTFStringLocalized?
    let goodbyeMessage: OTFStringLocalized?
    let titleFont: OTFFont?
    let titleFontWeight: OTFFontWeight?
    let titleColor: OTFColor?
    let subtitleColor: OTFColor?
    let cardBackgroundColor: OTFColor?

    static let fallback = AppConfiguration(
        version: "3.0.0",
        apiKey: "XXXXXXXXXXXXXXXXX",
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

    init(from raw: AppConfiguration) {
        let fallback = Self.fallback
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

    static func migrate(from version: OTFSemanticVersion, raw: RawAppConfiguration) throws -> AppConfiguration {
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
        return AppConfiguration(from: migrated)
    }
}

// Load and use configuration
let decoder = OTFYAMLDecoderEngine()
do {
    let config = try decoder.decode("AppConfiguration", as: AppConfiguration.self)
    
    // Use localized strings
    let localizedWelcome = config.welcomeMessage.localized
    
    // Use design system
    let titleColor = config.titleColor.color // SwiftUI Color
    let titleUIColor = config.titleColor.uiColor // UIKit UIColor
    
} catch {
    print("Configuration loading failed: \(error.localizedDescription)")
}
```

### Advanced Configuration Options

#### Colors
Supports both predefined system colors and custom hex values:
```yaml
primaryColor: "systemBlue"          # Adaptive system color
backgroundColor: "systemBackground" # Adaptive system color
secondaryColor: "#FF5733"           # Static Custom hex color
```

#### Fonts and Typography
```yaml
headlineFont: "largeTitle"          # System font styles
headlineFontWeight: "bold"          # Font weights
bodyFont: "body"
captionFont: "caption"
```

## Migration from Version 1.x

Version 2.0.0 requires manual migration due to the complete architectural rewrite:

1. **Update Dependencies**: Replace your Podfile entry and run `pod update`
2. **Update Platform Targets**: Set minimum deployment to iOS 16.0+ and watchOS 9.0+
3. **Restructure Configuration**: Convert old configuration format to new YAML structure
4. **Update Code**: Replace old API calls with new `OTFYAMLDecoderEngine` implementation
5. **Test Thoroughly**: All functionality must be re-tested due to breaking changes

### Configuration Migration Example

**Old format (1.x):**
```yaml
appTitle: "My Health App"
primaryColor: "blue"
enableNotifications: true
```

**New format (2.0):**
```yaml
version: "2.0.0"
appTitle:
  en: "My Health App"
  pt: "Minha App de Saúde"
primaryColor: "systemBlue"
enableNotifications: true
```

## Supported Platforms

- **iOS 16.0+**
- **watchOS 9.0+**
- **macOS 13.0+** (limited support)

## Dependencies

- [Yams](https://github.com/jpsim/Yams)
- [OTFUtilities](../../../OTFUtilities)

## License

This project is made available under the terms of a modified BSD license. See the [LICENSE](LICENSE.md) file.