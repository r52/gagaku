// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSourceCategory _$WebSourceCategoryFromJson(Map<String, dynamic> json) =>
    WebSourceCategory(
      json['id'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$WebSourceCategoryToJson(WebSourceCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$WebSourceConfigImpl _$$WebSourceConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSourceConfigImpl(
      sourceDirectory: json['sourceDirectory'] as String? ?? '',
      repoList: (json['repoList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map(
                  (e) => WebSourceCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [_defaultCategory],
      defaultCategory: json['defaultCategory'] as String? ?? _defaultUUID,
    );

Map<String, dynamic> _$$WebSourceConfigImplToJson(
        _$WebSourceConfigImpl instance) =>
    <String, dynamic>{
      'sourceDirectory': instance.sourceDirectory,
      'repoList': instance.repoList,
      'categories': instance.categories,
      'defaultCategory': instance.defaultCategory,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(WebConfig)
const webConfigProvider = WebConfigProvider._();

final class WebConfigProvider
    extends $NotifierProvider<WebConfig, WebSourceConfig> {
  const WebConfigProvider._(
      {super.runNotifierBuildOverride, WebConfig Function()? create})
      : _createCb = create,
        super(
          from: null,
          argument: null,
          retry: null,
          name: r'webConfigProvider',
          isAutoDispose: false,
          dependencies: null,
          allTransitiveDependencies: null,
        );

  final WebConfig Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$webConfigHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSourceConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<WebSourceConfig>(value),
    );
  }

  @$internal
  @override
  WebConfig create() => _createCb?.call() ?? WebConfig();

  @$internal
  @override
  WebConfigProvider $copyWithCreate(
    WebConfig Function() create,
  ) {
    return WebConfigProvider._(create: create);
  }

  @$internal
  @override
  WebConfigProvider $copyWithBuild(
    WebSourceConfig Function(
      Ref,
      WebConfig,
    ) build,
  ) {
    return WebConfigProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$WebConfigElement $createElement($ProviderPointer pointer) =>
      _$WebConfigElement(this, pointer);

  ProviderListenable<WebConfig$SaveWith> get saveWith =>
      $LazyProxyListenable<WebConfig$SaveWith, WebSourceConfig>(
        this,
        (element) {
          element as _$WebConfigElement;

          return element._$saveWith;
        },
      );

  ProviderListenable<WebConfig$Save> get save =>
      $LazyProxyListenable<WebConfig$Save, WebSourceConfig>(
        this,
        (element) {
          element as _$WebConfigElement;

          return element._$save;
        },
      );
}

String _$webConfigHash() => r'9c89c96ea97f5fcc1c05b478cd9e20d0188c808b';

abstract class _$WebConfig extends $Notifier<WebSourceConfig> {
  WebSourceConfig build();
  @$internal
  @override
  WebSourceConfig runBuild() => build();
}

class _$WebConfigElement
    extends $NotifierProviderElement<WebConfig, WebSourceConfig> {
  _$WebConfigElement(super.provider, super.pointer) {
    _$saveWith.result = $Result.data(_$WebConfig$SaveWith(this));
    _$save.result = $Result.data(_$WebConfig$Save(this));
  }
  final _$saveWith = $ElementLense<_$WebConfig$SaveWith>();
  final _$save = $ElementLense<_$WebConfig$Save>();
  @override
  void mount() {
    super.mount();
    _$saveWith.result!.stateOrNull!.reset();
    _$save.result!.stateOrNull!.reset();
  }

  @override
  void visitChildren({
    required void Function(ProviderElement element) elementVisitor,
    required void Function($ElementLense element) listenableVisitor,
  }) {
    super.visitChildren(
      elementVisitor: elementVisitor,
      listenableVisitor: listenableVisitor,
    );

    listenableVisitor(_$saveWith);
    listenableVisitor(_$save);
  }
}

sealed class WebConfig$SaveWith extends MutationBase<WebSourceConfig> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebConfig.saveWith] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<WebSourceConfig> call(
      {String? sourceDirectory,
      List<String>? repoList,
      List<WebSourceCategory>? categories,
      String? defaultCategory});
}

final class _$WebConfig$SaveWith
    extends $SyncMutationBase<WebSourceConfig, _$WebConfig$SaveWith, WebConfig>
    implements WebConfig$SaveWith {
  _$WebConfig$SaveWith(this.element, {super.state, super.key});

  @override
  final _$WebConfigElement element;

  @override
  $ElementLense<_$WebConfig$SaveWith> get listenable => element._$saveWith;

  @override
  Future<WebSourceConfig> call(
      {String? sourceDirectory,
      List<String>? repoList,
      List<WebSourceCategory>? categories,
      String? defaultCategory}) {
    return mutateAsync(
      Invocation.method(#saveWith, [], {
        #sourceDirectory: sourceDirectory,
        #repoList: repoList,
        #categories: categories,
        #defaultCategory: defaultCategory
      }),
      ($notifier) => $notifier.saveWith(
        sourceDirectory: sourceDirectory,
        repoList: repoList,
        categories: categories,
        defaultCategory: defaultCategory,
      ),
    );
  }

  @override
  _$WebConfig$SaveWith copyWith(MutationState<WebSourceConfig> state,
          {Object? key}) =>
      _$WebConfig$SaveWith(element, state: state, key: key);
}

sealed class WebConfig$Save extends MutationBase<WebSourceConfig> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutationState], then
  /// will call [WebConfig.save] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutationState] or [ErrorMutationState] based on if the method
  /// threw or not.
  ///
  /// Lastly, if the method completes without throwing, the Notifier's state
  /// will be updated with the new value.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  Future<WebSourceConfig> call(WebSourceConfig update);
}

final class _$WebConfig$Save
    extends $SyncMutationBase<WebSourceConfig, _$WebConfig$Save, WebConfig>
    implements WebConfig$Save {
  _$WebConfig$Save(this.element, {super.state, super.key});

  @override
  final _$WebConfigElement element;

  @override
  $ElementLense<_$WebConfig$Save> get listenable => element._$save;

  @override
  Future<WebSourceConfig> call(WebSourceConfig update) {
    return mutateAsync(
      Invocation.method(
        #save,
        [update],
      ),
      ($notifier) => $notifier.save(
        update,
      ),
    );
  }

  @override
  _$WebConfig$Save copyWith(MutationState<WebSourceConfig> state,
          {Object? key}) =>
      _$WebConfig$Save(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
