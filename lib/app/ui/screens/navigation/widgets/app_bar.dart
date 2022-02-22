import 'package:astrotak/app/ui/screens/profile/profile.dart';
import 'package:astrotak/app/ui/theme/app_assets.dart';
import 'package:astrotak/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AstroAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AstroAppBar({
    Key? key,
    this.profile = false,
  }) : super(key: key);

  final bool profile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: InkWell(
        onTap: () {},
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: profile
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.chevron_left,
                  size: 36.0,
                  color: AppColors.primaryColor,
                ),
              )
            : Image.asset(
                AppAssets.menu,
                scale: 1.3,
              ),
      ),
      title: Image.asset(
        AppAssets.logo,
        height: 42.0,
      ),
      actions: [
        profile
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                ],
              )
            : InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Image.asset(
                  AppAssets.profile,
                  scale: 4.6,
                ),
              )
      ],
    );
  }

  Size get preferredSize => Size.fromHeight(55.0);
}
