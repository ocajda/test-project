import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/pages/tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,         // color bottom grabber in newer devices
    systemNavigationBarDividerColor: Colors.transparent,  // line between screen and bottom nav bar
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
  ));

  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData themeData = ThemeData(
    primaryColor: Colors.black,    
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TabsPage(),
      theme: themeData,
    );
  }
}