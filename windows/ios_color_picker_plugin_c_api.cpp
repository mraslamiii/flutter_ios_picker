#include "include/ios_color_picker/ios_color_picker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ios_color_picker_plugin.h"

void IosColorPickerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ios_color_picker::IosColorPickerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
