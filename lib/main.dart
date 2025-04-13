import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/router/constants_route.dart';
import 'core/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    // return ScreenUtilInit(
    //     // Define the design size (e.g., based on your Figma/XD design)
    //     designSize: const Size(360, 690), // Example size, adjust as needed
    //     minTextAdapt: true, // Adapt text size
    //     splitScreenMode: true, // Support split screen mode
    //     builder: (context, child) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your School',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: loginRoute,
    );
  }
  // );
}
// }
