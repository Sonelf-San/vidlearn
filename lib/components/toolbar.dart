import 'package:flutter/material.dart';
import 'package:vidlearn/styles/app_colors.dart';
import 'package:vidlearn/styles/app_text.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const Toolbar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      title: Text(title, style: AppText.header1),
      centerTitle: false,
      actions: actions,
    );
  }

  @override
// TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
