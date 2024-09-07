import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:navigation_view/item_navigation_view.dart';
import 'package:navigation_view/navigation_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/navigation_widget.dart';
import '../../widgets/shimmer_list_item.dart';

class BottomNavA extends StatelessWidget {
  BottomNavA({super.key});

  final bool _isShimmerActive = true;
   bool atBottom = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    const Color unSelectedItemColor = Color(0x56260681);
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationWidget(theme: theme, atBottom: atBottom, unSelectedItemColor: unSelectedItemColor),
      body: SizedBox.expand(
        child: Stack(children: [
          Positioned.fill(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return ShimmerListItem(
                      isShimmerActive: _isShimmerActive,
                    );
                  }))
        ]),
      ),
    );
  }
}


