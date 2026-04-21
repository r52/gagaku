import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intl.g.dart';

@Riverpod(keepAlive: true)
NumberFormat numberFormatter(Ref ref, String locale) {
  return NumberFormat.compact(locale: locale);
}
