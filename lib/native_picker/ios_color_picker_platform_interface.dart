import 'dart:ui';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'ios_color_picker_method_channel.dart';

abstract class IosColorPickerPlatform extends PlatformInterface {
  /// Constructs a IosColorPickerV2Platform.
  IosColorPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static IosColorPickerPlatform _instance = MethodChannelIosColorPicker();

  /// The default instance of [IosColorPickerV2Platform] to use.
  ///
  /// Defaults to [MethodChannelIosColorPickerV2].
  static IosColorPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IosColorPickerV2Platform] when
  /// they register themselves.
  static set instance(IosColorPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Color?> getPlatformColor(Map<String, double>? defaultColor, bool? darkMode) {
    throw UnimplementedError('getPlatformColor() has not been implemented.');
  }
}
