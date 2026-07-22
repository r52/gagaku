import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gagaku/i18n/strings.g.dart';

const _maxDecimalPlaces = 10;

class PaperbackStepper extends StatefulWidget {
  const PaperbackStepper({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.stepValue,
    required this.loopOver,
    required this.onChanged,
    this.enabled = true,
  });

  static const textFieldKey = ValueKey('paperback_stepper_text_field');
  static const decrementButtonKey = ValueKey(
    'paperback_stepper_decrement_button',
  );
  static const incrementButtonKey = ValueKey(
    'paperback_stepper_increment_button',
  );

  final num value;
  final num minValue;
  final num maxValue;
  final num stepValue;
  final bool loopOver;
  final ValueChanged<num> onChanged;
  final bool enabled;

  static bool isValidConfiguration({
    required num value,
    required num minValue,
    required num maxValue,
    required num stepValue,
  }) {
    return value.isFinite &&
        minValue.isFinite &&
        maxValue.isFinite &&
        stepValue.isFinite &&
        minValue <= maxValue &&
        stepValue > 0;
  }

  @override
  State<PaperbackStepper> createState() => _PaperbackStepperState();
}

class _PaperbackStepperState extends State<PaperbackStepper> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late double _acceptedValue;

  bool get _hasValidConfiguration => PaperbackStepper.isValidConfiguration(
    value: widget.value,
    minValue: widget.minValue,
    maxValue: widget.maxValue,
    stepValue: widget.stepValue,
  );

  bool get _isInteractive => widget.enabled && _hasValidConfiguration;

  int get _decimalPlaces => [
    widget.value,
    widget.minValue,
    widget.maxValue,
    widget.stepValue,
  ].map(_decimalPlacesFor).reduce(math.max);

  double get _minValue => _normalize(widget.minValue.toDouble());
  double get _maxValue => _normalize(widget.maxValue.toDouble());

  double get _widgetValue {
    final value = _normalize(widget.value.toDouble());
    return _normalize(value.clamp(_minValue, _maxValue));
  }

  bool get _isSingleValueRange => _sameValue(_minValue, _maxValue);

  bool get _canDecrement {
    if (!_isInteractive || _isSingleValueRange) return false;
    return widget.loopOver || !_sameValue(_acceptedValue, _minValue);
  }

  bool get _canIncrement {
    if (!_isInteractive || _isSingleValueRange) return false;
    return widget.loopOver || !_sameValue(_acceptedValue, _maxValue);
  }

  @override
  void initState() {
    super.initState();
    _acceptedValue = _hasValidConfiguration
        ? _widgetValue
        : widget.value.toDouble();
    _controller = TextEditingController(text: _formattedWidgetValue());
    _focusNode = FocusNode()..addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(covariant PaperbackStepper oldWidget) {
    super.didUpdateWidget(oldWidget);

    final valueChanged = !_sameInputValue(oldWidget.value, widget.value);
    final configurationChanged =
        !_sameInputValue(oldWidget.minValue, widget.minValue) ||
        !_sameInputValue(oldWidget.maxValue, widget.maxValue) ||
        !_sameInputValue(oldWidget.stepValue, widget.stepValue);

    if (valueChanged || configurationChanged) {
      _acceptedValue = _hasValidConfiguration
          ? _widgetValue
          : widget.value.toDouble();
      _replaceText(_formattedWidgetValue());
    }
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChanged)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = context.t;

    return Row(
      children: [
        IconButton(
          key: PaperbackStepper.decrementButtonKey,
          tooltip: tr.ui.decrease,
          onPressed: _canDecrement ? _decrement : null,
          icon: const Icon(Icons.remove),
        ),
        Expanded(
          child: TextField(
            key: PaperbackStepper.textFieldKey,
            controller: _controller,
            focusNode: _focusNode,
            enabled: _isInteractive,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-.]')),
            ],
            onSubmitted: (_) => _commitText(),
            onTapOutside: (_) => _focusNode.unfocus(),
          ),
        ),
        IconButton(
          key: PaperbackStepper.incrementButtonKey,
          tooltip: tr.ui.increase,
          onPressed: _canIncrement ? _increment : null,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  void _handleFocusChanged() {
    if (!_focusNode.hasFocus) _commitText();
  }

  void _decrement() {
    final candidate = _normalize(_acceptedValue - widget.stepValue.toDouble());
    final value = candidate < _minValue
        ? (widget.loopOver ? _maxValue : _minValue)
        : candidate;
    _commitValue(value);
  }

  void _increment() {
    final candidate = _normalize(_acceptedValue + widget.stepValue.toDouble());
    final value = candidate > _maxValue
        ? (widget.loopOver ? _minValue : _maxValue)
        : candidate;
    _commitValue(value);
  }

  void _commitText() {
    if (!_isInteractive) return;

    final parsed = double.tryParse(_controller.text);
    if (parsed == null || !parsed.isFinite) {
      _replaceText(_formattedWidgetValue());
      return;
    }

    _commitValue(parsed.clamp(_minValue, _maxValue).toDouble());
  }

  void _commitValue(double value) {
    final normalized = _normalize(value);
    _replaceText(_format(normalized));
    if (_sameValue(normalized, _acceptedValue)) return;

    setState(() => _acceptedValue = normalized);
    widget.onChanged(normalized);
  }

  String _formattedWidgetValue() {
    if (!_hasValidConfiguration) return widget.value.toString();
    return _format(_acceptedValue);
  }

  String _format(double value) {
    var text = _normalize(value).toStringAsFixed(_decimalPlaces);
    if (text.contains('.')) {
      text = text.replaceFirst(RegExp(r'0+$'), '');
      text = text.replaceFirst(RegExp(r'\.$'), '');
    }
    return text == '-0' ? '0' : text;
  }

  double _normalize(double value) {
    final factor = math.pow(10, _decimalPlaces).toDouble();
    final scaled = value * factor;
    if (!scaled.isFinite) return value;
    final normalized = scaled.roundToDouble() / factor;
    return normalized == 0 ? 0 : normalized;
  }

  bool _sameValue(double first, double second) {
    return _normalize(first) == _normalize(second);
  }

  void _replaceText(String text) {
    if (_controller.text == text) return;
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

int _decimalPlacesFor(num value) {
  if (!value.isFinite) return 0;

  final parts = value.abs().toString().toLowerCase().split('e');
  final mantissa = parts.first;
  final exponent = parts.length == 2 ? int.tryParse(parts.last) ?? 0 : 0;
  final decimalPoint = mantissa.indexOf('.');
  final fractionLength = decimalPoint < 0
      ? 0
      : mantissa.length - decimalPoint - 1;
  return (fractionLength - exponent).clamp(0, _maxDecimalPlaces);
}

bool _sameInputValue(num first, num second) {
  if (first.isNaN && second.isNaN) return true;
  return first.toDouble() == second.toDouble();
}
