import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gagaku/web/model/types.dart' show RepoInfo, WebSourceInfo;
import 'package:uuid/uuid.dart';

part 'types.g.dart';
part 'types.freezed.dart';

const _defaultUUID = 'e9d5c6c4-a29c-4a74-aaf2-8f2f8d2c06c2';
const _defaultCategory = WebSourceCategory(_defaultUUID, 'Default');

@JsonSerializable()
class WebSourceCategory {
  const WebSourceCategory(this.id, this.name);
  WebSourceCategory.name(this.name) : id = const Uuid().v4();

  final String id;
  final String name;

  factory WebSourceCategory.fromJson(Map<String, dynamic> json) =>
      _$WebSourceCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$WebSourceCategoryToJson(this);
}

class RepoConverter implements JsonConverter<RepoInfo, dynamic> {
  const RepoConverter();

  @override
  RepoInfo fromJson(dynamic item) {
    if (item is String) {
      return RepoInfo(name: item, url: item);
    }

    return RepoInfo.fromJson(item);
  }

  @override
  dynamic toJson(RepoInfo item) => item.toJson();
}

@freezed
abstract class WebSourceConfig with _$WebSourceConfig {
  factory WebSourceConfig({
    @Default([]) List<WebSourceInfo> installedSources,
    @RepoConverter() @Default([]) List<RepoInfo> repoList,
    @Default([_defaultCategory]) List<WebSourceCategory> categories,
    @Default(_defaultUUID) String defaultCategory,
    @Default([]) List<String> categoriesToUpdate,
  }) = _WebSourceConfig;

  factory WebSourceConfig.fromJson(Map<String, dynamic> json) =>
      _$WebSourceConfigFromJson(json);
}
