import 'package:bloc/bloc.dart';
import 'package:film_app/check_internet/internet_cubit/check_internet_cubit.dart';
import 'package:film_app/localization/lang_cubit/lang_cubit.dart';
import 'package:film_app/localization/lang_cubit/lang_states.dart';
import 'package:film_app/movies/presentation/screens/wiredash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'check_internet/internet_cubit/check_internet_states.dart';
import 'core/services/service_locator.dart';
import 'localization/app_localization.dart';
import 'localization/languages.dart';
import 'movies/domain/entities/movie.dart';
import 'movies/presentation/screens/movie_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = MyBlocObserver();
  ServiceLocator().init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final navigatorKey=GlobalKey<NavigatorState>();
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanaguageCubit()..getSavedLanguage(),
        ),
         BlocProvider(
          create: (context) =>CheckInternetCubit()..checkInternet(),
        ),
      ],
      child: BlocBuilder<LanaguageCubit, LanguagesStates>(
        builder: (context, state) {
          if (state is ChangeLanguageState) {
            return WiredashApp(
              navigatorKey: navigatorKey,
              child: MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: Colors.grey.shade900,
                ),
                supportedLocales:
                    Languages.languages.map((e) => Locale(e.code)).toList(),
                //locale: Locale(Languages.languages[0].code),
                locale: state.locale,
                localizationsDelegates: [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                ],
                home: BlocListener<CheckInternetCubit,CheckInternetState>(
                  listener: (context, state) {
                     if(state is InternetNotConnectedState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor:Colors.red ,
                    ),
                  );
                }
                else if(state is InternetConnectedState){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor:Colors.green ,
                    ),
                  );
                }
                  },
                  child: MovieScreen(),
                  ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
