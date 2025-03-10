import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_color_picker/native_picker/ios_color_picker_platform_interface.dart';
import 'package:ios_color_picker/native_picker/ios_color_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIosColorPickerPlatform
    with MockPlatformInterfaceMixin
    implements IosColorPickerPlatform {
  @override
  Future<Color?> getPlatformColor(
      Map<String, double>? defaultColor, bool? darkMode) {
    // TODO: implement getPlatformColor
    throw UnimplementedError();
  }
}

void main() {
  final IosColorPickerPlatform initialPlatform =
      IosColorPickerPlatform.instance;

  test('$MethodChannelIosColorPicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIosColorPicker>());
  });

  // test('getPlatformVersion', () async {
  //   IosColorPicker iosColorPickerPlugin = IosColorPicker();
  //   MockIosColorPickerPlatform fakePlatform = MockIosColorPickerPlatform();
  //   IosColorPickerPlatform.instance = fakePlatform;
  //
  //   expect(await iosColorPickerPlugin.getPlatformVersion(), '42');
  // });
}
