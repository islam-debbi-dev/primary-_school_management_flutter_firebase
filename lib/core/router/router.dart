import 'package:flutter/material.dart';
import 'package:for_chat/core/config/test_firebse.dart';

import '../../features/Student/presentation/StudentListClass.dart';
import '../../features/Student/presentation/home_student.dart';
import '../../features/Teacher/presentation/home_teacher.dart';
import '../../features/auth/login/presentation/login.dart';
import 'constants_route.dart';
import '../../features/admin/presentation/home_admin.dart';
import '../../features/admin/presentation/list_students.dart';
import '../../features/admin/presentation/update_student.dart';
import '../../features/admin/presentation/add_teacher.dart';
import '../../features/admin/presentation/listteacher.dart';
import '../../features/admin/presentation/updateteacher.dart';
import '../../features/teacher/presentation/profile_teacher.dart';
import '../../features/student/presentation/profile_student.dart';
import '../../features/teacher/presentation/list_student_teacher.dart';
import '../../features/teacher/presentation/profile_student_teacher.dart';
import '../../features/teacher/presentation/list_teacher_for_teacher.dart';
import '../../features/teacher/presentation/profile_teacher_for_teacher.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    MaterialPageRoute buildSimpleRoute(Widget child) {
      return MaterialPageRoute(settings: settings, builder: (_) => child);
    }

    MaterialPageRoute errorRoute(String? routeName) {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Text(
                'Route Error: No route defined for $routeName or invalid arguments.'),
          ),
        ),
      );
    }

    switch (settings.name) {
      case testfirabsepage:
        return buildSimpleRoute(const TestFireBase());
      case loginRoute:
        return buildSimpleRoute(LoginPage());

      case homeAdminRoute:
        final firstName = settings.arguments;
        final email = settings.arguments;
        return buildSimpleRoute(HomeAdmin(
          firstnameargu: firstName.toString(),
          email: email.toString(),
        ));
      case adminListStudentsRoute:
        return buildSimpleRoute(ListStudents());
      case adminAddTeacherRoute:
        return buildSimpleRoute(AddTeacher());
      case adminListTeachersRoute:
        return buildSimpleRoute(const ListTeachers());
      case adminUpdateTeacherRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('teacherId')) {
          final teacherId = arguments['teacherId'] as String;

          return buildSimpleRoute(UpdateTeacherPage(teacherId: teacherId));
        }
        return errorRoute(settings.name);

      case adminUpdateStudentRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('studentId')) {
          final studentId = arguments['studentId'] as String;

          return buildSimpleRoute(UpdateStudentPage(studentId: studentId));
        }
        return errorRoute(settings.name);

      case homeTeacherRoute:
        final firstName = settings.arguments;
        final email = settings.arguments;
        return buildSimpleRoute(HomeTeacher(
          firstnameargu: firstName.toString(),
          email: email.toString(),
        ));
      case teacherListStudentsRoute:
        return buildSimpleRoute(const ListStudentTeacher());
      case teacherProfileStudentRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('ProfileStudentTID')) {
          final profileStudentTID = arguments['ProfileStudentTID'] as String;

          return buildSimpleRoute(
              ProfileStudentTeacher(ProfileStudentTID: profileStudentTID));
        }
        return errorRoute(settings.name);
      case teacherListTeachersRoute:
        return buildSimpleRoute(const ListTeacherForTeacher());
      case teacherProfileTeacherRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('profileTeacherId')) {
          final profileTeacherId = arguments['profileTeacherId'] as String;

          return buildSimpleRoute(
              ProfileTeacherForTeacher(profileTeacherId: profileTeacherId));
        }
        return errorRoute(settings.name);
      case profileTeacherRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('profileId')) {
          final profileId = arguments['profileId'] as String;

          return buildSimpleRoute(ProfileTeacherPage(profileId: profileId));
        }
        return errorRoute(settings.name);

      case homeStudentRoute:
        final firstName = settings.arguments;
        final email = settings.arguments;
        return buildSimpleRoute(HomeStudent(
          firstnameargu: firstName.toString(),
          email: email.toString(),
        ));
      case studentProfileRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('ProfileStudentID')) {
          final profileStudentID = arguments['ProfileStudentID'] as String;

          return buildSimpleRoute(
              ProfileStudentPage(ProfileStudentID: profileStudentID));
        }
        return errorRoute(settings.name);
      case studentListStudentsRoute:
        return buildSimpleRoute(const Studentlistclass());

      default:
        return errorRoute(settings.name);
    }
  }
}
