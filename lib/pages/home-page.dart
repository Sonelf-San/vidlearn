import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vidlearn/components/post_item.dart';
import 'package:vidlearn/components/toolbar.dart';
import 'package:vidlearn/styles/app_colors.dart';
import 'package:vidlearn/styles/app_text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List<String> users = [];

  @override
  Widget build(BuildContext context) {
    mockUsersFromServer();
    return Scaffold(
      appBar: Toolbar(
        title: 'Vidlearn',
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_none_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu_outlined)),
          // SvgPicture.asset('assets/svg/'),
          // Icon(Icons.notifications_none_outlined),
          // Icon(Icons.menu_outlined),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return PostItem(
            user: users[index],
          );
        },
        itemCount: users.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 24,
          );
        },
      ),
      // ListView.separated(
      //   itemBuilder: (context, index) {
      //     return PostItem(
      //       user: users[index],
      //     );
      //   },
      //   itemCount: users.length,
      //   separatorBuilder: (BuildContext context, int index) {
      //     return SizedBox(
      //       height: 24,
      //     );
      //   },
      //   // children: mockUsersFromServer(),
      // ),
    );
  }

  mockUsersFromServer() {
    // List<Widget> users = [];
    for (var i = 0; i < 200; i++) {
      users.add('User number $i');
    }
    // return users;
  }
}



















// // import 'dart:js';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:vidlearn/components/post_item.dart';
// import 'package:vidlearn/components/toolbar.dart';
// import 'package:vidlearn/styles/app_colors.dart';
// import 'package:vidlearn/styles/app_text.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: Toolbar(
//           title: 'Vidlearn',
//           actions: [
//             Icon(Icons.notifications_none_outlined),
//             Icon(Icons.menu_outlined),
//           ],
//           // AppBar(
//           // backgroundColor: AppColors.background,
//           // title: Text('Vidlearn'),
//           // centerTitle: false,
//           // actions: [
//           //   // Icon(Icons.location_on_outlined),
//           //   Icon(Icons.notifications_none_outlined),
//           //   Icon(Icons.menu_outlined),
//           //   // Icon(Icons.menu_rounded),
//           //   // Icon(Icons.menu_sharp)
//           // ],
//         ),
//         body: ListView(
//           children: mockUsersFromServer(),
//         ));
//   }

//   List<Widget> mockUsersFromServer() {
//     List<Widget> users = [];
//     for (var i = 0; i < 200; i++) {
//       users.add(PostItem());
//     }
//     return users;
//   }
// }
