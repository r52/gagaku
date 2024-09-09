import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/dart_eval_extensions.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:gagaku/web/eval/html.dart';
import 'package:gagaku/web/eval/http.dart';
import 'package:gagaku/web/eval/types.dart';
import 'package:gagaku/web/eval/util.dart';
import 'package:intl/intl.dart';

class WebSourcePlugin implements EvalPlugin {
  @override
  String get identifier => GagakuWebSources.getPackagePath;

  @override
  void configureForCompile(BridgeDeclarationRegistry registry) {
    $WebChapter.configureForCompile(registry);
    $WebManga.configureForCompile(registry);
    $HistoryLink.configureForCompile(registry);
    $WebSourceInfo.configureForCompile(registry);
    // html
    $Document.configureForCompile(registry);
    $Element.configureForCompile(registry);
    // http
    $Client.configureForCompile(registry);
    $BaseRequest.configureForCompile(registry);
    $Request.configureForCompile(registry);
    $BaseResponse.configureForCompile(registry);
    $Response.configureForCompile(registry);
    $StreamedResponse.configureForCompile(registry);

    // loose
    registry.defineBridgeTopLevelFunction(
      BridgeFunctionDeclaration(
        GagakuWebSources.getTypesLibPath,
        'parseDate',
        BridgeFunctionDef(
          returns: CoreTypes.dateTime.ref.annotate,
          params: [
            'format'.param(CoreTypes.string.ref.annotate),
            'content'.param(CoreTypes.string.ref.annotate),
          ],
        ),
      ),
    );
  }

  @override
  void configureForRuntime(Runtime runtime) {
    $WebChapter.configureForRuntime(runtime);
    $WebManga.configureForRuntime(runtime);
    $HistoryLink.configureForRuntime(runtime);
    $WebSourceInfo.configureForRuntime(runtime);
    //html
    $Document.configureForRuntime(runtime);
    $Element.configureForRuntime(runtime);
    // http
    $Client.configureForRuntime(runtime);
    $BaseRequest.configureForRuntime(runtime);
    $Request.configureForRuntime(runtime);
    $BaseResponse.configureForRuntime(runtime);
    $Response.configureForRuntime(runtime);
    $StreamedResponse.configureForRuntime(runtime);

    // loose
    runtime.registerBridgeFunc(GagakuWebSources.getTypesLibPath, 'parseDate', const _$parseDate().call);
  }
}

class _$parseDate implements EvalCallable {
  const _$parseDate();

  @override
  $Value? call(Runtime runtime, $Value? target, List<$Value?> args) {
    String format = args[0]?.$value as String;
    String content = args[1]?.$value as String;

    final tf = DateFormat(format);
    final dt = tf.parse(content);

    return $DateTime.wrap(dt);
  }
}
