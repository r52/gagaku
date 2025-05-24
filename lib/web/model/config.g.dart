// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSourceCategory _$WebSourceCategoryFromJson(Map<String, dynamic> json) =>
    WebSourceCategory(json['id'] as String, json['name'] as String);

Map<String, dynamic> _$WebSourceCategoryToJson(WebSourceCategory instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_WebSourceConfig _$WebSourceConfigFromJson(Map<String, dynamic> json) =>
    _WebSourceConfig(
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
              ?.map(
                (e) => WebSourceCategory.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [_defaultCategory],
      defaultCategory: json['defaultCategory'] as String? ?? _defaultUUID,
      categoriesToUpdate:
          (json['categoriesToUpdate'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WebSourceConfigToJson(
  _WebSourceConfig instance,
) => <String, dynamic>{
  'installedSources': instance.installedSources.map((e) => e.toJson()).toList(),
  'repoList': instance.repoList.map(const RepoConverter().toJson).toList(),
  'categories': instance.categories.map((e) => e.toJson()).toList(),
  'defaultCategory': instance.defaultCategory,
  'categoriesToUpdate': instance.categoriesToUpdate,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(WebConfig)
const webConfigProvider = WebConfigProvider._();

final class WebConfigProvider
    extends $NotifierProvider<WebConfig, WebSourceConfig> {
  const WebConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'webConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$webConfigHash();

  @$internal
  @override
  WebConfig create() => WebConfig();

  @$internal
  @override
  _$WebConfigElement $createElement($ProviderPointer pointer) =>
      _$WebConfigElement(pointer);

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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSourceConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<WebSourceConfig>(value),
    );
  }
}

String _$webConfigHash() => r'02fd3ba9bd9a4f62fac7c2c4bf1ebbdd044f85d1';

abstract class _$WebConfig extends $Notifier<WebSourceConfig> {
  WebSourceConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WebSourceConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WebSourceConfig>,
              WebSourceConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$WebConfigElement
    extends $NotifierProviderElement<WebConfig, WebSourceConfig> {
  _$WebConfigElement(super.pointer) {
    _$saveWith.result = $Result.data(_$WebConfig$SaveWith(this));
    _$save.result = $Result.data(_$WebConfig$Save(this));
  }
  final _$saveWith = $ElementLense<_$WebConfig$SaveWith>();
  final _$save = $ElementLense<_$WebConfig$Save>();
  @override
  void mount() {
    super.mount();
    _$saveWith.result!.value!.reset();
    _$save.result!.value!.reset();
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
  /// This will first set the state to [PendingMutation], then
  /// will call [WebConfig.saveWith] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  WebSourceConfig call({
    List<WebSourceInfo>? installedSources,
    List<RepoInfo>? repoList,
    List<WebSourceCategory>? categories,
    String? defaultCategory,
    List<String>? categoriesToUpdate,
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
  WebSourceConfig call({
    List<WebSourceInfo>? installedSources,
    List<RepoInfo>? repoList,
    List<WebSourceCategory>? categories,
    String? defaultCategory,
    List<String>? categoriesToUpdate,
  }) {
    return mutate(
      Invocation.method(#saveWith, [], {
        #installedSources: installedSources,
        #repoList: repoList,
        #categories: categories,
        #defaultCategory: defaultCategory,
        #categoriesToUpdate: categoriesToUpdate,
      }),
      ($notifier) => $notifier.saveWith(
        installedSources: installedSources,
        repoList: repoList,
        categories: categories,
        defaultCategory: defaultCategory,
        categoriesToUpdate: categoriesToUpdate,
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
  /// This will first set the state to [PendingMutation], then
  /// will call [WebConfig.save] with the provided parameters.
  ///
  /// After the method completes, the mutation state will be updated to either
  /// [SuccessMutation] or [ErrorMutation] based on if the method
  /// threw or not.
  ///
  /// **Note**:
  /// If the notifier threw in its constructor, the mutation won't start
  /// and [call] will throw.
  /// This should generally never happen though, as Notifiers are not supposed
  /// to have logic in their constructors.
  WebSourceConfig call(WebSourceConfig update);
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
  WebSourceConfig call(WebSourceConfig update) {
    return mutate(
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
  const ExtensionStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionStateHash();

  @$internal
  @override
  ExtensionState create() => ExtensionState();

  @$internal
  @override
  $NotifierProviderElement<ExtensionState, ExtensionStateMap> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExtensionStateMap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ExtensionStateMap>(value),
    );
  }
}

String _$extensionStateHash() => r'b620290f433db98f26710a9cba9df36030f4bb41';

abstract class _$ExtensionState extends $Notifier<ExtensionStateMap> {
  ExtensionStateMap build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionStateMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateMap>,
              ExtensionStateMap,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ExtensionSecureState)
const extensionSecureStateProvider = ExtensionSecureStateProvider._();

final class ExtensionSecureStateProvider
    extends $NotifierProvider<ExtensionSecureState, ExtensionStateMap> {
  const ExtensionSecureStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'extensionSecureStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$extensionSecureStateHash();

  @$internal
  @override
  ExtensionSecureState create() => ExtensionSecureState();

  @$internal
  @override
  $NotifierProviderElement<ExtensionSecureState, ExtensionStateMap>
  $createElement($ProviderPointer pointer) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExtensionStateMap value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<ExtensionStateMap>(value),
    );
  }
}

String _$extensionSecureStateHash() =>
    r'e4764f32de7f49e37b4fc5bcd0abfaecc7fc0506';

abstract class _$ExtensionSecureState extends $Notifier<ExtensionStateMap> {
  ExtensionStateMap build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExtensionStateMap>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExtensionStateMap>,
              ExtensionStateMap,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
