import 'package:consumernetworks/dashboard_provider.dart';
import 'package:consumernetworks/onboarding_screen.dart';
import 'package:consumernetworks/openwebview.dart';
import 'package:consumernetworks/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DashboardProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // callInitFunction();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    provider.callInitFunction();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consumers  Networks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: provider.isIntro ? const OnBoardingScreen() : const OpenWebView(),
      builder: EasyLoading.init(),
    );
  }
}
