<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
## Description
A new Flutter package that provides native iOS Color Picker cloned UI for all platforms, with iOS Native color Picker option for iOS only 

## Supported Platforms

- Linux
- macOS
- Web
- Windows
- iOS
- Android

## Features

### Screenshots & Demo

<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504135/color_picker/1_v2nk8m.png" width="300">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1738019895/color_picker/esmczhsgeo6qk7py5x66.gif" width="300">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504183/color_picker/1_p91sih.gif" width="300">
<img src="https://res.cloudinary.com/dcvoshrrl/image/upload/v1737504212/color_picker/3_zkbdzu.gif" width="300">



## Getting Started

This package is easy to integrate into your Flutter application. See the usage section below to get started.

## Usage

```dart
/// Native iOS Color Picker
ElevatedButton(
  onPressed: () {
    iosColorPickerController.showNativeIosColorPicker(
      startingColor: backgroundColor,
      darkMode: true,
      onColorChanged: (color) {
        setState(() {
          backgroundColor = color;
        });
      },
    );
  },
  child: Text("Native iOS"),
),

/// Custom iOS Color Picker (for all platforms)
ElevatedButton(
  onPressed: () {
    iosColorPickerController.showIOSCustomColorPicker(
      startingColor: backgroundColor,
      onColorChanged: (color) {
        setState(() {
          backgroundColor = color;
        });
      },
      context: context,
    );
  },
  child: Text("Custom iOS for all"),
),
```
## You have to
Dispose the controller because the streamer, check the example in example/ folder
```dart
  IOSColorPickerController iosColorPickerController =
      IOSColorPickerController();

  @override
  void dispose() {
    iosColorPickerController.dispose();
    super.dispose();
  }

```
🧪 Example

Run the app in the example/ folder to explore the plugin.

Additional Information

For more updates and inquiries, connect with me on LinkedIn:

<a href="https://www.linkedin.com/in/mo-kh-selim/"> <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/LinkedIn_icon.svg/144px-LinkedIn_icon.svg.png" width="32" /> </a>