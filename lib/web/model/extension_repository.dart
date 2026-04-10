import 'package:gagaku/objectbox.g.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/model/model.dart';
import 'package:gagaku/util/exception.dart';
import 'package:gagaku/web/model/types.dart';
import 'package:http/http.dart' as http;

class ExtensionRepository {
  Future<(WebSourceInfo, String)> fetchSourceAndBody(String sourceId) async {
    WebSourceInfo? source;
    try {
      final box = GagakuData().store.box<WebSourceInfo>();
      final query = box.query(WebSourceInfo_.id.equals(sourceId)).build();
      source = await query.findUniqueAsync();
      if (source == null) {
        throw UnknownSourceException(
          message: "Source failed to initialize: not installed",
          sourceId: sourceId,
        );
      }

      final sourceFile = switch (source.version) {
        SupportedVersion.v0_9 => 'index.js',
      };

      final scriptUrl = '${source.repo}/${source.id}/$sourceFile';
      final response = await http.get(Uri.parse(scriptUrl));

      if (response.statusCode != 200) {
        final err = "Failed to load $scriptUrl";
        logger.e(err);
        throw ApiException(
          message: err,
          statusCode: response.statusCode,
          statusMessage: response.reasonPhrase,
        );
      }

      return (source, response.body);
    } catch (e) {
      logger.e('Error retrieving source info from database', error: e);
      rethrow;
    }
  }
}
