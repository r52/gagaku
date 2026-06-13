import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

typedef PassiveTapCallback = void Function(Offset localPosition);

/// Observes single taps without adding a recognizer to the gesture arena.
class PassiveTapListener extends StatefulWidget {
  const PassiveTapListener({
    super.key,
    required this.onTap,
    required this.child,
  });

  final PassiveTapCallback onTap;
  final Widget child;

  @override
  State<PassiveTapListener> createState() => _PassiveTapListenerState();
}

class _PassiveTapListenerState extends State<PassiveTapListener> {
  final Set<int> _activePointers = {};

  _TapCandidate? _candidate;
  _PendingTap? _pendingTap;
  bool _blockedUntilAllPointersUp = false;

  @override
  void dispose() {
    _pendingTap?.timer.cancel();
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    _activePointers.add(event.pointer);

    if (_activePointers.length > 1) {
      _cancelCandidate();
      _blockedUntilAllPointersUp = true;
      return;
    }

    if (_blockedUntilAllPointersUp) return;

    var suppressTap = false;
    final pendingTap = _pendingTap;
    if (pendingTap != null) {
      if (_isSecondTap(event, pendingTap)) {
        pendingTap.timer.cancel();
        _pendingTap = null;
        suppressTap = true;
      } else {
        _dispatchPendingTap();
      }
    }

    _candidate = _TapCandidate(
      pointer: event.pointer,
      buttons: event.buttons,
      globalPosition: event.position,
      hitSlop: computeHitSlop(
        event.kind,
        MediaQuery.maybeGestureSettingsOf(context),
      ),
      suppressTap: suppressTap,
    );
  }

  void _handlePointerMove(PointerMoveEvent event) {
    final candidate = _candidate;
    if (candidate == null || candidate.pointer != event.pointer) return;

    if ((event.position - candidate.globalPosition).distance >
        candidate.hitSlop) {
      _cancelCandidate();
      _blockedUntilAllPointersUp = true;
    }
  }

  void _handlePointerUp(PointerUpEvent event) {
    final candidate = _candidate;
    final isTap =
        candidate != null &&
        candidate.pointer == event.pointer &&
        _activePointers.length == 1 &&
        (event.position - candidate.globalPosition).distance <=
            candidate.hitSlop;

    _activePointers.remove(event.pointer);
    _candidate = null;

    if (_activePointers.isEmpty) {
      _blockedUntilAllPointersUp = false;
    }

    if (!isTap || candidate.suppressTap) return;

    _pendingTap = _PendingTap(
      buttons: candidate.buttons,
      globalPosition: candidate.globalPosition,
      localPosition: event.localPosition,
      timer: Timer(kDoubleTapTimeout, _dispatchPendingTap),
    );
  }

  void _handlePointerCancel(PointerCancelEvent event) {
    _activePointers.remove(event.pointer);
    if (_candidate?.pointer == event.pointer) {
      _cancelCandidate();
    }

    if (_activePointers.isEmpty) {
      _blockedUntilAllPointersUp = false;
    }
  }

  bool _isSecondTap(PointerDownEvent event, _PendingTap pendingTap) {
    return event.buttons == pendingTap.buttons &&
        (event.position - pendingTap.globalPosition).distance <= kDoubleTapSlop;
  }

  void _cancelCandidate() {
    _candidate = null;
  }

  void _dispatchPendingTap() {
    final pendingTap = _pendingTap;
    if (pendingTap == null) return;

    pendingTap.timer.cancel();
    _pendingTap = null;

    if (mounted) {
      widget.onTap(pendingTap.localPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove,
      onPointerUp: _handlePointerUp,
      onPointerCancel: _handlePointerCancel,
      child: widget.child,
    );
  }
}

class _TapCandidate {
  const _TapCandidate({
    required this.pointer,
    required this.buttons,
    required this.globalPosition,
    required this.hitSlop,
    required this.suppressTap,
  });

  final int pointer;
  final int buttons;
  final Offset globalPosition;
  final double hitSlop;
  final bool suppressTap;
}

class _PendingTap {
  const _PendingTap({
    required this.buttons,
    required this.globalPosition,
    required this.localPosition,
    required this.timer,
  });

  final int buttons;
  final Offset globalPosition;
  final Offset localPosition;
  final Timer timer;
}
