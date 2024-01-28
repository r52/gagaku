import 'package:animations/animations.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gagaku/log.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:gagaku/util.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'manga_view.g.dart';

enum _ViewType { chapters, art, related }

Page<dynamic> buildMangaViewPage(BuildContext context, GoRouterState state) {
  final manga = state.extra.asOrNull<Manga>();

  Widget child;

  if (manga != null) {
    child = MangaDexMangaViewWidget(
      manga: manga,
    );
  } else {
    child = QueriedMangaDexMangaViewWidget(
        mangaId: state.pathParameters['mangaId']!);
  }

  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: Styles.scaledSharedAxisTransitionBuilder,
  );
}

@riverpod
Future<Manga> _fetchMangaFromId(
    _FetchMangaFromIdRef ref, String mangaId) async {
  final api = ref.watch(mangadexProvider);
  final manga =
      await api.fetchManga(ids: [mangaId], limit: MangaDexEndpoints.breakLimit);
  return manga.first;
}

@riverpod
Future<void> _fetchReadChaptersRedun(
    _FetchReadChaptersRedunRef ref, Manga manga) async {
  final loggedin = await ref.watch(authControlProvider.future);

  if (loggedin) {
    // Redundant retrieve read chapters when opening the manga
    // from places where it hasn't been retrieved yet
    await ref.watch(readChaptersProvider.notifier).get([manga]);

    await ref.watch(ratingsProvider.notifier).get([manga]);
  }

  await ref.watch(statisticsProvider.notifier).get([manga]);
}

@riverpod
Future<Iterable<Manga>> _fetchRelatedManga(
    _FetchRelatedMangaRef ref, Manga manga) async {
  final related = manga.relatedMangas;

  if (related.isEmpty) {
    return [];
  }

  final api = ref.watch(mangadexProvider);
  final ids = related.map((e) => e.id);
  final mangas =
      await api.fetchManga(ids: ids, limit: MangaDexEndpoints.breakLimit);

  await ref.watch(statisticsProvider.notifier).get(mangas);

  ref.disposeAfter(const Duration(minutes: 5));

  return mangas;
}

class QueriedMangaDexMangaViewWidget extends ConsumerWidget {
  const QueriedMangaDexMangaViewWidget({super.key, required this.mangaId});

  final String mangaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mangaProvider = ref.watch(_fetchMangaFromIdProvider(mangaId));

    Widget child;

    switch (mangaProvider) {
      case AsyncValue(valueOrNull: final manga?):
        return MangaDexMangaViewWidget(
          manga: manga,
        );
      case AsyncValue(:final error?, :final stackTrace?):
        final messenger = ScaffoldMessenger.of(context);
        Styles.showErrorSnackBar(messenger, '$error');
        logger.e("_fetchMangaFromIdProvider($mangaId) failed",
            error: error, stackTrace: stackTrace);

        child = Styles.errorColumn(error, stackTrace);
        break;
      case _:
        child = Styles.listSpinner;
        break;
    }

    return Scaffold(
      body: child,
    );
  }
}

class MangaDexMangaViewWidget extends HookConsumerWidget {
  const MangaDexMangaViewWidget({super.key, required this.manga});

  final Manga manga;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedin = ref.watch(authControlProvider).valueOrNull ?? false;
    final theme = Theme.of(context);
    final view = useState(_ViewType.chapters);
    final followProvider = ref.watch(followingStatusProvider(manga));
    final following = followProvider.valueOrNull;
    final statusProvider = ref.watch(readingStatusProvider(manga));
    final reading = statusProvider.valueOrNull;

    ref.watch(_fetchReadChaptersRedunProvider(manga));

    final hasRelated = manga.relatedMangas.isNotEmpty;

    String? lastvolchap;

    if ((manga.attributes!.lastVolume != null &&
            manga.attributes!.lastVolume!.isNotEmpty) ||
        (manga.attributes!.lastChapter != null &&
            manga.attributes!.lastChapter!.isNotEmpty)) {
      lastvolchap = '';

      if (manga.attributes!.lastVolume != null &&
          manga.attributes!.lastVolume!.isNotEmpty) {
        lastvolchap += 'Volume ${manga.attributes!.lastVolume}';
      }

      if (manga.attributes!.lastChapter != null &&
          manga.attributes!.lastChapter!.isNotEmpty) {
        lastvolchap +=
            '${lastvolchap.isEmpty ? '' : ', '}Chapter ${manga.attributes!.lastChapter!}';
      }
    }

