import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_color_picker/custom_picker/pickers/slider_picker/slider_helper.dart';
import 'package:ios_color_picker/custom_picker/pickers_selector_row.dart';
import 'package:ios_color_picker/custom_picker/shared.dart';

import 'color_observer.dart';
import 'helpers/cache_helper.dart';
import 'history_colors.dart';

///Returns iOS Style color Picker
class IosColorPicker extends StatefulWidget {
  const IosColorPicker({
    super.key,
    required this.onColorSelected,
  });

  ///returns the selected color
  final ValueChanged<Color> onColorSelected;

  @override
  State<IosColorPicker> createState() => _IosColorPickerState();
}

class _IosColorPickerState extends State<IosColorPicker> {
  late TextEditingController _hexController;
  late FocusNode _hexFocusNode;
  bool _isHexFieldFocused = false;

  @override
  void initState() {
    super.initState();
    CacheHelper.init();
    _hexController = TextEditingController();
    _hexFocusNode = FocusNode();

    _hexFocusNode.addListener(() {
      setState(() {
        _isHexFieldFocused = _hexFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _hexController.dispose();
    _hexFocusNode.dispose();
    super.dispose();
  }

  Color? _parseHex(String input, {double alpha = 1.0}) {
    final hex = input.replaceAll('#', '').trim();
    if (hex.length == 6) {
      final int? colorValue = int.tryParse(hex, radix: 16);
      if (colorValue != null) {
        return Color(((0xFF * 256 * 256 * 256) | colorValue)).withOpacity(alpha);
      }
    }
    return null;
  }

  String _toHex(Color color) {
    final hex = (color.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0');
    return '#${hex.toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: maxWidth(context),
              ),
            ),
          ),
          Container(
            width: maxWidth(context),
            height: 360 + componentsHeight(context),
            decoration: BoxDecoration(
              color: backgroundColor.withValues(alpha: 0.98),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    0,
                    8,
                    2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Colors',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        highlightColor: Colors.transparent,
                        onPressed: () => Navigator.pop(context),
                        icon: Container(
                          padding: EdgeInsets.all(4),
                          decoration:
                              BoxDecoration(color: Color(0xff3A3A3B), shape: BoxShape.circle),
                          child: Icon(
                            Icons.close_rounded,
                            color: Color(0xffA4A4AA),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: -1.0,
                        child: child,
                      ),
                    );
                  },
                  child: !_isHexFieldFocused
                      ? PickersSelectorRow(
                          key: const ValueKey('pickers_visible'),
                          onColorChanged: widget.onColorSelected,
                        )
                      : const SizedBox(
                          key: ValueKey('pickers_hidden'),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 17,
                    right: 17,
                    bottom: 12,
                  ),
                  child: ValueListenableBuilder<Color>(
                    valueListenable: colorController,
                    builder: (context, color, _) {
                      final String hexString = _toHex(color);
                      if (_hexController.text.toUpperCase() != hexString) {
                        _hexController.text = hexString;
                      }
                      return CupertinoTextField(
                        controller: _hexController,
                        placeholder: "#RRGGBB",
                        focusNode: _hexFocusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A3B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            CupertinoIcons.number,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                        onChanged: (val) {
                          final parsed = _parseHex(val);
                          if (parsed != null) {
                            final newColor = parsed.withOpacity(color.opacity);
                            colorController.value = newColor;
                            widget.onColorSelected(newColor);
                          }
                        },
                      );
                    },
                  ),
                ),

                ///ALL
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: Text(
                    'OPACITY',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 13, color: Colors.white.withValues(alpha: 0.6)),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
                        child: SizedBox(
                          height: 36.0,
                          child: ValueListenableBuilder<Color>(
                            valueListenable: colorController,
                            builder: (context, color, child) {
                              return ColorPickerSlider(TrackType.alpha, HSVColor.fromColor(color),
                                  small: false, (v) {
                                colorController.updateOpacity(v.alpha);
                                widget.onColorSelected(colorController.value);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 77,
                      margin: const EdgeInsets.only(right: 16, left: 16),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: valueColor, borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: ValueListenableBuilder<Color>(
                        valueListenable: colorController,
                        builder: (context, color, child) {
                          int alpha = (color.a * 100).toInt();
                          return Text(
                            "$alpha%",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 16,
                                letterSpacing: 0.6,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          );
                        },
                      ),
                    )
                  ],
                ),
                // const SizedBox(
                //   height: 44,
                // ),
                Divider(
                  height: 44,
                  thickness: 0.2,
                  indent: 17,
                  endIndent: 17,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 78,
                          width: 78,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: const EdgeInsets.only(
                            left: 16,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Transform.scale(
                            scale: 1.5,
                            child: Transform.rotate(
                              angle: 0.76,
                              child: Row(
                                children: [
                                  Expanded(child: Container(color: Colors.white)),
                                  Expanded(child: Container(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ValueListenableBuilder<Color>(
                          valueListenable: colorController,
                          builder: (context, color, child) {
                            return Container(
                              height: 78,
                              width: 78,
                              margin: const EdgeInsets.only(
                                left: 16,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: color),
                            );
                          },
                        ),
                      ],
                    ),
                    HistoryColors(
                      onColorChanged: widget.onColorSelected,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
