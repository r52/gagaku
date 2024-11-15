import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/repo_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class WebSourceSettingsRouteBuilder<T> extends SlideTransitionRouteBuilder<T> {
  WebSourceSettingsRouteBuilder()
      : super(pageBuilder: (context, animation, secondaryAnimation) => const WebSourceSettingsWidget());
}

class WebSourceSettingsWidget extends HookConsumerWidget {
  const WebSourceSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final cfg = ref.watch(webConfigProvider);
    final config = useState(cfg.copyWith());

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('arg_settings'.tr(context: context, args: ['webSources.text'.tr(context: context)])),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: 'saveSettings'.tr(context: context),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text('saveSettings'.tr(context: context)),
                  onPressed: () {
                    ref.read(webConfigProvider.notifier).saveWith(
                          sourceDirectory: config.value.sourceDirectory,
                          categories: config.value.categories,
                          defaultCategory: config.value.defaultCategory,
                        );
                    ref
                        .read(webSourceFavoritesProvider.notifier)
                        .reconfigureCategories(config.value.categories, config.value.defaultCategory);
                    nav.pop();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingCardWidget(
              title: Text(
                'webSources.settings.sourcePath'.tr(context: context),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('webSources.settings.sourcePathDesc'.tr(context: context)),
              builder: (context) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10.0,
                    children: [
                      Text(config.value.sourceDirectory),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final perms = await Permission.manageExternalStorage.request();

                          if (perms.isGranted) {
                            String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

                            if (selectedDirectory != null) {
                              config.value = config.value.copyWith(sourceDirectory: selectedDirectory);
                            }
                          }
                        },
                        icon: const Icon(Icons.folder_open),
                        label: Text('ui.browse'.tr(context: context)),
                      ),
                    ],
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                'webSources.settings.repos'.tr(context: context),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('webSources.settings.reposDesc'.tr(context: context)),
              builder: (context) {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      nav.push(SlideTransitionRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const RepoListManager(),
                      ));
                    },
                    icon: const Icon(Icons.library_add),
                    label: Text('ui.manage'.tr(context: context)),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                'webSources.settings.categories'.tr(context: context),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('webSources.settings.categoriesDesc'.tr(context: context)),
              builder: (context) {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await nav.push<(List<WebSourceCategory>, String)>(SlideTransitionRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => CategoryManager(
                          categories: [...config.value.categories],
                          defaultCategory: config.value.defaultCategory,
                        ),
                      ));

                      if (result != null) {
                        config.value.categories = result.$1;
                        config.value.defaultCategory = result.$2;
                      }
                    },
                    icon: const Icon(Icons.library_add),
                    label: Text('ui.manage'.tr(context: context)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryManager extends HookConsumerWidget {
  const CategoryManager({super.key, required this.categories, required this.defaultCategory});

  final List<WebSourceCategory> categories;
  final String defaultCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = Navigator.of(context);
    final list = useState(categories);
    final defaultCat = useState(defaultCategory);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(title: 'webSources.settings.categories'.tr(context: context)),
        actions: [
          IconButton(
            tooltip: 'webSources.settings.newCategory'.tr(context: context),
            onPressed: () async {
              final result = await showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return NewCategoryDialog(
                      list: list.value,
                    );
                  });

              if (result != null) {
                final cat = WebSourceCategory.name(result);

                list.value = [...list.value, cat];
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            tooltip: 'ui.save'.tr(context: context),
            onPressed: () {
              nav.pop((list.value, defaultCat.value));
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ui.dragHint'.tr(context: context)),
            Expanded(
              child: ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }

                  final items = list.value;

                  final item = items.removeAt(oldIndex);
                  items.insert(newIndex, item);

                  list.value = items;
                },
                itemCount: list.value.length,
                itemBuilder: (context, index) {
                  final item = list.value.elementAt(index);
                  return Card(
                    key: ValueKey(item.id),
                    child: ListTile(
                      leading: const Icon(Icons.category),
                      title: Text(item.name),
                      trailing: OverflowBar(
                        children: [
                          ElevatedButton(
                            onPressed: item.id == defaultCat.value
                                ? null
                                : () {
                                    defaultCat.value = item.id;
                                  },
                            child: Text('ui.makeDefault'.tr(context: context)),
                          ),
                          IconButton(
                            tooltip: 'ui.rename'.tr(context: context),
                            onPressed: () async {
                              final result = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return NewCategoryDialog(list: list.value, rename: item.name);
                                  });

                              if (result != null) {
                                final cat = WebSourceCategory(item.id, result);

                                final idx = list.value.indexOf(item);
                                if (idx != -1) {
                                  list.value[idx] = cat;
                                }

                                list.value = [...list.value];
                              }
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            tooltip: 'ui.delete'.tr(context: context),
                            color: Colors.red,
                            onPressed: list.value.length != 1
                                ? () {
                                    list.value.remove(item);
                                    list.value = [...list.value];

                                    if (item.id == defaultCat.value) {
                                      defaultCat.value = list.value.first.id;
                                    }
                                  }
                                : null,
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewCategoryDialog extends HookWidget {
  const NewCategoryDialog({super.key, required this.list, this.rename});

  final List<WebSourceCategory> list;
  final String? rename;

  @override
  Widget build(BuildContext context) {
    final fieldController = useTextEditingController(text: rename);

    return AlertDialog(
      title: Text(rename == null
          ? 'webSources.settings.addCategory'.tr(context: context)
          : 'webSources.settings.renameCategory'.tr(context: context)),
      content: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(hintText: 'webSources.settings.categoryName'.tr(context: context)),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value == null || value.isEmpty) return 'webSources.settings.emptyCategoryWarning'.tr(context: context);
          if (list.indexWhere((e) => e.name == value) != -1) {
            return 'webSources.settings.usedCategoryWarning'.tr(context: context);
          }

          return null;
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('ui.cancel'.tr(context: context)),
          onPressed: () {
            Navigator.of(context).pop();
            fieldController.clear();
          },
        ),
        HookBuilder(
          builder: (_) {
            final nameIsValid = useListenableSelector(fieldController,
                () => fieldController.text.isNotEmpty && list.indexWhere((e) => e.name == fieldController.text) == -1);
            return ElevatedButton(
              onPressed: nameIsValid
                  ? () {
                      Navigator.of(context).pop(fieldController.text);
                      fieldController.clear();
                    }
                  : null,
              child: Text(rename == null ? 'ui.add'.tr(context: context) : 'ui.rename'.tr(context: context)),
            );
          },
        ),
      ],
    );
  }
}