    final formatTags = manga.attributes!.tags
        .where((tag) => tag.attributes.group == TagGroup.format);

    bool onScrollNotification(ScrollEndNotification notification) {
      if (notification.depth == 0 &&
          notification.metrics.axis == Axis.vertical &&
          notification.metrics.axisDirection == AxisDirection.down &&
          notification.metrics.atEdge &&
          notification.metrics.pixels == notification.metrics.maxScrollExtent) {
        switch (view.value) {
          case _ViewType.chapters:
            ref.read(mangaChaptersProvider(manga).notifier).getMore();
            break;
          case _ViewType.art:
            ref.read(mangaCoversProvider(manga).notifier).getMore();
          default:
            break;
        }
      }

      return false;
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (followProvider.hasError) {
            ref.invalidate(followingStatusProvider(manga));
          }

          if (statusProvider.hasError) {
            ref.invalidate(readingStatusProvider(manga));
          }

          switch (view.value) {
            case _ViewType.chapters:
              ref.read(mangaChaptersProvider(manga).notifier).clear();
              return ref.refresh(mangaChaptersProvider(manga).future);
            case _ViewType.art:
              ref.read(mangaCoversProvider(manga).notifier).clear();
              return ref.refresh(mangaCoversProvider(manga).future);
            default:
              break;
          }
        },
        notificationPredicate: (notification) {
          // Always handle refresh
          return true;
        },
        child: NestedScrollView(
          scrollBehavior: MouseTouchScrollBehavior(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                forceElevated: innerBoxIsScrolled,
                expandedHeight: 250.0,
                collapsedHeight: 100.0,
                leading: BackButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/');
                    }
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 3.0,
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: manga.attributes!.originalLanguage.flag,
                          style: const TextStyle(
                            fontFamily: 'Twemoji',
                            fontSize: 10,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.5, 0.5),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: manga.attributes!.title.get('en'),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  background: ExtendedImage.network(
                    manga.getFirstCoverUrl(quality: CoverArtQuality.medium),
                    cache: true,
                    colorBlendMode: BlendMode.modulate,
                    color: Colors.grey,
                    fit: BoxFit.cover,
                    loadStateChanged: extendedImageLoadStateHandler,
                  ),
                ),
                actions: !loggedin
                    ? null
                    : [
                        if (following == null || statusProvider.isLoading)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        if (following == false && reading == null) ...[
                          ElevatedButton(
                            style: Styles.buttonStyle(),
                            onPressed: () async {
                              final result = await showDialog<
                                      (MangaReadingStatus, bool)>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return HookBuilder(
                                      builder: (context) {
                                        final nav = Navigator.of(context);
                                        final nreading = useState(
                                            MangaReadingStatus.plan_to_read);
                                        final nfollowing = useState(true);

                                        return AlertDialog(
                                          title: const Text('Add to Library'),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              DropdownMenu<MangaReadingStatus>(
                                                initialSelection:
                                                    nreading.value,
                                                enableFilter: false,
                                                enableSearch: false,
                                                requestFocusOnTap: false,
                                                inputDecorationTheme:
                                                    InputDecorationTheme(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2.0,
                                                      color: theme.colorScheme
                                                          .inversePrimary,
                                                    ),
                                                  ),
                                                ),
                                                onSelected: (MangaReadingStatus?
                                                    status) async {
                                                  if (status != null) {
                                                    nreading.value = status;
                                                  }
                                                },
                                                dropdownMenuEntries: List<
                                                    DropdownMenuEntry<
                                                        MangaReadingStatus>>.generate(
                                                  MangaReadingStatus
                                                          .values.length -
                                                      1,
                                                  (int index) =>
                                                      DropdownMenuEntry<
                                                          MangaReadingStatus>(
                                                    value: MangaReadingStatus
                                                        .values
                                                        .elementAt(index + 1),
                                                    label: MangaReadingStatus
                                                        .values
                                                        .elementAt(index + 1)
                                                        .label,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  nfollowing.value =
                                                      !nfollowing.value;
                                                },
                                                child: Icon(nfollowing.value
                                                    ? Icons.notification_add
                                                    : Icons
                                                        .notifications_off_outlined),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                nav.pop(null);
                                              },
                                            ),
                                            ElevatedButton(
                                              child: const Text('Add'),
                                              onPressed: () {
                                                nav.pop((
                                                  nreading.value,
                                                  nfollowing.value
                                                ));
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  });

                              if (result != null) {
                                ref
                                    .read(readingStatusProvider(manga).notifier)
                                    .set(result.$1);

                                ref
                                    .read(
                                        followingStatusProvider(manga).notifier)
                                    .set(result.$2);
                              }
                            },
                            child: const Text('Add to Library'),
                          ),
                        ],
                        if (following != null && reading != null) ...[
                          Tooltip(
                            message:
                                following ? 'Unfollow Manga' : 'Follow Manga',
                            child: ElevatedButton(
                              style: Styles.buttonStyle(),
                              onPressed: () async {
                                bool set = !following;
                                ref
                                    .read(
                                        followingStatusProvider(manga).notifier)
                                    .set(set);
                              },
                              child: Icon(following
                                  ? Icons.notifications_active
                                  : Icons.notifications_off_outlined),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          DropdownMenu<MangaReadingStatus>(
                            initialSelection: reading,
                            width: 180.0,
                            enableFilter: false,
                            enableSearch: false,
                            requestFocusOnTap: false,
                            inputDecorationTheme: InputDecorationTheme(
                              filled: true,
                              fillColor:
                                  theme.colorScheme.background.withAlpha(200),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color: theme.colorScheme.inversePrimary,
                                ),
                              ),
                            ),
                            onSelected: (MangaReadingStatus? status) async {
                              ref
                                  .read(readingStatusProvider(manga).notifier)
                                  .set(status);

                              if (status == null ||
                                  status == MangaReadingStatus.remove) {
                                ref
                                    .read(
                                        followingStatusProvider(manga).notifier)
                                    .set(false);
                              }
                            },
                            dropdownMenuEntries: List<
                                DropdownMenuEntry<MangaReadingStatus>>.generate(
                              MangaReadingStatus.values.length,
                              (int index) =>
                                  DropdownMenuEntry<MangaReadingStatus>(
                                value:
                                    MangaReadingStatus.values.elementAt(index),
                                label: MangaReadingStatus.values
                                    .elementAt(index)
                                    .label,
                              ),
                            ),
                          ),
                        ],
                        Consumer(
                          builder: (context, ref, child) {
                            final ratingProv = ref.watch(ratingsProvider);
                            final ratings = ratingProv.valueOrNull;

                            if (ratingProv.isLoading || ratings == null) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            return MenuAnchor(
                              builder: (context, controller, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (controller.isOpen) {
                                        controller.close();
                                      } else {
                                        controller.open();
                                      }
                                    },
                                    child: child,
                                  ),
                                );
                              },
                              menuChildren: [
                                ...List.generate(
                                  10,
                                  (index) => MenuItemButton(
                                    onPressed: () {
                                      ref
                                          .read(ratingsProvider.notifier)
                                          .set(manga, index + 1);
                                    },
                                    child: Text(RatingLabel[index + 1]),
                                  ),
                                ).reversed,
                                if (ratings.containsKey(manga.id) &&
                                    ratings[manga.id]!.rating > 0)
                                  MenuItemButton(
                                    onPressed: () {
                                      ref
                                          .read(ratingsProvider.notifier)
                                          .set(manga, null);
                                    },
                                    child: const Text('Remove Rating'),
                                  )
                              ],
                              child: Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: ratings.containsKey(manga.id) &&
                                          ratings[manga.id]!.rating > 0
                                      ? Colors.deepOrange
                                      : theme.colorScheme.surfaceVariant,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6.0)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star_border),
                                    if (ratings.containsKey(manga.id) &&
                                        ratings[manga.id]!.rating > 0) ...[
                                      const SizedBox(
                                        width: 4.0,
                                      ),
                                      Text('${ratings[manga.id]!.rating}')
                                    ]
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final userListsProv = ref.watch(userListsProvider);
                            final userLists = userListsProv.valueOrNull;

