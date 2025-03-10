#ifndef FLUTTER_PLUGIN_IOS_COLOR_PICKER_PLUGIN_H_
#define FLUTTER_PLUGIN_IOS_COLOR_PICKER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace ios_color_picker {

class IosColorPickerPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  IosColorPickerPlugin();

  virtual ~IosColorPickerPlugin();

  // Disallow copy and assign.
  IosColorPickerPlugin(const IosColorPickerPlugin&) = delete;
  IosColorPickerPlugin& operator=(const IosColorPickerPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace ios_color_picker

#endif  // FLUTTER_PLUGIN_IOS_COLOR_PICKER_PLUGIN_H_
