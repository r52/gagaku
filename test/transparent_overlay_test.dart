import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/util/ui.dart';

void main() {
  testWidgets('keeps the previous route painted after its transition', (
    tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();
    var paintCount = 0;

    await tester.pumpWidget(
      MaterialApp(navigatorKey: navigatorKey, home: const SizedBox.expand()),
    );

    navigatorKey.currentState!.push<void>(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) => _PaintProbe(
          onPaint: () => paintCount++,
          child: const ColoredBox(color: Colors.red, child: SizedBox.expand()),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: Tween<double>(
                begin: 1,
                end: 0,
              ).animate(secondaryAnimation),
              child: child,
            ),
      ),
    );
    await tester.pumpAndSettle();

    final route = TransparentOverlay<void>(
      builder: (context) => const SizedBox.expand(),
    );
    navigatorKey.currentState!.push<void>(route);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));

    expect(route.opaque, isFalse);
    expect(route.overlayEntries.every((entry) => !entry.opaque), isTrue);

    paintCount = 0;
    tester
        .renderObject<_RenderPaintProbe>(find.byType(_PaintProbe))
        .markNeedsPaint();
    await tester.pump();
    expect(paintCount, greaterThan(0));

    navigatorKey.currentState!.pop();
    await tester.pumpAndSettle();
  });
}

class _PaintProbe extends SingleChildRenderObjectWidget {
  const _PaintProbe({required this.onPaint, required super.child});

  final VoidCallback onPaint;

  @override
  _RenderPaintProbe createRenderObject(BuildContext context) {
    return _RenderPaintProbe(onPaint);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderPaintProbe renderObject,
  ) {
    renderObject.onPaint = onPaint;
  }
}

class _RenderPaintProbe extends RenderProxyBox {
  _RenderPaintProbe(this.onPaint);

  VoidCallback onPaint;

  @override
  void paint(PaintingContext context, Offset offset) {
    onPaint();
    super.paint(context, offset);
  }
}
