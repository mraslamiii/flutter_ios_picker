import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'custom_picker/color_observer.dart';
import 'custom_picker/ios_color_picker.dart';
import 'custom_picker/extensions.dart';
import 'native_picker/ios_color_picker_platform_interface.dart';

///Don't forget to Dispose the controller
///
///because the streamer, check the example in example/ folder
class IOSColorPickerController {
  Color selectedColor = Colors.green;
  static const _eventChannel = EventChannel('ios_color_picker_stream');
  StreamSubscription? _colorSubscription;

  /// iOS Native color Picker, Only for iOS.
  ///
  /// If [darkMode] is [null], then the color will depend on device system
  /// [startingColor] is [null] then the default color will be green
  Future<void> showNativeIosColorPicker({
    required ValueChanged<Color> onColorChanged,
    Color? startingColor,
    bool? darkMode,
  }) async {
    assert(Platform.isIOS,
        "Only works for iOS use (showIOSCustomColorPicker) for other platforms");

    selectedColor = startingColor ?? selectedColor;

    IosColorPickerPlatform.instance
        .getPlatformColor(selectedColor.toMap(), darkMode);
    _colorSubscription = _eventChannel.receiveBroadcastStream().listen((event) {
      if (event != null) {
        try {
          selectedColor = (event as Map<Object?, Object?>).toColor();
        } catch (error) {
          rethrow;
        }

        onColorChanged(selectedColor);
      }
    }, onError: (err) {
      throw err;
    });
  }

  /// iOS Native color Picker clone, for all Platforms.
  ///
  /// [startingColor] is [null] then the default color will be green
  void showIOSCustomColorPicker({
    required BuildContext context,
    required Widget
        alternateWidget,
    required List<String> icons,
    required ValueChanged<Color> onColorChanged,
    Color? startingColor,
  }) async {
    colorController = ColorController(startingColor ?? selectedColor);

    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return IOSColorPickerBottomSheet(
          alternateWidget: alternateWidget,
          icons: icons,
          onColorChanged: onColorChanged,
        );
      },
    );
  }

  /// Cancel the color subscription
  void cancelColorSubscription() {
    if (_colorSubscription != null) {
      _colorSubscription!.cancel();
      _colorSubscription = null;
    }
  }

  /// Dispose resources
  void dispose() {
    cancelColorSubscription();
  }
}

class IOSColorPickerBottomSheet extends StatefulWidget {
  final Widget alternateWidget;
  final List<String> icons;
  final ValueChanged<Color> onColorChanged;

  const IOSColorPickerBottomSheet({
    Key? key,
    required this.alternateWidget,
    required this.icons,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  _IOSColorPickerBottomSheetState createState() =>
      _IOSColorPickerBottomSheetState();
}

class _IOSColorPickerBottomSheetState extends State<IOSColorPickerBottomSheet> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: currentIndex == 0
              ? IosColorPicker(
                  onColorSelected: (value) {
                    widget.onColorChanged(value);
                  },
                )
              : widget.alternateWidget,
        ),
        BottomNavigationBar(
          backgroundColor: Colors.grey.shade900,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                widget.icons[0],
                color: currentIndex == 0 ? Colors.white : Colors.grey,
              ),
              label: 'Solid',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                widget.icons[1],
                color: currentIndex == 1 ? Colors.white : Colors.grey,
              ),
              label: 'Gradient',
            ),
          ],
        ),
      ],
    );
  }
}
