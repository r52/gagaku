class WebManga {
  final String title;
  final String description;
  final String artist;
  final String author;
  final String coverArt;

  final List<WebChapter> chapters;

  WebManga({
    required this.title,
    required this.description,
    required this.artist,
    required this.author,
    required this.coverArt,
    required this.chapters,
  });

  factory WebManga.fromJson(Map<String, dynamic> data) {
    var cover = data['cover'] as String;

    Map<String, dynamic> chapterData = data['chapters'];
    var chapterList = chapterData.entries
        .map((entry) => WebChapter.fromJson(entry.key, entry.value))
        .toList();

    chapterList.sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));

    return WebManga(
        title: data['title'],
        description: data['description'],
        artist: data['artist'],
        author: data['author'],
        coverArt: cover,
        chapters: chapterList);
  }
}

class WebChapter {
  final String chapter;
  final String title;
  final String volume;
  final Map<String, String> groups;
  final DateTime lastUpdated;

  WebChapter({
    required this.chapter,
    required this.title,
    required this.volume,
    required this.groups,
    required this.lastUpdated,
  });

  factory WebChapter.fromJson(String chapter, Map<String, dynamic> data) {
    return WebChapter(
        chapter: chapter,
        title: data['title'],
        volume: data['volume'],
        groups: Map.castFrom<String, dynamic, String, String>(data['groups']),
        lastUpdated: DateTime.fromMillisecondsSinceEpoch(
            int.parse(data['last_updated']) * 1000));
  }
}
