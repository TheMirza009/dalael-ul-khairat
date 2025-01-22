import 'package:dalael_ul_kahirat/core/theme/theme_constants.dart';
import 'package:dalael_ul_kahirat/core/theme/theme_provider_class.dart';
import 'package:dalael_ul_kahirat/root/Presentation/Screens/pdfview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeConstants.screenWidth = MediaQuery.sizeOf(context).width;
    ThemeConstants.screenHeight = MediaQuery.sizeOf(context).height;
    return Consumer(
      builder: (context, ref, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: ref.watch(themeProvider), // Riverpod Theme
            theme: ThemeConstants.lightTheme,
            darkTheme: ThemeConstants.darkTheme,
          home: PDFScreen(),
        );
      }
    );
  }
}

