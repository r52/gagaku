import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/reader/widgets/passive_tap_listener.dart';

void main() {
  Widget buildSubject({required PassiveTapCallback onTap, Widget? child}) {
    return MaterialApp(
      home: Scaffold(
        body: PassiveTapListener(
          onTap: onTap,
          child: child ?? const SizedBox.expand(),
        ),
      ),
    );
  }

  testWidgets('reports a stationary single tap after the double-tap window', (
    tester,
  ) async {
    final taps = <Offset>[];
    const position = Offset(120, 180);

    await tester.pumpWidget(buildSubject(onTap: taps.add));
    await tester.tapAt(position);

    expect(taps, isEmpty);

    await tester.pump(kDoubleTapTimeout);

    expect(taps, [position]);
  });

  testWidgets('does not report a drag as a tap', (tester) async {
    final taps = <Offset>[];
    var dragEnds = 0;

    await tester.pumpWidget(
      buildSubject(
        onTap: taps.add,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragEnd: (_) => dragEnds++,
          child: const SizedBox.expand(),
        ),
      ),
    );

    final gesture = await tester.startGesture(const Offset(120, 180));
    await gesture.moveBy(const Offset(kTouchSlop + 10, 0));
    await gesture.up();
    await tester.pump(kDoubleTapTimeout);

    expect(taps, isEmpty);
    expect(dragEnds, 1);
  });

  testWidgets('does not report a multi-touch sequence as a tap', (
    tester,
  ) async {
    final taps = <Offset>[];

    await tester.pumpWidget(buildSubject(onTap: taps.add));

    final first = await tester.createGesture(pointer: 1);
    final second = await tester.createGesture(pointer: 2);
    await first.down(const Offset(120, 180));
    await second.down(const Offset(180, 180));
    await second.up();
    await first.up();
    await tester.pump(kDoubleTapTimeout);

    expect(taps, isEmpty);
  });

  testWidgets('suppresses tap callbacks while child handles a double tap', (
    tester,
  ) async {
    final taps = <Offset>[];
    var doubleTaps = 0;
    const position = Offset(120, 180);

    await tester.pumpWidget(
      buildSubject(
        onTap: taps.add,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTap: () => doubleTaps++,
          child: const SizedBox.expand(),
        ),
      ),
    );

    await tester.tapAt(position);
    await tester.pump(kDoubleTapMinTime);
    await tester.tapAt(position);
    await tester.pump(kDoubleTapTimeout);

    expect(taps, isEmpty);
    expect(doubleTaps, 1);
  });
}
