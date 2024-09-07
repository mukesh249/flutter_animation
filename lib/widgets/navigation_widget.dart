import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';

class NavigationWidget extends StatelessWidget {
  const NavigationWidget({
    super.key,
    required this.theme,
    required this.atBottom,
    required this.unSelectedItemColor,
  });

  final ThemeData theme;
  final bool atBottom;
  final Color unSelectedItemColor;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      onChangePage: (c) {},
      curve: Curves.fastEaseInToSlowEaseOut,
      durationAnimation: const Duration(milliseconds: 400),
      backgroundColor: theme.scaffoldBackgroundColor,
      /*borderTopColor: Theme.of(context).brightness == Brightness.light
          ? atBottom
          ? theme.primaryColor
          : null
          : null,*/
      color: theme.primaryColor,
      items: [
        ItemNavigationView(
            childAfter: Icon(
              Icons.person,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              Icons.person,
              color: unSelectedItemColor,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.setting,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.setting,
              color: unSelectedItemColor,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.buy,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.buy,
              color: unSelectedItemColor,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.category,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.category,
              color: unSelectedItemColor,
              size: 30,
            )),
        ItemNavigationView(
            childAfter: Icon(
              IconlyBold.home,
              color: theme.primaryColor,
              size: 35,
            ),
            childBefore: Icon(
              IconlyBroken.home,
              color: unSelectedItemColor,
              size: 30,
            )),
      ],
    );
  }
}