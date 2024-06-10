import 'package:flutter/material.dart';
import 'package:vidlearn/components/toolbar.dart';
import 'package:vidlearn/services/api_service.dart';
import 'package:vidlearn/styles/app_text.dart';

enum ProfileMenu { edit, logout }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? studentProfile;

  @override
  void initState() {
    super.initState();
    _fetchStudentDetails();
  }

  Future<void> _fetchStudentDetails() async {
    try {
      final profile = await apiService.getStudentDetails();
      setState(() {
        studentProfile = profile['student-info'];
      });
    } catch (e) {
      print('Failed to fetch student details: $e');
    }
  }

  void _logout() async {
    try {
      String? errorMessage = await apiService.logout();
      if (errorMessage == null) {
        Navigator.of(context)
            .pushReplacementNamed('/'); //Redirecting to loging upon logout
      } else {
        _showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      print('Failed to logout: $e');
      _showErrorDialog(context, 'An error occurred. Please try again.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
                  _logout();
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
                      Text('  Edit'),
                    ],
                  ),
                  value: ProfileMenu.edit,
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.logout_outlined),
                      Text('  Log out'),
                    ],
                  ),
                  value: ProfileMenu.logout,
                ),
              ];
            },
          )
        ],
      ),
      body: studentProfile == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: studentProfile!['profile_picture_url'] != null
                      ? Image.network(
                          studentProfile!['profile_picture_url'] as String,
                          width: 90,
                          height: 90,
                        )
                      : Image.asset(
                          'assets/temp/profile.jpg',
                          width: 90,
                          height: 90,
                        ),
                ),
                SizedBox(height: 24),
                Text(studentProfile!['name'] ?? 'Name', style: AppText.header2),
                SizedBox(height: 12),
                Text(studentProfile!['location'] ?? 'Location',
                    style: AppText.subtitle3),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('472', style: AppText.header2),
                        Text('Followers')
                      ],
                    ),
                    Column(
                      children: [
                        Text('119', style: AppText.header2),
                        Text('Posts')
                      ],
                    ),
                    Column(
                      children: [
                        Text('87', style: AppText.header2),
                        Text('Following')
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 3, height: 24),
              ],
            ),
    );
  }
}
