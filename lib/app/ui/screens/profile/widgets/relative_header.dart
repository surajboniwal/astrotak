import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Name',
            style: TextStyle(
              fontSize: 13.0,
              color: AppColors.blue,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'DOB',
            style: TextStyle(
              fontSize: 13.0,
              color: AppColors.blue,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'TOB',
            style: TextStyle(
              fontSize: 13.0,
              color: AppColors.blue,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Relation',
            style: TextStyle(
              fontSize: 13.0,
              color: AppColors.blue,
            ),
          ),
        ),
        Expanded(child: SizedBox()),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
