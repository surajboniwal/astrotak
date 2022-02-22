import 'package:astrotak/app/logic/navigation/navigation_cubit.dart';
import 'package:astrotak/app/ui/screens/navigation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sections/sections.dart';
import 'widgets/bottom_nav.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AstroAppBar(),
      bottomNavigationBar: AstroBottomNavigation(),
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: [
              HomeSection(),
              TalkSection(),
              AskSection(),
              ReportsSection(),
              ChatSection(),
            ],
          );
        },
      ),
    );
  }
}
