import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vidlearn/components/toolbar.dart';
import 'package:vidlearn/styles/app_text.dart';

enum ProfileMenu { edit, logout }

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: 'Profile',
        actions: [
          PopupMenuButton<ProfileMenu>(
            onSelected: (value) {
              switch (value) {
                case ProfileMenu.edit:
                  print('Edit');
                  break;
                case ProfileMenu.logout:
                  print('Logout');
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      Text('Edit'),
                    ],
                  ),
                  value: ProfileMenu.edit,
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.logout_outlined),
                      Text('Log out'),
                    ],
                  ),
                  value: ProfileMenu.logout,
                ),
                // PopupMenuItem(child: Text('Edit')),
                // PopupMenuItem(child: Text('Edit')),
              ];
            },
          )
          // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child:
                Image.asset('assets/temp/profile.jpg', width: 90, height: 90),
          ),
          SizedBox(
            height: 24,
          ),
          Text('Sonelf San', style: AppText.header2),
          SizedBox(
            height: 12,
          ),
          Text('Quebec', style: AppText.subtitle3),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '472',
                    style: AppText.header2,
                  ),
                  Text('Followers')
                ],
              ),
              Column(
                children: [
                  Text(
                    '119',
                    style: AppText.header2,
                  ),
                  Text('Posts')
                ],
              ),
              Column(
                children: [
                  Text(
                    '87',
                    style: AppText.header2,
                  ),
                  Text('Following')
                ],
              )
            ],
          ),
          Divider(
            thickness: 3,
            height: 24,
          ),
        ],
      ),
    );
  }
}
