import 'dart:async';

import 'package:flutter/painting.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/web/model/types.dart';

class AppMaintenanceService {
  AppMaintenanceService._internal();

  static final AppMaintenanceService _instance =
      AppMaintenanceService._internal();

  factory AppMaintenanceService() => _instance;

  Timer? _timer;
  bool _running = false;

  void start({Duration interval = const Duration(minutes: 15)}) {
    if (_timer != null) {
      return;
    }

    _timer = Timer.periodic(interval, (_) {
      unawaited(run());
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> run() async {
    if (_running) {
      return;
    }

    _running = true;
    try {
      _clearFullImageCache();
      await _removeStaleHistoryLinks();
    } finally {
      _running = false;
    }
  }

  void _clearFullImageCache() {
    final imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.currentSize >= imageCache.maximumSize) {
      imageCache.clear();
    }
  }

  Future<void> _removeStaleHistoryLinks() async {
    await GagakuData().store.runInTransactionAsync(TxMode.write, (store, _) {
      final box = store.box<HistoryLink>();

      final builder = box.query();
      builder.backlinkMany(WebFavoritesList_.list);
      final inuseLinksQuery = builder.build();
      final inuseLinks = inuseLinksQuery.findIds();
      inuseLinksQuery.close();

      final notInuseQuery = box
          .query(HistoryLink_.dbid.notOneOf(inuseLinks))
          .build();
      notInuseQuery.remove();
      notInuseQuery.close();
    }, null);
  }
}
