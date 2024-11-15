import 'dart:io';


import 'package:Dhikrs/controllers/providers/AllahNamesProvider.dart';
import 'package:Dhikrs/controllers/providers/CustomAddProvider.dart';
import 'package:Dhikrs/controllers/providers/DhikrProvider.dart';
import 'package:Dhikrs/controllers/providers/TimerProvider.dart';
import 'package:Dhikrs/controllers/providers/UserSavedProvider.dart';
import 'package:Dhikrs/views/screens/HomeScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'data/ListOfAllName.dart';
import 'data/MostCommonDhikrs.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    await localNotifier.setup(
      appName: 'Dhikrs',
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
    WindowManager.instance.setMinimumSize(const Size(1024, 768));
  }

  if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    launchAtStartup.setup(
        appName: packageInfo.appName,
        appPath: Platform.resolvedExecutable,
        packageName: 'dev.leanflutter.examples.launchatstartupexample',
        args: <String>['--minimized']);

    // await TrayManager.instance.setIcon("Assets/Images/dhikrs Logo.ico");
    await launchAtStartup.enable();
    // await launchAtStartup.disable();
  }

  if (Platform.isAndroid || Platform.isIOS) {
    // Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
    // Workmanager().registerOneOffTask("1", "simpleTask");
    // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
    // _startBackgroundFetch();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsDarwin =
    const DarwinInitializationSettings();

    const LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open');

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux,
        macOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // _requestPermissions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomAddProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
        ChangeNotifierProvider(create: (_) => AllahNamesProvider(allahNames)),
        ChangeNotifierProvider(create: (_) => DhikrProvider(mostCommonDhikr)),
        ChangeNotifierProvider(create: (_) => UserSaveDuaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
