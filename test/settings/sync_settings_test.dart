import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gagaku/i18n/strings.g.dart';
import 'package:gagaku/settings/sync.dart';
import 'package:gagaku/sync/metadata.dart';
import 'package:gagaku/sync/service.dart';

void main() {
  setUpAll(() async {
    await LocaleSettings.setLocale(AppLocale.en);
  });

  testWidgets('disabled state offers explicit create and join actions', (
    tester,
  ) async {
    final service = GagakuSyncService.withMetadata(MemorySyncMetadataStore());
    await _pump(tester, service);

    expect(find.text('Database Sync'), findsOneWidget);
    expect(find.text('Disabled'), findsWidgets);
    expect(find.text('Create New Profile'), findsOneWidget);
    expect(find.text('Join Existing Profile'), findsOneWidget);
    expect(find.text('Delete Remote Profile'), findsNothing);
  });

  testWidgets('configured state exposes status and confirmed disable', (
    tester,
  ) async {
    final metadata = MemorySyncMetadataStore(
      SyncLocalState(
        enabled: true,
        locator: '/synthetic/filesystem/profile',
        profileId: 'profile-fixture',
        deviceId: 'device-fixture',
        deviceName: 'Fictional Device',
        dirtyGeneration: 3,
        lastPublishedGeneration: 2,
        retryPending: true,
        lastError: 'synthetic unavailable',
      ),
    );
    final service = GagakuSyncService.withMetadata(metadata);
    await _pump(tester, service);

    expect(find.text('Sync Status'), findsOneWidget);
    expect(
      find.text('Fictional Device\nDevice: device-fixture'),
      findsOneWidget,
    );
    expect(find.text('Retry Now'), findsOneWidget);
    expect(find.text('Known Devices'), findsOneWidget);
    expect(find.text('Repair / Clean Remote Files'), findsOneWidget);
    expect(find.text('Delete Remote Profile'), findsOneWidget);

    await tester.ensureVisible(find.text('Disable Sync'));
    await tester.pump();
    await tester.tap(find.text('Disable Sync'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(
      find.text(
        'Disable synchronization on this device without deleting remote data?',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Yes'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(metadata.state.enabled, isFalse);
    expect(metadata.state.profileId, 'profile-fixture');
    expect(metadata.state.deviceId, 'device-fixture');
    expect(find.text('Resume Sync'), findsOneWidget);
    expect(find.text('Forget Sync Configuration'), findsOneWidget);
    expect(find.text('Create New Profile'), findsNothing);
    expect(find.text('Join Existing Profile'), findsNothing);
  });

  testWidgets('device name dialog survives cancel and save transitions', (
    tester,
  ) async {
    final metadata = MemorySyncMetadataStore(
      SyncLocalState(
        enabled: true,
        locator: '/synthetic/filesystem/profile',
        profileId: 'profile-fixture',
        deviceId: 'device-fixture',
        deviceName: 'Fictional Device',
      ),
    );
    final service = GagakuSyncService.withMetadata(metadata);
    await _pump(tester, service);

    final deviceTile = find.text('Fictional Device\nDevice: device-fixture');
    await tester.ensureVisible(deviceTile);
    await tester.tap(deviceTile);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Cancel'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);

    await tester.tap(deviceTile);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.enterText(find.byType(TextFormField), 'Renamed Fixture');
    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(tester.takeException(), isNull);
    expect(metadata.state.deviceName, 'Renamed Fixture');
    expect(
      find.text('Renamed Fixture\nDevice: device-fixture'),
      findsOneWidget,
    );
  });
}

Future<void> _pump(WidgetTester tester, GagakuSyncService service) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SyncSettingsSection(service: service),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}
