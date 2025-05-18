import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/widget/back_button.dart';

class IntroAppbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String? titleText;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? textcolor;
  final PreferredSizeWidget? bottom;

  const IntroAppbar({
    super.key,
    this.actions,
    this.titleText,
    this.backgroundColor,
    this.textcolor,
    this.bottom,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: leading == null,
      leading: leading ?? MyBackButton(),
      centerTitle: true,
      foregroundColor: textcolor ?? Colors.black,
      backgroundColor: Colors.transparent,
      title: Text(
        titleText ?? '',
        style: const TextStyle(
          color: MyColors.mainColor,
          fontSize: 24,
        ),
      ),
      actions: actions,
      // bottom: bottom ?? const BottomBorderWidget(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
