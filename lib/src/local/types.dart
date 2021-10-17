import 'package:uuid/uuid.dart';

class LocalManga {
  final String id;
  final String name;
  final String path;

  List<String> readChapters;

  LocalManga({
    String? id,
    required this.name,
    required this.path,
    List<String>? readChapters,
  })  : id = id ?? Uuid().v1(),
        readChapters = readChapters ?? [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'read': readChapters.toString(),
    };
  }

  @override
  String toString() {
    return 'LocalManga{id: $id, name: $name, path: $path, read: ${readChapters.toString()}}';
  }
}
