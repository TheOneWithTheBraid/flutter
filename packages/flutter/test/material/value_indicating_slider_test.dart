// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This file is run as part of a reduced test set in CI on Mac and Windows
// machines.
@Tags(<String>['reduced-test-set'])

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Slider value indicator', (WidgetTester tester) async {
    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0,
    );

    await _pressStartThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_start_text_scale_1_width_0.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0.5,
    );

    await _pressMiddleThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_middle_text_scale_1_width_0.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 1,
    );

    await _pressEndThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_end_text_scale_1_width_0.png'),
    );
  });

  testWidgets('Slider value indicator wide text', (WidgetTester tester) async {
    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0,
      decimalCount: 5,
    );

    await _pressStartThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_start_text_scale_1_width_5.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0.5,
      decimalCount: 5,
    );

    await _pressMiddleThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_middle_text_scale_1_width_5.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 1,
      decimalCount: 5,
    );

    await _pressEndThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_end_text_scale_1_width_5.png'),
    );
  });

  testWidgets('Slider value indicator large text scale', (WidgetTester tester) async {
    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0,
      textScale: 3,
    );

    await _pressStartThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_start_text_scale_4_width_0.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0.5,
      textScale: 3,
    );

    await _pressMiddleThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_middle_text_scale_4_width_0.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 1,
      textScale: 3,
    );

    await _pressEndThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_end_text_scale_4_width_0.png'),
    );
  });

  testWidgets('Slider value indicator large text scale and wide text',
      (WidgetTester tester) async {
    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0,
      textScale: 3,
      decimalCount: 5,
    );

    await _pressStartThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_start_text_scale_4_width_5.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 0.5,
      textScale: 3,
      decimalCount: 5,
    );

    await _pressMiddleThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_middle_text_scale_4_width_5.png'),
    );

    await _buildValueIndicatorStaticSlider(
      tester,
      value: 1,
      textScale: 3,
      decimalCount: 5,
    );

    await _pressEndThumb(tester);

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('slider_end_text_scale_4_width_5.png'),
    );
  });
}

Future<void> _pressStartThumb(WidgetTester tester) async {
  final Offset bottomLeft = tester.getBottomLeft(find.byType(Slider));
  final Offset topLeft = tester.getTopLeft(find.byType(Slider));
  final Offset left = (bottomLeft + topLeft) / 2;
  final Offset start = left + const Offset(24, 0);
  await tester.startGesture(start);
  await tester.pumpAndSettle();
}

Future<void> _pressMiddleThumb(WidgetTester tester) async {
  await tester.press(find.byType(Slider));
  await tester.pumpAndSettle();
}

Future<void> _pressEndThumb(WidgetTester tester) async {
  final Offset bottomRight = tester.getBottomRight(find.byType(Slider));
  final Offset topRight = tester.getTopRight(find.byType(Slider));
  final Offset right = (bottomRight + topRight) / 2;
  final Offset start = right - const Offset(24, 0);
  await tester.startGesture(start);
  await tester.pumpAndSettle();
}

Future<void> _buildValueIndicatorStaticSlider(
  WidgetTester tester, {
  required double value,
  double textScale = 1.0,
  int decimalCount = 0,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: MediaQuery(
                data: MediaQueryData(textScaleFactor: textScale),
                child: SliderTheme(
                  data: Theme.of(context).sliderTheme.copyWith(
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: Slider(
                    value: value,
                    label: value.toStringAsFixed(decimalCount),
                    onChanged: (double newValue) {},
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}