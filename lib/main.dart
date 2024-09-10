import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_soyle_app/app/core/constants/color.dart';
import 'package:yemek_soyle_app/app/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/favori_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_soyle_app/app/ui/views/main_tab_view.dart';

void main() async {
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
          create: (context) => AnasayfaCubit(),
        ),
        BlocProvider(
          create: (context) => SepetSayfaCubit(),
        ),
        BlocProvider(
          create: (context) => FavorilerSayfaCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YemekSoyle',
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: AppColor.whiteColor,
              iconColor: AppColor.whiteColor,
            )),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColor.whiteColor,
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            )),
        home: MainPage(),
      ),
    );
  }
}
