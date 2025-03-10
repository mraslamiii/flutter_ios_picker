import 'package:flutter/material.dart';
import 'package:ios_color_picker/show_ios_color_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS Color Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color backgroundColor = Colors.green;
  IOSColorPickerController iosColorPickerController =
      IOSColorPickerController();

  @override
  void dispose() {
    iosColorPickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                iosColorPickerController.showNativeIosColorPicker(
                  darkMode: true,
                  startingColor: backgroundColor,
                  onColorChanged: (color) {
                    setState(() => backgroundColor = color);
                  },
                );
              },
              child: Text("Native iOS"),
            ),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     iosColorPickerController.showIOSCustomColorPicker(
            //       context: context,
            //       startingColor: backgroundColor,
            //       onColorChanged: (color) {
            //         setState(() => backgroundColor = color);
            //       },
            //     );
            //   },
            //   child: Text("Custom iOS for all"),
            // ),
          ],
        ),
      ),
    );
  }
}
