// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSourceCategory _$WebSourceCategoryFromJson(Map<String, dynamic> json) =>
    WebSourceCategory(json['id'] as String, json['name'] as String);

Map<String, dynamic> _$WebSourceCategoryToJson(WebSourceCategory instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$WebSourceConfigImpl _$$WebSourceConfigImplFromJson(
  Map<String, dynamic> json,
) => _$WebSourceConfigImpl(
  installedSources:
      (json['installedSources'] as List<dynamic>?)
          ?.map((e) => WebSourceInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  repoList:
      (json['repoList'] as List<dynamic>?)
          ?.map(const RepoConverter().fromJson)
          .toList() ??
      const [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => WebSourceCategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [_defaultCategory],
  defaultCategory: json['defaultCategory'] as String? ?? _defaultUUID,
);

Map<String, dynamic> _$$WebSourceConfigImplToJson(
  _$WebSourceConfigImpl instance,
) => <String, dynamic>{
  'installedSources': instance.installedSources,
  'repoList': instance.repoList.map(const RepoConverter().toJson).toList(),
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
  const WebConfigProvider._({
    super.runNotifierBuildOverride,
    WebConfig Function()? create,
  }) : _createCb = create,
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
  WebConfigProvider $copyWithCreate(WebConfig Function() create) {
    return WebConfigProvider._(create: create);
  }

  @$internal
  @override
  WebConfigProvider $copyWithBuild(
    WebSourceConfig Function(Ref, WebConfig) build,
  ) {
    return WebConfigProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  _$WebConfigElement $createElement($ProviderPointer pointer) =>
      _$WebConfigElement(this, pointer);

  ProviderListenable<WebConfig$SaveWith> get saveWith =>
      $LazyProxyListenable<WebConfig$SaveWith, WebSourceConfig>(this, (
        element,
      ) {
        element as _$WebConfigElement;

        return element._$saveWith;
      });

  ProviderListenable<WebConfig$Save> get save =>
      $LazyProxyListenable<WebConfig$Save, WebSourceConfig>(this, (element) {
        element as _$WebConfigElement;

        return element._$save;
      });
}

String _$webConfigHash() => r'9c221e7c9fbebe89e015b31b28a09408423e2973';

abstract class _$WebConfig extends $Notifier<WebSourceConfig> {
  WebSourceConfig build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WebSourceConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<WebSourceConfig>,
              WebSourceConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
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
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

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
  Future<WebSourceConfig> call({
    List<WebSourceInfo>? installedSources,
    List<RepoInfo>? repoList,
    List<WebSourceCategory>? categories,
    String? defaultCategory,
  });
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
  Future<WebSourceConfig> call({
    List<WebSourceInfo>? installedSources,
    List<RepoInfo>? repoList,
    List<WebSourceCategory>? categories,
    String? defaultCategory,
  }) {
    return mutateAsync(
      Invocation.method(#saveWith, [], {
        #installedSources: installedSources,
        #repoList: repoList,
        #categories: categories,
        #defaultCategory: defaultCategory,
      }),
      ($notifier) => $notifier.saveWith(
        installedSources: installedSources,
        repoList: repoList,
        categories: categories,
        defaultCategory: defaultCategory,
      ),
    );
  }

  @override
  _$WebConfig$SaveWith copyWith(
    MutationState<WebSourceConfig> state, {
    Object? key,
  }) => _$WebConfig$SaveWith(element, state: state, key: key);
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
      Invocation.method(#save, [update]),
      ($notifier) => $notifier.save(update),
    );
  }

  @override
  _$WebConfig$Save copyWith(
    MutationState<WebSourceConfig> state, {
    Object? key,
  }) => _$WebConfig$Save(element, state: state, key: key);
}

@ProviderFor(ExtensionState)
const extensionStateProvider = ExtensionStateProvider._();

final class ExtensionStateProvider
    extends $NotifierProvider<ExtensionState, ExtensionStateMap> {
  const ExtensionStateProvider._({
    super.runNotifierBuildOverride,
    ExtensionState Function()? create,
  }) : _createCb = create,
       super(
         from: null,
         argument: null,
         retry: null,
         name: r'extensionStateProvider',
         isAutoDispose: false,
         dependencies: null,
         allTransitiveDependencies: null,
       );

  final ExtensionState Function()? _createCb;

  @override
  String debugGetCreateSourceHash() => _$extensionStateHash();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExtensionStateMap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ExtensionStateMap>(value),
    );
  }

  @$internal
  @override
  ExtensionState create() => _createCb?.call() ?? ExtensionState();

  @$internal
  @override
  ExtensionStateProvider $copyWithCreate(ExtensionState Function() create) {
    return ExtensionStateProvider._(create: create);
  }

  @$internal
  @override
  ExtensionStateProvider $copyWithBuild(
    ExtensionStateMap Function(Ref, ExtensionState) build,
  ) {
    return ExtensionStateProvider._(runNotifierBuildOverride: build);
  }

  @$internal
  @override
  $NotifierProviderElement<ExtensionState, ExtensionStateMap> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(this, pointer);
}

String _$extensionStateHash() => r'e05c4c05a9878f3b6bdf535268ffe4e9c9393eef';

abstract class _$ExtensionState extends $Notifier<ExtensionStateMap> {
  ExtensionStateMap build();
  @$internal
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionStateMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              NotifierBase<ExtensionStateMap>,
              ExtensionStateMap,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
