import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:vidlearn/pages/profile-page.dart';
import 'package:vidlearn/styles/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:vidlearn/services/api_service.dart';
import 'package:http_parser/http_parser.dart';
// Dashboard page

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var height, width;
  List courses = [];
  DateTime today = DateTime.now();
  final ApiService apiService = ApiService();
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      final data = await apiService.fetchCourses();
      setState(() {
        courses = data['courses'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.background,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Handle navigation to Settings page
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Vidlearn',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Text(
              'University name',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 10,
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Container(
                  color: AppColors.background,
                  height: height,
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                        ),
                        height: height * 0.1,
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        height: height * 0.08,
                        width: width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 17,
                            ),
                            Text(
                              'Join the ongoing video call...',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 12,
                                color: AppColors.notification,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 2,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            color: Colors.white,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.1,
                                mainAxisSpacing: 25,
                              ),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: courses.length,
                              itemBuilder: (context, index) {
                                int courseId =
                                    courses[index]['id']; // Get the course ID
                                String imageUrl = courses[index]['logo_url'] ??
                                    'assets/images/courses/empty-course-img.png';
                                String title =
                                    courses[index]['title'] ?? 'No title';
                                String category = courses[index]
                                        ['category_name'] ??
                                    'No category';

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CourseDetail(
                                          title: category + ': ' + title,
                                          courseId:
                                              courseId, // Pass the course ID
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.network(
                                          imageUrl,
                                          width: 40,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.error);
                                          },
                                        ),
                                        Text(
                                          category,
                                          style: TextStyle(
                                            fontSize: 9.5,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 1,
                      ),
                      Container(
                        height: height * 0.38,
                        width: width,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: TableCalendar(
                          locale: 'en_US',
                          rowHeight: 43,
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekendStyle: TextStyle(color: Colors.orange),
                          ),
                          calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            selectedTextStyle: TextStyle(color: Colors.black),
                            defaultTextStyle: TextStyle(color: Colors.white),
                          ),
                          availableGestures: AvailableGestures.all,
                          focusedDay: today,
                          firstDay: DateTime.utc(1900, 01, 01),
                          lastDay: DateTime.utc(2035, 01, 01),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

// Page for course details providing all course chapters
class CourseDetail extends StatelessWidget {
  final String title;
  final int courseId; // Add courseId parameter
  final List<String> chapters = [
    'Chapter 1',
    'Chapter 2',
    'Chapter 3',
    'Chapter 4',
    'Chapter 5',
  ];

  CourseDetail({required this.title, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return Padding(
            // padding: const EdgeInsets.all(8.0),
            padding: EdgeInsets.only(
              top: 50,
              left: 15,
              right: 15,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Center(
                  child: Text(
                    chapters[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChapterDetail(
                        chapterTitle: chapters[index],
                        courseId: courseId, // Pass the course ID
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Chapter detail page
class ChapterDetail extends StatelessWidget {
  final String chapterTitle;
  final int courseId; // Add courseId parameter

  ChapterDetail({required this.chapterTitle, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(chapterTitle),
      ),
      body: ChatUI(courseId: courseId), // Pass the courseId to ChatUI
    );
  }
}

// Content page

class ChatUI extends StatefulWidget {
  final int courseId;

  ChatUI({required this.courseId});

  @override
  _ChatUIState createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  TextEditingController _messageController = TextEditingController();
  List<dynamic> _comments = [];
  List<dynamic> _videos = [];
  String? _uploadedFilePath;
  VideoPlayerController? _videoPlayerController;
  final ApiService apiService = ApiService();
  Map<String, dynamic>? courseDetails;
  bool isLoading = true;
  String errorMessage = '';
  // Variable to toggle desciption
  bool _showFullDescription = false;

  @override
  void initState() {
    super.initState();
    _fetchCourseDetails();
  }

  Future<void> _fetchCourseDetails() async {
    try {
      final details = await apiService.getCourseDetails(widget.courseId);
      setState(() {
        courseDetails = details['course'];
        _videos = details['videos'];
        _comments = details['courseComments'];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null && result.files.single.path != null) {
      print('Picked file path: ${result.files.single.path}'); // Debugging
      setState(() {
        _uploadedFilePath = result.files.single.path;
        _initializeVideoPlayer();
      });
    }
  }

  void _initializeVideoPlayer() {
    if (_uploadedFilePath != null) {
      _videoPlayerController =
          VideoPlayerController.file(File(_uploadedFilePath!))
            ..initialize().then((_) {
              setState(() {});
              _videoPlayerController!.play();
            }).catchError((error) {
              print('Video initialization error: $error');
            });
    }
  }

  Future<void> _uploadVideo() async {
    if (_uploadedFilePath != null) {
      try {
        File videoFile = File(_uploadedFilePath!);
        final response = await apiService.uploadVideo(
          widget.courseId,
          videoFile,
          'Sample Video', // Add appropriate video name
          'Sample description', // Add appropriate video description
        );
        setState(() {
          _videos.add(response['video']); // Add the uploaded video to the list
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Video uploaded successfully awaiting for validation!',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );
        print('Video uploaded: ${response['message']}');
      } catch (e) {
        print('Failed to upload video: $e');
      }
    } else {
      print('No video selected');
    }
  }

  Future<void> _uploadComment() async {
    if (_messageController.text.isNotEmpty) {
      try {
        final response = await apiService.uploadComment(
          widget.courseId,
          _messageController.text,
        );
        setState(() {
          _comments.add(response['comment']);
          _messageController.clear();
        });
        print('Comment uploaded: ${response['message']}');
      } catch (e) {
        print('Failed to upload comment: $e');
      }
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      _uploadComment();
    }
  }

  String formatDateTime(String dateTime) {
    final DateTime parsedDateTime = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(parsedDateTime);
  }

  // Method to truncate HTML content
  String _truncateHtml(String htmlContent, int limit) {
    return htmlContent.length > limit
        ? htmlContent.substring(0, limit) + '...'
        : htmlContent;
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (courseDetails != null)
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          children: [
                            Html(
                              // Updated to use the Html widget from flutter_html package
                              data: _showFullDescription
                                  ? courseDetails!['description'] ??
                                      'No description available'
                                  : _truncateHtml(
                                      courseDetails!['description'] ??
                                          'No description available',
                                      100), // Limit to 100 characters
                              style: {
                                "body": Style(
                                  fontSize: FontSize(16),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              },
                            ),
                            // Added GestureDetector to toggle between truncated and full content
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showFullDescription = !_showFullDescription;
                                });
                              },
                              child: Text(
                                _showFullDescription ? 'less' : 'more',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_videos.isNotEmpty)
                      ..._videos.map((video) {
                        final videoUrl = video['video'];
                        print('Video URL: $videoUrl');
                        VideoPlayerController controller = VideoPlayerController
                            .networkUrl(Uri.parse(videoUrl))
                          ..initialize().then((_) {
                            setState(() {});
                          }).catchError((error) {
                            print('Video initialization error: $error');
                          });
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(video['name'] ?? 'No title',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              controller.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio: controller.value.aspectRatio,
                                      child: VideoPlayer(controller),
                                    )
                                  : Container(
                                      height: 200,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                            ],
                          ),
                        );
                      }).toList(),
                    if (_comments.isNotEmpty)
                      ..._comments.map((comment) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .end, // Align comments to the right
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .blueAccent, // Background color for chat bubble
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Rounded corners
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment['content'] ?? 'No content',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      formatDateTime(
                                          comment['created_at'] ?? ''),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    if (_uploadedFilePath != null &&
                        _videoPlayerController != null &&
                        _videoPlayerController!.value.isInitialized)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 400,
                          height: 350,
                          child: AspectRatio(
                            aspectRatio:
                                _videoPlayerController!.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController!),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[800],
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Type your comment',
                      // prefixIcon: IconButton(
                      //   icon: Icon(Icons.attach_file_outlined),
                      //   onPressed: _pickFile,
                      // ),
                      hintText: 'Type your comment',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send_outlined),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.upload_file),
                  onPressed: () async {
                    await _pickFile();
                    await _uploadVideo();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
