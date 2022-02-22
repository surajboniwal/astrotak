import 'package:astrotak/app/logic/navigation/navigation_cubit.dart';
import 'package:astrotak/app/ui/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/theme/app_theme.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class AstroTak extends StatelessWidget {
  const AstroTak({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(),
      child: MaterialApp(
        title: 'AstroTak',
        navigatorKey: navigationKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const NavigationScreen(),
      ),
    );
  }
}
