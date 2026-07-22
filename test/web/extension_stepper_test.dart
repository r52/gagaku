import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/web/extension_stepper.dart';

void main() {
  setUpAll(() async {
    await LocaleSettings.setLocale(AppLocale.en);
  });

  group('PaperbackStepper', () {
    testWidgets(
      'formats integer and fractional values without trailing zeroes',
      (tester) async {
        final harness = await _pumpStepper(
          tester,
          value: 2.0,
          minValue: 0,
          maxValue: 10,
          stepValue: 0.25,
        );
        addTearDown(harness.dispose);

        expect(_field(tester).controller!.text, '2');

        harness.value.value = 2.5;
        await tester.pump();
        expect(_field(tester).controller!.text, '2.5');
      },
    );

    testWidgets('normalizes fractional step arithmetic', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 0.1,
        minValue: 0,
        maxValue: 1,
        stepValue: 0.1,
      );
      addTearDown(harness.dispose);

      await _tapIncrement(tester);
      await _tapIncrement(tester);

      expect(harness.changes, [0.2, 0.3]);
      expect(_field(tester).controller!.text, '0.3');
    });

    testWidgets('clamps button overshoot at both bounds', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 0.9,
        minValue: 0,
        maxValue: 1,
        stepValue: 0.3,
      );
      addTearDown(harness.dispose);

      await _tapIncrement(tester);
      expect(harness.changes, [1.0]);
      expect(_incrementButton(tester).onPressed, isNull);

      harness.value.value = 0.1;
      await tester.pump();
      await _tapDecrement(tester);
      expect(harness.changes.last, 0.0);
      expect(_decrementButton(tester).onPressed, isNull);
    });

    testWidgets('wraps button overshoot when loopOver is enabled', (
      tester,
    ) async {
      final harness = await _pumpStepper(
        tester,
        value: 0.9,
        minValue: 0,
        maxValue: 1,
        stepValue: 0.3,
        loopOver: true,
      );
      addTearDown(harness.dispose);

      await _tapIncrement(tester);
      expect(harness.changes, [0.0]);
      expect(_incrementButton(tester).onPressed, isNotNull);

      await _tapDecrement(tester);
      expect(harness.changes.last, 1.0);
      expect(_decrementButton(tester).onPressed, isNotNull);
    });

    testWidgets('supports negative ranges', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: -1.5,
        minValue: -2,
        maxValue: 0,
        stepValue: 0.25,
      );
      addTearDown(harness.dispose);

      await _tapIncrement(tester);

      expect(harness.changes, [-1.25]);
      expect(_field(tester).controller!.text, '-1.25');
    });

    testWidgets('commits typed values once on submission', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 1,
        minValue: -10,
        maxValue: 10,
        stepValue: 0.5,
      );
      addTearDown(harness.dispose);

      await tester.enterText(find.byKey(PaperbackStepper.textFieldKey), '-2.5');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(harness.changes, [-2.5]);
      expect(_field(tester).controller!.text, '-2.5');
    });

    testWidgets('clamps typed values instead of wrapping them', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 5,
        minValue: 0,
        maxValue: 10,
        stepValue: 1,
        loopOver: true,
      );
      addTearDown(harness.dispose);

      await tester.enterText(find.byKey(PaperbackStepper.textFieldKey), '12');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(harness.changes, [10.0]);
      expect(_field(tester).controller!.text, '10');
    });

    testWidgets('restores the accepted value after an invalid draft', (
      tester,
    ) async {
      final harness = await _pumpStepper(
        tester,
        value: 3,
        minValue: 0,
        maxValue: 10,
        stepValue: 1,
      );
      addTearDown(harness.dispose);

      await tester.enterText(find.byKey(PaperbackStepper.textFieldKey), '-');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(harness.changes, isEmpty);
      expect(_field(tester).controller!.text, '3');
    });

    testWidgets('does not emit an unchanged typed value', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 3,
        minValue: 0,
        maxValue: 10,
        stepValue: 0.5,
      );
      addTearDown(harness.dispose);

      await tester.enterText(find.byKey(PaperbackStepper.textFieldKey), '3.0');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(harness.changes, isEmpty);
      expect(_field(tester).controller!.text, '3');
    });

    testWidgets('commits a valid draft when focus is lost', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 3,
        minValue: 0,
        maxValue: 10,
        stepValue: 1,
      );
      addTearDown(harness.dispose);

      await tester.enterText(find.byKey(PaperbackStepper.textFieldKey), '4');
      await tester.tapAt(const Offset(10, 300));
      await tester.pump();

      expect(harness.changes, [4.0]);
      expect(_field(tester).controller!.text, '4');
    });

    testWidgets('an authoritative parent update replaces a draft', (
      tester,
    ) async {
      final harness = await _pumpStepper(
        tester,
        value: 3,
        minValue: 0,
        maxValue: 10,
        stepValue: 1,
      );
      addTearDown(harness.dispose);

      await tester.enterText(find.byKey(PaperbackStepper.textFieldKey), '8');
      harness.value.value = 4;
      await tester.pump();

      expect(_field(tester).controller!.text, '4');
      expect(harness.changes, isEmpty);
    });

    testWidgets('disables both buttons for a single-value range', (
      tester,
    ) async {
      final harness = await _pumpStepper(
        tester,
        value: 2,
        minValue: 2,
        maxValue: 2,
        stepValue: 1,
        loopOver: true,
      );
      addTearDown(harness.dispose);

      expect(_decrementButton(tester).onPressed, isNull);
      expect(_incrementButton(tester).onPressed, isNull);
    });

    testWidgets('invalid configuration is stable and non-interactive', (
      tester,
    ) async {
      final harness = await _pumpStepper(
        tester,
        value: 5,
        minValue: 10,
        maxValue: 0,
        stepValue: 0,
      );
      addTearDown(harness.dispose);

      expect(_field(tester).controller!.text, '5');
      expect(_field(tester).enabled, isFalse);
      expect(_decrementButton(tester).onPressed, isNull);
      expect(_incrementButton(tester).onPressed, isNull);
      expect(harness.changes, isEmpty);
    });

    testWidgets('explicit disabled state is non-interactive', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 5,
        minValue: 0,
        maxValue: 10,
        stepValue: 1,
        enabled: false,
      );
      addTearDown(harness.dispose);

      expect(_field(tester).enabled, isFalse);
      expect(_decrementButton(tester).onPressed, isNull);
      expect(_incrementButton(tester).onPressed, isNull);
    });

    testWidgets('uses localized button tooltips', (tester) async {
      final harness = await _pumpStepper(
        tester,
        value: 5,
        minValue: 0,
        maxValue: 10,
        stepValue: 1,
      );
      addTearDown(harness.dispose);

      expect(find.byTooltip('Decrease'), findsOneWidget);
      expect(find.byTooltip('Increase'), findsOneWidget);
    });
  });
}

