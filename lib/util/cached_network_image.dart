import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gagaku/util/http.dart';

final gagakuImageCache = GagakuCacheManager();

class GagakuCacheManager extends CacheManager with ImageCacheManager {
  static const key = 'libCachedImageData';

  static final GagakuCacheManager _instance = GagakuCacheManager._();

  factory GagakuCacheManager() {
    return _instance;
  }

  GagakuCacheManager._()
    : super(
        Config(key, fileService: HttpFileService(httpClient: baseGagakuClient)),
      );
}
