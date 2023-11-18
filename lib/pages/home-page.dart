// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vidlearn/components/post_item.dart';
import 'package:vidlearn/styles/app_colors.dart';
import 'package:vidlearn/styles/app_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text('Vidlearn'),
          centerTitle: false,
          actions: [
            Icon(Icons.location_on_outlined),
            Icon(Icons.add_alert),
            Icon(Icons.settings),
            Icon(Icons.reorder_outlined),
            Icon(Icons.more_vert_outlined),
            Icon(Icons.camera_outlined),
          ],
        ),
        body: ListView(
          children: mockUsersFromServer(),
        ));
  }

  List<Widget> mockUsersFromServer() {
    List<Widget> users = [];
    for (var i = 0; i < 200; i++) {
      users.add(PostItem());
    }
    return users;
  }
}
