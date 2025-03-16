import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tf1/common/auth_service.dart';
import 'package:tf1/ui/auth_page.dart';
import 'package:tf1/ui/dashboard_page.dart';
import 'package:tf1/viewModel/task_view_model.dart';

void main() async {
  if (kIsWeb) {
    debugPrint("Running on Web: Using WebDatabase");
  } else {
    debugPrint("Running on Windows: Using NativeDatabase");
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()..getScheduledTasks()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  void checkLoginStatus() async {
    bool loggedIn = await AuthService.isLoggedIn();
    print('login result $loggedIn');
    if (loggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()),);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthPage()),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

