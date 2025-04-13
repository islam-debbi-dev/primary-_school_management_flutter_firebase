import 'package:flutter/material.dart';
import 'package:for_chat/core/config/test_firebse.dart';

// Import Route Constants
import '../../features/Student/presentation/StudentListClass.dart';
import '../../features/Student/presentation/home_student.dart';
import '../../features/Teacher/presentation/home_teacher.dart';
import '../../features/auth/login/presentation/login.dart';
import 'constants_route.dart';
import '../../features/admin/presentation/home_admin.dart'; // Assuming path for Homeadmin
import '../../features/admin/presentation/list_students.dart'; // Assuming path for liststudents
import '../../features/admin/presentation/update_student.dart'; // Assuming path for UpdateStudentPage
import '../../features/admin/presentation/add_teacher.dart'; // Assuming path for addteacher
import '../../features/admin/presentation/listteacher.dart'; // Assuming path for listteachers
import '../../features/admin/presentation/updateteacher.dart'; // Assuming path for UpdateTeacherPage
import '../../features/teacher/presentation/profile_teacher.dart'; // Assuming path for ProfileTeacherPage
import '../../features/student/presentation/profile_student.dart'; // Assuming path for ProfileStudentPage
import '../../features/teacher/presentation/list_student_teacher.dart'; // Assuming path for ListStudentTeacher
import '../../features/teacher/presentation/profile_student_teacher.dart'; // Assuming path for ProfileStudentTeacher
import '../../features/teacher/presentation/list_teacher_for_teacher.dart'; // Assuming path for ListTeacherForTeacher
import '../../features/teacher/presentation/profile_teacher_for_teacher.dart'; // Assuming path for ProfileTeacherForTeacher
// import '../screens/my_home_page.dart'; // Import MyHomePage if you have it

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    // Helper for simple routes
    MaterialPageRoute buildSimpleRoute(Widget child) {
      return MaterialPageRoute(settings: settings, builder: (_) => child);
    }

    // Helper function to create error routes
    MaterialPageRoute errorRoute(String? routeName) {
      return MaterialPageRoute(
        settings: settings, // Pass settings for potential debugging
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
      // --- General Routes ---

      case testfirabsepage:
        return buildSimpleRoute(const TestFireBase());
      case loginRoute:
        // BlocProvider removed. Ensure LoginPage gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(
            LoginPage()); // LoginPage should not be const if it uses Bloc context
      case '/': // Default route
        // BlocProvider removed. Ensure HomeAdmin gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(const HomeAdmin());

      // --- Admin Routes ---
      case homeAdminRoute:
        return buildSimpleRoute(const HomeAdmin());
      case adminListStudentsRoute:
        return buildSimpleRoute(ListStudents()); // Remove const if it uses Bloc
      case adminAddTeacherRoute:
        // BlocProvider removed. Ensure AddTeacher gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(AddTeacher()); // Remove const if it uses Bloc
      case adminListTeachersRoute:
        // BlocProvider removed. Ensure ListTeachers gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(const ListTeachers());
      case adminUpdateTeacherRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('teacherId')) {
          final teacherId = arguments['teacherId'] as String;
          // BlocProvider removed. Ensure UpdateTeacherPage gets its Bloc/Cubit from higher up or internally.
          return buildSimpleRoute(
              UpdateTeacherPage(teacherId: teacherId)); // Remove const
        }
        return errorRoute(settings.name); // Handle missing/invalid argument

      case adminUpdateStudentRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('studentId')) {
          final studentId = arguments['studentId'] as String;
          // BlocProvider removed. Ensure UpdateStudentPage gets its Bloc/Cubit from higher up or internally.
          return buildSimpleRoute(
              UpdateStudentPage(studentId: studentId)); // Remove const
        }
        return errorRoute(settings.name); // Handle missing/invalid argument

      // --- Teacher Routes ---
      case homeTeacherRoute:
        // BlocProvider removed. Ensure HomeTeacher gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(HomeTeacher());
      case teacherListStudentsRoute:
        // BlocProvider removed. Ensure ListStudentTeacher gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(const ListStudentTeacher());
      case teacherProfileStudentRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('ProfileStudentTID')) {
          final profileStudentTID = arguments['ProfileStudentTID'] as String;
          // BlocProvider removed. Ensure ProfileStudentTeacher gets its Bloc/Cubit from higher up or internally.
          return buildSimpleRoute(ProfileStudentTeacher(
              ProfileStudentTID: profileStudentTID)); // Remove const
        }
        return errorRoute(settings.name); // Handle missing/invalid argument
      case teacherListTeachersRoute:
        // BlocProvider removed. Ensure ListTeacherForTeacher gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(const ListTeacherForTeacher());
      case teacherProfileTeacherRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('profileTeacherId')) {
          final profileTeacherId = arguments['profileTeacherId'] as String;
          // BlocProvider removed. Ensure ProfileTeacherForTeacher gets its Bloc/Cubit from higher up or internally.
          return buildSimpleRoute(ProfileTeacherForTeacher(
              profileTeacherId: profileTeacherId)); // Remove const
        }
        return errorRoute(settings.name); // Handle missing/invalid argument
      case profileTeacherRoute: // Shared route
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('profileId')) {
          final profileId = arguments['profileId'] as String;
          // BlocProvider removed. Ensure ProfileTeacherPage gets its Bloc/Cubit from higher up or internally.
          return buildSimpleRoute(
              ProfileTeacherPage(profileId: profileId)); // Remove const
        }
        return errorRoute(settings.name); // Handle missing/invalid argument

      // --- Student Routes ---
      case homeStudentRoute:
        // BlocProvider removed. Ensure HomeStudent gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(const HomeStudent());
      case studentProfileRoute:
        if (arguments is Map<String, dynamic> &&
            arguments.containsKey('ProfileStudentID')) {
          final profileStudentID = arguments['ProfileStudentID'] as String;
          // BlocProvider removed. Ensure ProfileStudentPage gets its Bloc/Cubit from higher up or internally.
          return buildSimpleRoute(ProfileStudentPage(
              ProfileStudentID: profileStudentID)); // Remove const
        }
        return errorRoute(settings.name); // Handle missing/invalid argument
      case studentListStudentsRoute: // Assuming this is StudentListClass
        // BlocProvider removed. Ensure Studentlistclass gets its Bloc/Cubit from higher up or internally.
        return buildSimpleRoute(
            const Studentlistclass()); // Check if this should be const

      default:
        // Use the error route helper
        return errorRoute(settings.name);
    }
  }
}
