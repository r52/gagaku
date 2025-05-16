// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MangaDexConfig _$MangaDexConfigFromJson(Map<String, dynamic> json) =>
    _MangaDexConfig(
      translatedLanguages:
          (json['translatedLanguages'] as List<dynamic>?)
              ?.map(const LanguageConverter().fromJson)
              .toSet() ??
          const {},
      originalLanguage:
          (json['originalLanguage'] as List<dynamic>?)
              ?.map(const LanguageConverter().fromJson)
              .toSet() ??
          const {},
      contentRating:
          (json['contentRating'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$ContentRatingEnumMap, e))
              .toSet() ??
          const {
            ContentRating.safe,
            ContentRating.suggestive,
            ContentRating.erotica,
          },
      dataSaver: json['dataSaver'] as bool? ?? false,
      groupBlacklist:
          (json['groupBlacklist'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toSet() ??
          const {},
    );

Map<String, dynamic> _$MangaDexConfigToJson(
  _MangaDexConfig instance,
) => <String, dynamic>{
  'translatedLanguages':
      instance.translatedLanguages
          .map(const LanguageConverter().toJson)
          .toList(),
  'originalLanguage':
      instance.originalLanguage.map(const LanguageConverter().toJson).toList(),
  'contentRating':
      instance.contentRating.map((e) => _$ContentRatingEnumMap[e]!).toList(),
  'dataSaver': instance.dataSaver,
  'groupBlacklist': instance.groupBlacklist.toList(),
};

const _$ContentRatingEnumMap = {
  ContentRating.safe: 'safe',
  ContentRating.suggestive: 'suggestive',
  ContentRating.erotica: 'erotica',
  ContentRating.pornographic: 'pornographic',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(MdConfig)
const mdConfigProvider = MdConfigProvider._();

final class MdConfigProvider
    extends $NotifierProvider<MdConfig, MangaDexConfig> {
  const MdConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mdConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mdConfigHash();

  @$internal
  @override
  MdConfig create() => MdConfig();

  @$internal
  @override
  _$MdConfigElement $createElement($ProviderPointer pointer) =>
      _$MdConfigElement(pointer);

  ProviderListenable<MdConfig$Save> get save =>
      $LazyProxyListenable<MdConfig$Save, MangaDexConfig>(this, (element) {
        element as _$MdConfigElement;

        return element._$save;
      });

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MangaDexConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<MangaDexConfig>(value),
    );
  }
}

String _$mdConfigHash() => r'cba5feaa15f6f2f28659d9cd6523496419670a30';

abstract class _$MdConfig extends $Notifier<MangaDexConfig> {
  MangaDexConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MangaDexConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MangaDexConfig>,
              MangaDexConfig,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

class _$MdConfigElement
    extends $NotifierProviderElement<MdConfig, MangaDexConfig> {
  _$MdConfigElement(super.pointer) {
    _$save.result = $Result.data(_$MdConfig$Save(this));
  }
  final _$save = $ElementLense<_$MdConfig$Save>();
  @override
  void mount() {
    super.mount();
    _$save.result!.value!.reset();
  }

  @override
  void visitListenables(
    void Function($ElementLense element) listenableVisitor,
  ) {
    super.visitListenables(listenableVisitor);

    listenableVisitor(_$save);
  }
}

sealed class MdConfig$Save extends MutationBase<MangaDexConfig> {
  /// Starts the mutation.
  ///
  /// This will first set the state to [PendingMutation], then
  /// will call [MdConfig.save] with the provided parameters.
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
  MangaDexConfig call(MangaDexConfig update);
}

final class _$MdConfig$Save
    extends $SyncMutationBase<MangaDexConfig, _$MdConfig$Save, MdConfig>
    implements MdConfig$Save {
  _$MdConfig$Save(this.element, {super.state, super.key});

  @override
  final _$MdConfigElement element;

  @override
  $ElementLense<_$MdConfig$Save> get listenable => element._$save;

  @override
  MangaDexConfig call(MangaDexConfig update) {
    return mutate(
      Invocation.method(#save, [update]),
      ($notifier) => $notifier.save(update),
    );
  }

  @override
  _$MdConfig$Save copyWith(
    MutationState<MangaDexConfig> state, {
    Object? key,
  }) => _$MdConfig$Save(element, state: state, key: key);
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
