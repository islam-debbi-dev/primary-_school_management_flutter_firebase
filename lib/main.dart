import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_chat/screens/Admin/LoginRequests.dart';
import 'package:for_chat/screens/Admin/MessagesForStdents.dart';
import 'package:for_chat/screens/Admin/SendToTeacher.dart';
import 'package:for_chat/screens/Admin/Studentpoints.dart';
import 'package:for_chat/screens/Admin/Studentpoints1.dart';
import 'package:for_chat/screens/Admin/Studentpoints2.dart';
import 'package:for_chat/screens/Admin/Update_Student.dart';
import 'package:for_chat/screens/Admin/addstudints.dart';
import 'package:for_chat/screens/Student/Profil_Student.dart';
import 'package:for_chat/screens/Student/StudentListClass.dart';
import 'package:for_chat/screens/Teacher/ListStudetTeacher.dart';
import 'package:for_chat/screens/Teacher/ListTeachersForTeachers.dart';
import 'package:for_chat/screens/Teacher/ProfileStudentTeacher.dart';
import 'package:for_chat/screens/Teacher/ProfileTeacherForTeacher.dart';
import 'package:for_chat/screens/Teacher/Profile_Teacher.dart';
import 'package:for_chat/screens/login.dart';
import 'package:for_chat/screens/Admin/home-admin.dart';
import 'screens/Teacher/home_teacher.dart';
import 'screens/Student/home_student.dart';
import 'screens/Admin/liststudents.dart';
import 'screens/Admin/addteacher.dart';
import 'screens/Admin/updateteacher.dart';
import 'screens/Admin/listteacher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your School',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: LoginPage.screenroute,
      routes: {
        LoginPage.screenroute: (context) => LoginPage(),
        homestudent.screenroute: (context) => const homestudent(),
        MyHomePage.screenroute: (context) => MyHomePage(),
        homeadmin.screenroute: (context) => const homeadmin(),
        hometeacher.screenroute: (context) => const hometeacher(),
        liststudents.screenroute: (context) => const liststudents(),
        UpdateStudentPage.screenroute: (context) => const UpdateStudentPage(
              studentId: '',
            ),
        addteacher.screenroute: (context) => addteacher(),
        listteachers.screenroute: (context) => const listteachers(),
        UpdateTeacherPage.screenroute: (context) => const UpdateTeacherPage(
              teacherId: '',
            ),
        ProfileTeacherPage.screenroute: (context) => const ProfileTeacherPage(
              profileId: '',
            ),
        ProfileStudentPage.screenroute: (context) => const ProfileStudentPage(
              ProfileStudentID: '',
            ),
        ListStudentTeacher.screenroute: (context) => const ListStudentTeacher(),
        ProfileStudentTeacher.screenroute: (context) =>
            const ProfileStudentTeacher(
              ProfileStudentTID: '',
            ),
        Studentpoints.screenroute: (context) => const Studentpoints(),
        Studentpoints1.screenroute: (context) => const Studentpoints1(
              ProfileStudentID: '',
            ),
        Studentpoints2.screenroute: (context) => const Studentpoints2(
              studentId: '',
            ),
        ListTeacherForTeacher.screenroute: (context) =>
            const ListTeacherForTeacher(),
        ProfileTeacherForTeacher.screenroute: (context) =>
            const ProfileTeacherForTeacher(
              profileTeacherId: '',
            ),
        MessagesForStudents.screenroute: (context) =>
            const MessagesForStudents(),
        SendToTeacher.screenroute: (context) => const SendToTeacher(),
        ListStudentsForStudednt.screenroute: (context) =>
            const ListStudentsForStudednt(),
        LoginRequests.screenroute: (context) => const LoginRequests(),
      },
    );
  }
}
