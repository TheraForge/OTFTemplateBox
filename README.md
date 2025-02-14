# OTFTemplateBox

TheraForge's OTFTemplateBox is a template framework for zero-code app customization. It can be used by programmers as well as by non-programmers to customize their digital health app just by editing a YAML file in a text editor.
This framework supports an app configuration and a UX customization file with default overridable values.

OTFTemplateBox provides a number of customization options for the application through the *AppSysParameters.yml* file. This file is a text-based table that contains key/value pairs. Each pair specifies a different application parameter, which is a redefinable constant for the app to read at launch to define parts of its behavior.

Every key must be associated to a value but the app will **not crash** if the value is missing or mistyped.

Please refer to the [OTFToolBox Readme](../../../OTFToolBox/blob/main/README.md) for the full details of the configuration file.

## Change Log
<details open>
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

<details >
<summary>Release 1.0.3-beta</summary>
  <ul>
    <li>Added new OTFUtilities pod</li>
    <li>Added watchOS support</li>
  </ul>
</details>

<details >
<summary>Release 1.0.2-beta</summary>
<ul>
<li>Updated the dependecies of the internal pods to better compensate the Care and Health flags in schemes</li>
</ul>
</details>

<details>
<summary>Release 1.0.0-beta</summary>
<ul>
<li>First beta release of the pods</li>
</ul>
</details>

## Table of Contents
* [Overview](#Overview)
* [Installation](#Installation)
* [License](#License)

## Overview <a name="Overview"></a>
TheraForge's OTFTemplateBox framework provides the YAML file where you can customize the parameters of your digital health applications.
The OTFTemplateBox framework has predefined functions which read the YAML file and style your application accordingly. This framework provides an app template library based on a user-modifiable YAML file for flexible customization of constants, texts, images, links, styles, etc.
The OTFTemplateBox framework is dependent on the [Yams](https://github.com/jpsim/Yams), [OTFCareKitUI](../../../OTFCareKit), [OTFToolBoxCore](../../../OTFToolBox) and [OTFDesignSystem](../../../OTFDesignSystem) frameworks.

## Installation <a name="Installation"></a>

You can create your own template application in a few minutes using the OTFTemplate framework. Prior to creating a template application, you need to have a **macOS computer** and the **Xcode tool**.

If you are new to Xcode, then follow this [Xcode](https://developer.apple.com/documentation/xcode/creating-an-xcode-project-for-an-app) article to understand the steps to create a new application. 

Integrating OTFTemplateBox with an existing workspace requires the extra line below to be added to your Podfile.

```
pod 'OTFTemplateBox'
```

If you are new to Cocoapods then refer here for the [Cocoapods](https://guides.cocoapods.org/using/using-cocoapods.html) installation.

# License <a name="License"></a>

This project is made available under the terms of a modified BSD license. See the [LICENSE](LICENSE.md) file.
