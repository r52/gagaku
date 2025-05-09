import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/util/ui.dart';
import 'package:gagaku/web/model/config.dart';
import 'package:gagaku/web/model/model.dart';
import 'package:gagaku/web/repo_list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WebSourceSettingsRouteBuilder<T> extends SlideTransitionRouteBuilder<T> {
  WebSourceSettingsRouteBuilder()
    : super(
        pageBuilder:
            (context, animation, secondaryAnimation) =>
                const WebSourceSettingsWidget(),
      );
}

class WebSourceSettingsWidget extends HookConsumerWidget {
  const WebSourceSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final nav = Navigator.of(context);
    final cfg = ref.watch(webConfigProvider);
    final config = useState(cfg.copyWith());

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(tr.arg_settings(arg: tr.webSources.text)),
        actions: [
          OverflowBar(
            spacing: 8.0,
            children: [
              Tooltip(
                message: tr.saveSettings,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(tr.saveSettings),
                  onPressed: () {
                    ref.read(webConfigProvider.saveWith)(
                      installedSources: config.value.installedSources,
                      categories: config.value.categories,
                      defaultCategory: config.value.defaultCategory,
                    );
                    ref.read(webSourceFavoritesProvider.reconfigureCategories)(
                      config.value.categories,
                      config.value.defaultCategory,
                    );
                    nav.pop();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          children: [
            SettingCardWidget(
              title: Text(
                tr.webSources.settings.repos,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(tr.webSources.settings.reposDesc),
              builder: (context) {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      nav.push(
                        SlideTransitionRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const RepoListManager(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.library_add),
                    label: Text(tr.ui.manage),
                  ),
                );
              },
            ),
            SettingCardWidget(
              title: Text(
                tr.webSources.settings.categories,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(tr.webSources.settings.categoriesDesc),
              builder: (context) {
                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await nav
                          .push<(List<WebSourceCategory>, String)>(
                            SlideTransitionRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      CategoryManager(
                                        categories: [
                                          ...config.value.categories,
                                        ],
                                        defaultCategory:
                                            config.value.defaultCategory,
                                      ),
                            ),
                          );

                      if (result != null) {
                        config.value = config.value.copyWith(
                          categories: result.$1,
                          defaultCategory: result.$2,
                        );
                      }
                    },
                    icon: const Icon(Icons.library_add),
                    label: Text(tr.ui.manage),
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
  const CategoryManager({
    super.key,
    required this.categories,
    required this.defaultCategory,
  });

  final List<WebSourceCategory> categories;
  final String defaultCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = context.t;
    final nav = Navigator.of(context);
    final list = useState(categories);
    final defaultCat = useState(defaultCategory);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: TitleFlexBar(title: tr.webSources.settings.categories),
        actions: [
          IconButton(
            tooltip: tr.webSources.settings.newCategory,
            onPressed: () async {
              final result = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return NewCategoryDialog(list: list.value);
                },
              );

              if (result != null) {
                final cat = WebSourceCategory.name(result);

                list.value = [...list.value, cat];
              }
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            tooltip: tr.ui.save,
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
            Text(tr.ui.dragHint),
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
                            onPressed:
                                item.id == defaultCat.value
                                    ? null
                                    : () {
                                      defaultCat.value = item.id;
                                    },
                            child: Text(tr.ui.makeDefault),
                          ),
                          IconButton(
                            tooltip: tr.ui.rename,
                            onPressed: () async {
                              final result = await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) {
                                  return NewCategoryDialog(
                                    list: list.value,
                                    rename: item.name,
                                  );
                                },
                              );

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
                            tooltip: tr.ui.delete,
                            color: Colors.red,
                            onPressed:
                                list.value.length != 1
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
    final tr = context.t;
    final fieldController = useTextEditingController(text: rename);

    return AlertDialog(
      title: Text(
        rename == null
            ? tr.webSources.settings.addCategory
            : tr.webSources.settings.renameCategory,
      ),
      content: TextFormField(
        controller: fieldController,
        decoration: InputDecoration(
          hintText: tr.webSources.settings.categoryName,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return tr.webSources.settings.emptyCategoryWarning;
          }
          if (list.indexWhere((e) => e.name == value) != -1) {
            return tr.webSources.settings.usedCategoryWarning;
          }

          return null;
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text(tr.ui.cancel),
          onPressed: () {
            Navigator.of(context).pop();
            fieldController.clear();
          },
        ),
        HookBuilder(
          builder: (_) {
            final nameIsValid = useListenableSelector(
              fieldController,
              () =>
                  fieldController.text.isNotEmpty &&
                  list.indexWhere((e) => e.name == fieldController.text) == -1,
            );
            return ElevatedButton(
              onPressed:
                  nameIsValid
                      ? () {
                        Navigator.of(context).pop(fieldController.text);
                        fieldController.clear();
                      }
                      : null,
              child: Text(rename == null ? tr.ui.add : tr.ui.rename),
            );
          },
        ),
      ],
    );
  }
}
