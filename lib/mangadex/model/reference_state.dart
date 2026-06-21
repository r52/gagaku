part of 'model.dart';

@riverpod
class TagList extends _$TagList with AutoDisposeExpiryMix {
  ///Fetch the global tag list
  @override
  Future<Iterable<Tag>> build() async {
    final api = ref.watch(mangadexProvider);

    final list = await api.getTagList();

    disposeAfter(const Duration(minutes: 60));

    return list.data.cast<Tag>();
  }
}
