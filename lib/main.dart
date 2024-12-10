import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yemek_soyle_app/app/core/theme/light_theme.dart';
import 'package:yemek_soyle_app/app/ui/cubit/cart_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favorites_page_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/home_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/login_page/login_view.dart';
import 'package:yemek_soyle_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => CartPageCubit(),
        ),
        BlocProvider(
          create: (context) => FavoritesPageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('en', ''), Locale('tr', '')],
        title: 'Yemek Soyle',
        theme: lightTheme,
        home: LoginView(),
      ),
    );
  }
}