                            return MenuAnchor(
                              builder: (context, controller, child) {
                                // Let MenuAnchor build the spinner so that it doesn't
                                // destroy the opened menu when updated
                                if (userListsProv.isLoading ||
                                    userLists == null) {
                                  return const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (controller.isOpen) {
                                        controller.close();
                                      } else {
                                        controller.open();
                                      }
                                    },
                                    child: child,
                                  ),
                                );
                              },
                              menuChildren: [
                                if (userLists != null)
                                  ...List.generate(
                                    userLists.length,
                                    (index) => CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(userLists
                                          .elementAt(index)
                                          .get<CustomList>()
                                          .attributes
                                          .name),
                                      value: userLists
                                          .elementAt(index)
                                          .get<CustomList>()
                                          .set
                                          .contains(manga.id),
                                      onChanged: (bool? value) async {
                                        await ref
                                            .read(userListsProvider.notifier)
                                            .updateList(
                                                userLists.elementAt(index),
                                                manga,
                                                value == true);
                                      },
                                    ),
                                  ),
                                MenuItemButton(
                                  child: const Text('+ Create new list'),
                                  onPressed: () async {
                                    final messenger =
                                        ScaffoldMessenger.of(context);

                                    final result = await showDialog<
                                            (String, CustomListVisibility)>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return HookBuilder(
                                            builder: (context) {
                                              final nav = Navigator.of(context);
                                              final nameController =
                                                  useTextEditingController();
                                              final nameIsEmpty =
                                                  useListenableSelector(
                                                      nameController,
                                                      () => nameController
                                                          .text.isEmpty);
                                              final nprivate = useState(
                                                  CustomListVisibility.private);

                                              return AlertDialog(
                                                title: const Text(
                                                    'Create New List'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                        filled: true,
                                                        labelText: 'List Name',
                                                      ),
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      validator:
                                                          (String? value) {
                                                        return (value == null ||
                                                                value.isEmpty)
                                                            ? 'List name cannot be empty.'
                                                            : null;
                                                      },
                                                    ),
                                                    CheckboxListTile(
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      title: const Text(
                                                          'Private list'),
                                                      value: nprivate.value ==
                                                          CustomListVisibility
                                                              .private,
                                                      onChanged:
                                                          (bool? value) async {
                                                        nprivate
                                                            .value = (value ==
                                                                true)
                                                            ? CustomListVisibility
                                                                .private
                                                            : CustomListVisibility
                                                                .public;
                                                      },
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      nav.pop(null);
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: nameIsEmpty
                                                        ? null
                                                        : () {
                                                            if (nameController
                                                                .text
                                                                .isNotEmpty) {
                                                              nav.pop((
                                                                nameController
                                                                    .text,
                                                                nprivate.value
                                                              ));
                                                            }
                                                          },
                                                    child: const Text('Create'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });

                                    if (result != null) {
                                      final success = await ref
                                          .read(userListsProvider.notifier)
                                          .newList(result.$1, result.$2, []);

                                      if (success) {
                                        messenger
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('New list created.'),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                      } else {
                                        messenger
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('Failed create list.'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                      }
                                    }
                                  },
                                )
                              ],
                              child: Container(
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surfaceVariant,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6.0)),
                                ),
                                child: const Icon(Icons.playlist_add),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: theme.cardColor,
                  child: Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: [
                      if (manga.attributes!.contentRating != ContentRating.safe)
                        ContentRatingChip(
                            rating: manga.attributes!.contentRating),
                      ...manga.attributes!.tags
                          .where(
                              (tag) => tag.attributes.group == TagGroup.content)
                          .map((e) => ContentChip(
                              content: e.attributes.name.get('en'))),
                      if (manga.attributes!.tags.isNotEmpty)
                        ...manga.attributes!.tags
                            .where((tag) =>
                                tag.attributes.group != TagGroup.content)
                            .map(
                              (e) => IconTextChip(
                                  text: Text(e.attributes.name.get('en'))),
                            ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: theme.cardColor,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final statsProvider = ref.watch(statisticsProvider);
                      return Wrap(
                        runSpacing: 4.0,
                        children: [
                          ...switch (statsProvider) {
                            // ignore: unused_local_variable
                            AsyncValue(:final error?, :final stackTrace?) => [
                                const SizedBox(
                                  width: 10,
                                ),
                                const IconTextChip(
                                  text: Text(statsError),
                                )
                              ],
                            AsyncValue(valueOrNull: final stats?) => () {
                                if (stats.containsKey(manga.id)) {
                                  return [
                                    IconTextChip(
                                      icon: const Icon(
                                        Icons.star_border,
                                        color: Colors.amber,
                                        size: 18,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                      text: Text(
                                        stats[manga.id]
                                                ?.rating
                                                .bayesian
                                                .toStringAsFixed(2) ??
                                            statsError,
                                        style: const TextStyle(
                                          color: Colors.amber,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    IconTextChip(
                                      icon: const Icon(
                                        Icons.bookmark_outline,
                                        size: 18,
                                      ),
                                      text: Text(
                                        stats[manga.id]?.follows.toString() ??
                                            statsError,
                                      ),
                                    ),
                                  ];
                                }

                                return [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const IconTextChip(
                                    text: Text(statsError),
                                  )
                                ];
                              }(),
                            _ => [
                                const SizedBox(
                                  width: 10,
                                ),
                                const IconTextChip(
                                  text: CircularProgressIndicator(),
                                )
                              ],
                          },
                          const SizedBox(width: 10),
                          MangaStatusChip(status: manga.attributes!.status),
                        ],
                      );
                    },
                  ),
                ),
              ),
              if (manga.attributes!.altTitles.isNotEmpty)
                SliverToBoxAdapter(
                  child: ExpansionTile(
                    title: const Text('Alt. Titles'),
                    children: [
                      for (final Map(entries: entry)
                          in manga.attributes!.altTitles)
                        ExpansionTile(
                          title: Text(Languages.get(entry.first.key).label),
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              color: theme.colorScheme.surfaceVariant,
                              child: Text(entry.first.value),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              if (manga.attributes!.description.isNotEmpty)
                SliverToBoxAdapter(
                  child: ExpansionTile(
                    title: const Text('Synopsis'),
                    children: [
                      for (final MapEntry(key: lang, value: desc)
                          in manga.attributes!.description.entries)
                        ExpansionTile(
                          title: Text(Languages.get(lang).label),
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              color: theme.colorScheme.surfaceVariant,
                              child: MarkdownBody(
                                data: desc,
                                onTapLink: (text, url, title) async {
                                  if (url != null) {
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              SliverToBoxAdapter(
                child: ExpansionTile(
                  title: const Text('Info'),
                  children: [
                    if (manga.author != null)
                      ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: const Text('Author'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: manga.author!
                                  .map((e) => ButtonChip(
                                        text: Text(e.attributes.name),
                                        onPressed: () {
                                          context.push('/author/${e.id}',
                                              extra: e);
                                        },
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    if (manga.artist != null)
                      ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: const Text('Artist'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: manga.artist!
                                  .map((e) => ButtonChip(
                                        text: Text(e.attributes.name),
                                        onPressed: () {
                                          context.push('/author/${e.id}',
                                              extra: e);
                                        },
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    if (manga.attributes!.publicationDemographic != null)
                      ExpansionTile(
                        title: const Text('Demograhic'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Row(
                              children: [
                                IconTextChip(
                                  text: Text(manga.attributes!
                                      .publicationDemographic!.label),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (manga.attributes!.tags.isNotEmpty)
                      ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: const Text('Genres'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: manga.attributes!.tags
                                  .where((tag) =>
                                      tag.attributes.group == TagGroup.genre)
                                  .map((e) => IconTextChip(
                                      text: Text(e.attributes.name.get('en'))))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    if (manga.attributes!.tags.isNotEmpty)
                      ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: const Text('Themes'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: manga.attributes!.tags
                                  .where((tag) =>
                                      tag.attributes.group == TagGroup.theme)
                                  .map((e) => IconTextChip(
                                      text: Text(e.attributes.name.get('en'))))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    if (formatTags.isNotEmpty)
                      ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: const Text('Format'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: formatTags
                                  .map((e) => IconTextChip(
                                      text: Text(e.attributes.name.get('en'))))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: const Text('Track'),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: theme.colorScheme.background,
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: [
                              if (manga.attributes!.links?.raw != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final url = manga.attributes!.links!.raw!;
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('Official Raw'),
                                ),
                              if (manga.attributes!.links?.mu != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final seriesnum = int.tryParse(
                                        manga.attributes!.links!.mu!);
                                    var url =
                                        'https://www.mangaupdates.com/series/${manga.attributes!.links!.mu!}';

                                    if (seriesnum != null) {
                                      url =
                                          'https://www.mangaupdates.com/series.html?id=${manga.attributes!.links!.mu!}';
                                    }

                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('MangaUpdates'),
                                ),
                              if (manga.attributes!.links?.al != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final url =
                                        'https://anilist.co/manga/${manga.attributes!.links!.al!}';
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('AniList'),
                                ),
                              if (manga.attributes!.links?.mal != null)
                                ButtonChip(
                                  onPressed: () async {
                                    final url =
                                        'https://myanimelist.net/manga/${manga.attributes!.links!.mal!}';
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  text: const Text('MyAnimeList'),
                                ),
                              ButtonChip(
                                onPressed: () async {
                                  final route =
                                      GoRouterState.of(context).uri.toString();
                                  final url =
                                      Uri.parse('https://mangadex.org$route');

                                  if (DeviceContext.isMobile()) {
                                    InAppBrowser().openUrlRequest(
                                      urlRequest:
                                          URLRequest(url: WebUri.uri(url)),
                                      settings: InAppBrowserClassSettings(
                                        browserSettings: InAppBrowserSettings(
                                          hideToolbarTop: true,
                                        ),
                                      ),
                                    );
                                  } else if (!await launchUrl(url)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                text: const Text('Open on MangaDex'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (lastvolchap != null)
                      ExpansionTile(
                        title: const Text('Final Volume/Chapter'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            color: theme.colorScheme.background,
                            child: Row(
                              children: [
                                Text(lastvolchap),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: theme.cardColor,
                  child: ToggleButtons(
                    isSelected: List<bool>.generate(
                        hasRelated
                            ? _ViewType.values.length
                            : _ViewType.values.length - 1,
                        (index) => view.value.index == index),
                    onPressed: (index) {
                      view.value = _ViewType.values.elementAt(index);
                    },
                    textStyle: const TextStyle(fontSize: 24),
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                    children: [
                      ...(hasRelated
                              ? _ViewType.values
                              : _ViewType.values.take(2))
                          .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(e.name.capitalize())))
                    ],
                  ),
                ),
              ),
              if (view.value == _ViewType.chapters && loggedin)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: theme.cardColor,
                    child: Row(
                      children: [
                        const Spacer(),
                        Consumer(
                          builder: (context, ref, child) {
                            final chapters = ref
                                .watch(mangaChaptersProvider(manga))
                                .valueOrNull;

                            final allRead = chapters != null
                                ? ref.watch(readChaptersProvider
                                    .select((value) => switch (value) {
                                          AsyncValue(
                                            valueOrNull: final data?
                                          ) =>
                                            data[manga.id]?.containsAll(chapters
                                                    .map((e) => e.id)) ==
                                                true,
                                          _ => false,
                                        }))
                                : false;

                            final opt = allRead ? 'unread' : 'read';

                            return ElevatedButton(
                              style: Styles.buttonStyle(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0)),
                              onPressed: () async {
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final nav = Navigator.of(context);
                                    return AlertDialog(
                                      title: Text('Mark all as $opt'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Are you sure you want to mark all visible chapters as $opt?'),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text('No'),
                                          onPressed: () {
                                            nav.pop(false);
                                          },
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            nav.pop(true);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (chapters != null && result == true) {
                                  ref.read(readChaptersProvider.notifier).set(
                                      manga,
                                      read: !allRead ? chapters : null,
                                      unread: allRead ? chapters : null);
                                }
                              },
                              child: Text('Mark all visible as $opt'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ];
          },
          body: SafeArea(
              top: false,
              bottom: false,
              child: switch (view.value) {
                _ViewType.chapters => Consumer(
                    builder: (context, ref, child) {
                      final chapterProvider =
                          ref.watch(mangaChaptersProvider(manga));

                      return Stack(
                        children: [
                          switch (chapterProvider) {
                            AsyncValue(:final error?, :final stackTrace?) =>
                              () {
                                final messenger = ScaffoldMessenger.of(context);
                                Styles.showErrorSnackBar(messenger, '$error');
                                logger.e(
                                    "mangaChaptersProvider(${manga.id}) failed",
                                    error: error,
                                    stackTrace: stackTrace);

                                return Styles.errorColumn(error, stackTrace);
                              }(),
                            AsyncValue(valueOrNull: final chapters?) =>
                              NotificationListener<ScrollEndNotification>(
                                onNotification: onScrollNotification,
                                child: CustomScrollView(
                                  slivers: [
                                    SliverList.builder(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var lastChapIsSame = false;
                                        var nextChapIsSame = false;

                                        final thischap =
                                            chapters.elementAt(index);
                                        final chapbtn = ChapterButtonWidget(
                                          chapter: thischap,
                                          manga: manga,
                                          link: Text(
                                            manga.attributes!.title.get('en'),
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                        );

                                        if (index > 0) {
                                          lastChapIsSame = chapters
                                                  .elementAt(index - 1)
                                                  .attributes
                                                  .chapter ==
                                              thischap.attributes.chapter;
                                        }

                                        if (index < chapters.length - 1) {
                                          nextChapIsSame = chapters
                                                  .elementAt(index + 1)
                                                  .attributes
                                                  .chapter ==
                                              thischap.attributes.chapter;
                                        }

                                        if (lastChapIsSame || nextChapIsSame) {
                                          Widget child = Row(
                                            children: [
                                              const Icon(
                                                Icons.subdirectory_arrow_right,
                                                size: 15.0,
                                              ),
                                              Flexible(
                                                child: chapbtn,
                                              ),
                                            ],
                                          );

                                          if (!lastChapIsSame &&
                                              nextChapIsSame) {
                                            child = Wrap(
                                              children: [
                                                Text(
                                                    "Chapter ${thischap.attributes.chapter}"),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .subdirectory_arrow_right,
                                                      size: 15.0,
                                                    ),
                                                    Flexible(
                                                      child: chapbtn,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }

                                          return Padding(
                                            padding: EdgeInsets.only(
                                                top: (!lastChapIsSame &&
                                                        nextChapIsSame)
                                                    ? 6.0
                                                    : 2.0,
                                                bottom: (lastChapIsSame &&
                                                        !nextChapIsSame)
                                                    ? 6.0
                                                    : 2.0),
                                            child: child,
                                          );
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2.0),
                                          child: chapbtn,
                                        );
                                      },
                                      itemCount: chapters.length,
                                    )
                                  ],
                                ),
                              ),
                            _ => const SizedBox.shrink(),
                          },
                          if (chapterProvider.isLoading)
                            ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
                _ViewType.art => Consumer(
                    builder: (context, ref, child) {
                      final coverProvider =
                          ref.watch(mangaCoversProvider(manga));

                      return Stack(
                        children: [
                          switch (coverProvider) {
                            AsyncValue(:final error?, :final stackTrace?) =>
                              () {
                                final messenger = ScaffoldMessenger.of(context);
                                Styles.showErrorSnackBar(messenger, '$error');
                                logger.e(
                                    "mangaCoversProvider(${manga.id}) failed",
                                    error: error,
                                    stackTrace: stackTrace);

                                return Styles.errorColumn(error, stackTrace);
                              }(),
                            AsyncValue(valueOrNull: final covers?) =>
                              NotificationListener<ScrollEndNotification>(
                                onNotification: onScrollNotification,
                                child: CustomScrollView(
                                  slivers: [
                                    SliverGrid.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 256,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        childAspectRatio: 0.7,
                                      ),
                                      itemBuilder: (context, index) {
                                        final cover = covers.elementAt(index);
                                        return _CoverArtItem(
                                          cover: cover,
                                          manga: manga,
                                          page: index,
                                          onTap: () async {
                                            await showModal(
                                              context: context,
                                              builder: (context) {
                                                return Scaffold(
                                                  appBar: AppBar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    leading:
                                                        const CloseButton(),
                                                  ),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  extendBody: true,
                                                  extendBodyBehindAppBar: true,
                                                  body: PageView.builder(
                                                    scrollBehavior:
                                                        MouseTouchScrollBehavior(),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int id) {
                                                      final item =
                                                          covers.elementAt(id);
                                                      final url =
                                                          manga.getUrlFromCover(
                                                              item);
                                                      Widget image =
                                                          ExtendedImage.network(
                                                        url,
                                                        fit: BoxFit.contain,
                                                        mode: ExtendedImageMode
                                                            .gesture,
                                                        enableSlideOutPage:
                                                            true,
                                                        loadStateChanged:
                                                            extendedImageLoadStateHandler,
                                                      );

                                                      image = Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        color:
                                                            Colors.transparent,
                                                        child: GestureDetector(
                                                          child: image,
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      );

                                                      if (id == index) {
                                                        return Hero(
                                                          tag: url,
                                                          child: image,
                                                        );
                                                      } else {
                                                        return image;
                                                      }
                                                    },
                                                    itemCount: covers.length,
                                                    controller: PageController(
                                                      initialPage: index,
                                                    ),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      itemCount: covers.length,
                                    ),
                                  ],
                                ),
                              ),
                            _ => const SizedBox.shrink(),
                          },
                          if (coverProvider.isLoading) ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
                _ViewType.related => Consumer(
                    builder: (context, ref, child) {
                      final relatedProvider =
                          ref.watch(_fetchRelatedMangaProvider(manga));

                      return Stack(
                        children: [
                          switch (relatedProvider) {
                            AsyncValue(:final error?, :final stackTrace?) =>
                              () {
                                final messenger = ScaffoldMessenger.of(context);
                                Styles.showErrorSnackBar(messenger, '$error');
                                logger.e(
                                    "_fetchRelatedMangaProvider(${manga.id}) failed",
                                    error: error,
                                    stackTrace: stackTrace);

                                return Styles.errorColumn(error, stackTrace);
                              }(),
                            AsyncValue(valueOrNull: final related?) =>
                              MangaListWidget(
                                title: const Text(
                                  'Related Titles',
                                  style: TextStyle(fontSize: 24),
                                ),
                                noController: true,
                                children: [
                                  MangaListViewSliver(
                                    items: related,
                                    headers: manga.relatedMangas.fold({},
                                        (previousValue, element) {
                                      previousValue?[element.id] =
                                          element.related!.label;
                                      return previousValue;
                                    }),
                                  ),
                                ],
                              ),
                            _ => const SizedBox.shrink(),
                          },
                          if (relatedProvider.isLoading)
                            ...Styles.loadingOverlay
                        ],
                      );
                    },
                  ),
              }),
        ),
      ),
    );
  }
}

class _CoverArtItem extends HookWidget {
  const _CoverArtItem({
    required this.cover,
    required this.manga,
    required this.page,
    this.onTap,
  });

  final CoverArt cover;
  final Manga manga;
  final int page;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final aniController =
        useAnimationController(duration: const Duration(milliseconds: 100));
    final gradient =
        useAnimation(aniController.drive(Styles.coverArtGradientTween));
    final url = manga.getUrlFromCover(cover);

    final Widget image = Material(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      clipBehavior: Clip.antiAlias,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: gradient,
            end: Alignment.bottomCenter,
            colors: const [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: ExtendedImage.network(
          url.quality(quality: CoverArtQuality.medium),
          cache: true,
          loadStateChanged: extendedImageLoadStateHandler,
          width: 256.0,
        ),
      ),
    );

    return Hero(
      tag: url,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onHover: (hovering) {
            if (hovering) {
              aniController.forward();
            } else {
              aniController.reverse();
            }
          },
          child: GridTile(
            footer: cover.attributes?.volume != null
                ? SizedBox(
                    height: 40,
                    child: Material(
                      color: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(4)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: GridTileBar(
                        title: Text(
                          'Volume ${cover.attributes!.volume!}',
                          softWrap: true,
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
            child: image,
          ),
        ),
      ),
    );
  }
}
