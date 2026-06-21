part of 'model.dart';

@Entity()
class MangaDexHistoryDB {
  @Id()
  int dbid;

  List<String> queue;

  MangaDexHistoryDB({this.dbid = 0, this.queue = const []});
}

@Riverpod(keepAlive: true)
class MangaDexHistory extends _$MangaDexHistory {
  static const _numItems = 50;

  @override
  Future<Queue<Chapter>> build() async {
    final box = GagakuData().store.box<MangaDexHistoryDB>();
    final query = box.query().build();

    MangaDexHistoryDB? db;
    db = query.findUnique();
    query.close();

    if (db == null) {
      db = MangaDexHistoryDB();
      box.put(db);
    }

    if (db.queue.isEmpty) {
      return Queue<Chapter>();
    }

    final api = ref.watch(mangadexProvider);
    final uuids = db.queue.toList();

    final chapters = await api.fetchChapters(uuids);

    ref.run((tsx) async {
      return await tsx.get(chapterStatsProvider.notifier).get(chapters);
    });

    return Queue.of(chapters);
  }

  Future<Chapter> add(Chapter chapter) async {
    final oldstate = await future;
    final cpy = Queue.of(oldstate);

    while (cpy.contains(chapter)) {
      cpy.remove(chapter);
    }

    cpy.addFirst(chapter);

    while (cpy.length > _numItems) {
      cpy.removeLast();
    }

    final uuids = cpy.map((e) => e.id).toList();

    final box = GagakuData().store.box<MangaDexHistoryDB>();
    final query = box.query().build();
    final db = query.findUnique()!;
    query.close();

    db.queue = uuids;

    box.put(db);

    state = AsyncData(cpy);

    return chapter;
  }
}
