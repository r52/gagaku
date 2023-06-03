import 'package:hooks_riverpod/hooks_riverpod.dart';

enum HomePage { mangadex, local, web }

final homepageProvider = StateProvider((ref) => HomePage.mangadex);

const gagakuBox = 'gagaku_box';
