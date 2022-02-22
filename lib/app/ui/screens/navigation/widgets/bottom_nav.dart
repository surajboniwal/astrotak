import 'package:astrotak/app/logic/navigation/navigation_cubit.dart';
import 'package:astrotak/app/ui/theme/app_assets.dart';
import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AstroBottomNavigation extends StatelessWidget {
  const AstroBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: state.index,
          onTap: (index) {
            context.read<NavigationCubit>().changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.home,
                height: 24.0,
                color: state.index == 0 ? AppColors.primaryColor : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.talk,
                height: 24.0,
                color: state.index == 1 ? AppColors.primaryColor : Colors.grey,
              ),
              label: 'Talk',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.ask,
                height: 24.0,
                color: state.index == 2 ? AppColors.primaryColor : Colors.grey,
              ),
              label: 'Ask Question',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.report,
                height: 24.0,
                color: state.index == 3 ? AppColors.primaryColor : Colors.grey,
              ),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.chat,
                height: 24.0,
                color: state.index == 4 ? AppColors.primaryColor : Colors.grey,
              ),
              label: 'Chat',
            ),
          ],
        );
      },
    );
  }
}
