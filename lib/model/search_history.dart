import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_history.g.dart';

@Riverpod(keepAlive: true)
class SearchHistory extends _$SearchHistory {
  @override
  List<String> build() => [];

  @override
  set state(List<String> newState) => super.state = newState;
  List<String> update(List<String> Function(List<String> state) cb) =>
      state = cb(state);
}
