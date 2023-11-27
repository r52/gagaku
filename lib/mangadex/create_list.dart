import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/mangadex/model.dart';
import 'package:gagaku/mangadex/types.dart';
import 'package:gagaku/mangadex/widgets.dart';
import 'package:gagaku/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MangaDexCreateListScreen extends HookConsumerWidget {
  const MangaDexCreateListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNameController = useTextEditingController();
    final listNameIsEmpty = useListenableSelector(
        listNameController, () => listNameController.text.isEmpty);

    final isPrivate = useState(true);

    final pendingCreate = useState<Future<bool>?>(null);
    final snapshot = useFuture(pendingCreate.value);

    final titles = useState<Set<Manga>>({});

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        flexibleSpace: GestureDetector(
          child:
              Styles.titleFlexBar(context: context, title: 'Create New List'),
        ),
        actions: [
          TextButton(
            style: Styles.buttonStyle(),
            child: const Text('Cancel'),
            onPressed: () {
              listNameController.clear();
              context.pop();
            },
          ),
          ElevatedButton(
            style: Styles.buttonStyle(),
            onPressed: listNameIsEmpty
                ? null
                : () async {
                    final messenger = ScaffoldMessenger.of(context);

                    if (listNameController.text.isNotEmpty) {
                      final success = ref
                          .read(userListsProvider.notifier)
                          .newList(listNameController.text, isPrivate.value,
                              titles.value);

                      success.then((success) {
                        if (success) {
                          context.pop(true);
                          listNameController.clear();
                        } else {
                          messenger
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Failed to create list.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                        }
                      });

                      pendingCreate.value = success;
                    } else {
                      messenger
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('List name cannot be empty.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                    }
                  },
            child: const Text('Create'),
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: listNameController,
                        decoration: const InputDecoration(
                          filled: true,
                          labelText: 'List Name',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          return (value == null || value.isEmpty)
                              ? 'List Name cannot be empty.'
                              : null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    DropdownMenu<bool>(
                      label: const Text('Visibility'),
                      initialSelection: isPrivate.value,
                      enableFilter: false,
                      enableSearch: false,
                      requestFocusOnTap: false,
                      onSelected: (private) {
                        isPrivate.value = (private == true);
                      },
                      dropdownMenuEntries: const [
                        DropdownMenuEntry<bool>(
                          value: true,
                          label: 'Private',
                        ),
                        DropdownMenuEntry<bool>(
                          value: false,
                          label: 'Public',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  style: Styles.buttonStyle(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () {
                    context
                        .push<Set<Manga>>('/search?selectMode=true',
                            extra: titles.value)
                        .then((selected) {
                      if (selected != null) {
                        titles.value = {...selected};
                      }
                    });
                  },
                  child: const Text('Add Titles'),
                ),
                const SizedBox(height: 12.0),
                Expanded(
                  child: MangaListWidget(
                    title: const Text(
                      'Selected Titles',
                      style: TextStyle(fontSize: 24),
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    showToggle: false,
                    children: [
                      MangaListViewSliver(
                        items: titles.value,
                        selectMode: true,
                        selectButton: (manga) {
                          return const Icon(Icons.remove);
                        },
                        onSelected: (manga) {
                          titles.value = {...titles.value..remove(manga)};
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (snapshot.connectionState == ConnectionState.waiting)
            ...Styles.loadingOverlay
        ],
      ),
    );
  }
}
