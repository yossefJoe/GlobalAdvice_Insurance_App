import 'package:flutter/material.dart';
import 'package:global_advice_new/core/resource_manger/color_manager.dart';
import 'package:global_advice_new/core/resource_manger/routs_manager.dart';
import 'package:global_advice_new/core/utils/config_size.dart';
import 'package:global_advice_new/core/utils/translation_provider.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'package:global_advice_new/core/resource_manger/asset_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: ConfigSize.defaultSize! * 5),
          Padding(
            padding: EdgeInsets.all(ConfigSize.defaultSize! * 2),
            child: Center(
              child: Container(
                height: ConfigSize.defaultSize! * 8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetsPath.logo),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: ConfigSize.defaultSize! * 2),
          DrawerTile(
            title: AppLocalizations.of(context)!.home,
            icon: Icons.home,
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
            },
          ),
          const MyDivider(),
          DrawerTile(
            title: AppLocalizations.of(context)!.plans,
            icon: Icons.home_repair_service_rounded,
            onTap: () {
              Navigator.of(context).pushNamed(Routes.plans);
            },
          ),
          // const MyDivider(),
          // DrawerTile(
          //   title: AppLocalizations.of(context)!.myProfile,
          //   icon: Icons.person,
          //   onTap: () {
          //     Navigator.of(context).pushNamed(Routes.profile);
          //   },
          // ),
          // const MyDivider(),
          // DrawerTile(
          //   title: AppLocalizations.of(context)!.editprofile,
          //   icon: Icons.edit,
          //   onTap: () {
          //     Navigator.of(context).pushNamed(Routes.editProfile);
          //   },
          // ),
          const MyDivider(),
          DrawerTile(
            title: AppLocalizations.of(context)!.share,
            icon: Icons.share,
            onTap: () {
              Share.share(
                  'Check out this awesome app! https://globaladvice.org/');
            },
          ),
          const MyDivider(),
          Consumer<TranslationProvider>(
            builder: (context, translate, child) {
              return DrawerTile(
                title: AppLocalizations.of(context)!.translation,
                icon: Icons.translate,
                onTap: () {
                  translate.change_language();
                },
              );
            },
          ),
          const MyDivider(),
          Consumer<TranslationProvider>(
            builder: (context, logout, child) {
              return DrawerTile(
                title: AppLocalizations.of(context)!.logOut,
                icon: Icons.exit_to_app,
                onTap: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(Routes.login, (route) => false);
                  logout.logout();
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key, required this.title, required this.icon, this.onTap});
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ConfigSize.defaultSize! * 0.5,
          bottom: ConfigSize.defaultSize! * 0.5),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          size: ConfigSize.defaultSize! * 3,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 2,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorManager.mainColor,
      height: ConfigSize.defaultSize! * 0.5,
      thickness: ConfigSize.defaultSize! * 0.125,
      endIndent: ConfigSize.defaultSize! * 3,
      indent: ConfigSize.defaultSize! * 3,
    );
  }
}
