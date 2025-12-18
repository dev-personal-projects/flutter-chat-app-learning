import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/pages/splash_page.dart';
import 'package:chatapp/services/auth/auth_provider.dart';
import 'package:chatapp/utils/app_routes.dart';
import 'package:chatapp/utils/theme_config.dart';
import 'package:chatapp/utils/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
            title: 'WhatsApp Clone',
            theme: ThemeConfig.lightTheme,
            darkTheme: ThemeConfig.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const SplashPage(),
            routes: AppRoutes.getRoutes(),
          );
        },
      ),
    );
  }
}
