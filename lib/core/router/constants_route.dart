// e:\f\Projects_\Projects_Flutter_with_Firebase\primary-_school_management_flutter_firebase\lib\core\router\constants_route.dart

// General
const String testfirabsepage = '/testfirebase';
const String loginRoute = '/login';
const String unknownRoute = '/unknown'; // For the default case

// Admin Routes
const String homeAdminRoute =
    '/admin/home'; // Changed from '/' to be more specific
const String adminListStudentsRoute = '/admin/students/list';
const String adminAddTeacherRoute = '/admin/teachers/add';
const String adminListTeachersRoute = '/admin/teachers/list';
const String adminUpdateTeacherRoute = '/admin/teachers/update'; // Needs ID
const String adminLoginRequestsRoute = '/admin/login-requests';
// Note: UpdateStudentPage seems admin-related but wasn't explicitly listed under admin before. Assuming it is.
const String adminUpdateStudentRoute = '/admin/students/update'; // Needs ID

// Teacher Routes
const String homeTeacherRoute = '/teacher/home';
const String teacherListStudentsRoute =
    '/teacher/students/list'; // ListStudentTeacher
const String teacherProfileStudentRoute =
    '/teacher/students/profile'; // ProfileStudentTeacher - Needs ID
const String teacherStudentPointsRoute =
    '/teacher/students/points'; // Studentpoints
const String teacherStudentPointsAddRoute =
    '/teacher/students/points/add'; // Studentpoints1 - Needs ID (ProfileStudentID)
const String teacherStudentPointsViewRoute =
    '/teacher/students/points/view'; // Studentpoints2 - Needs ID (studentId)
const String teacherListTeachersRoute =
    '/teacher/teachers/list'; // ListTeacherForTeacher
const String teacherProfileTeacherRoute =
    '/teacher/teachers/profile'; // ProfileTeacherForTeacher - Needs ID
const String teacherMessagesRoute =
    '/teacher/messages'; // MessagesForStudents (Assuming this is for teachers to view/manage)
const String teacherSendToTeacherRoute =
    '/teacher/send-message'; // SendToTeacher (Assuming teacher-to-teacher)

// Student Routes
const String homeStudentRoute = '/student/home';
const String studentProfileRoute =
    '/student/profile'; // ProfileStudentPage - Needs ID
const String studentListStudentsRoute =
    '/student/students/list'; // ListStudentsForStudednt

// Shared/Other Routes (Adjust paths as needed)
const String myHomePageRoute =
    '/my-home'; // Assuming this is a general home or test page
const String profileTeacherRoute =
    '/profile/teacher'; // ProfileTeacherPage - Needs ID (General profile view?)
// Note: The original list had multiple profile/update routes. Clarify which role uses which if needed.

// --- Original Constant (You might want to remove or repurpose this) ---
// final String homeAdmin = '/'; // Replaced by homeAdminRoute = '/admin/home';
// Choose ONE starting route for '/' in your main.dart or router.dart initialRoute
