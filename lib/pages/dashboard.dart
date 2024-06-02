import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'package:vidlearn/pages/course_detail.dart';
import 'package:vidlearn/styles/app_colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatelessWidget {
  // const Dashboard({super.key});
  var height, width;

  List imgData = [
    'assets/images/courses/resMet.png',
    'assets/images/courses/reinLe.png',
    'assets/images/courses/artInt.png',
    'assets/images/courses/softSec.png',
    'assets/images/courses/r-lang.png',
    'assets/images/courses/nlp.png',
    'assets/images/courses/databaseimg.png',
    'assets/images/courses/plus-60.png',
  ];

  List titles = [
    'IFT-6001',
    'IFT-7201',
    'GLO-7001',
    'GLO-7009',
    'IFT-7902',
    'IFT-7022',
    'GLO-7035',
    'More',
  ];

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: AppColors.background,
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
              ),
              height: height * 0.25,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 35,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.sort,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications_none_outlined)),
                        // IconButton(
                        //     onPressed: () {}, icon: Icon(Icons.menu_outlined)),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/temp/profile.jpg'))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                    ),
                    child: Column(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'Join the ongoing video call...',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.greenAccent,
                        //     fontWeight: FontWeight.w500,
                        //     letterSpacing: 1,
                        //   ),
                        // )
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
                  // bottomLeft: Radius.circular(30),
                  // bottomRight: Radius.circular(30),
                ),
              ),
              height: height * 0.05,
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
                  )
                ],
              ),
            ),
            Divider(
              thickness: 3,
              height: 2,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(30),
                    // topRight: Radius.circular(30),
                    // bottomLeft: Radius.circular(30),
                    // bottomRight: Radius.circular(30),
                    ),
              ),
              height: height * 0.3,
              width: width,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 25,
                ),
                // crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: imgData.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //Passing data to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CourseDetail(title: titles[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            imgData[index],
                            width: 40,
                          ),
                          Text(
                            titles[index],
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
            Divider(
              thickness: 3,
              height: 2,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                    // bottomLeft: Radius.circular(30),
                    // bottomRight: Radius.circular(30),
                    ),
              ),
              height: height * 0.31,
              width: width,
              child: TableCalendar(
                  locale: 'en_US',
                  rowHeight: 43,
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  focusedDay: today,
                  firstDay: DateTime.utc(1900, 01, 01),
                  lastDay: DateTime.utc(2035, 01, 01)),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              height: height * 0.085,
              width: width,
              // child: ,
            )
          ],
        ),
      ),
    );
  }
}

class CourseDetail extends StatelessWidget {
  final String title;
  final List<String> chapters = [
    'Chapter 1',
    'Chapter 2',
    'Chapter 3',
    'Chapter 4',
    'Chapter 5',
  ];

  CourseDetail({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
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

class ChapterDetail extends StatelessWidget {
  final String chapterTitle;

  ChapterDetail({required this.chapterTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapterTitle),
      ),
      body: Center(
        child: Text(
          'Details for $chapterTitle',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