class _StepperHarness {
  _StepperHarness(this.value, this.changes);

  final ValueNotifier<num> value;
  final List<num> changes;

  void dispose() => value.dispose();
}

Future<_StepperHarness> _pumpStepper(
  WidgetTester tester, {
  required num value,
  required num minValue,
  required num maxValue,
  required num stepValue,
  bool loopOver = false,
  bool enabled = true,
}) async {
  final currentValue = ValueNotifier<num>(value);
  final changes = <num>[];

  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: ValueListenableBuilder<num>(
              valueListenable: currentValue,
              builder: (context, current, child) {
                return PaperbackStepper(
                  value: current,
                  minValue: minValue,
                  maxValue: maxValue,
                  stepValue: stepValue,
                  loopOver: loopOver,
                  enabled: enabled,
                  onChanged: (next) {
                    changes.add(next);
                    currentValue.value = next;
                  },
                );
              },
            ),
          ),
        ),
      ),
    ),
  );

  return _StepperHarness(currentValue, changes);
}

TextField _field(WidgetTester tester) {
  return tester.widget<TextField>(find.byKey(PaperbackStepper.textFieldKey));
}

IconButton _decrementButton(WidgetTester tester) {
  return tester.widget<IconButton>(
    find.byKey(PaperbackStepper.decrementButtonKey),
  );
}

IconButton _incrementButton(WidgetTester tester) {
  return tester.widget<IconButton>(
    find.byKey(PaperbackStepper.incrementButtonKey),
  );
}

Future<void> _tapDecrement(WidgetTester tester) async {
  await tester.tap(find.byKey(PaperbackStepper.decrementButtonKey));
  await tester.pump();
}

Future<void> _tapIncrement(WidgetTester tester) async {
  await tester.tap(find.byKey(PaperbackStepper.incrementButtonKey));
  await tester.pump();
}
