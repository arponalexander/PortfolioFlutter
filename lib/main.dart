
import 'package:alexander_arpon/ui/home.dart';
import 'package:alexander_arpon/utils/screen/screenUtils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());

  if (kIsWeb) {
    Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBcxi2iHJrluQPZyl73M9XXZMAylRZ-Nyo",
        appId: "1:213125599926:web:e2b8a5d945148748318c17",
        messagingSenderId: "213125599926",
        projectId: "alexander-arpon",
      ),
    );
  } else {
    Firebase.initializeApp();

  }
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Alexander Arpon",
      theme: ThemeData(brightness: Brightness.light),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot){
          if(snapshot.hasError){
            print("Error");
          }
          if(snapshot.connectionState == ConnectionState.done){
            return MyAppChild();
          }
          return const Center(child: SizedBox(width: 200,height:
            200,child: CircularProgressIndicator()),);
        },
      ),
    );
  }
}

class MyAppChild extends StatefulWidget {
  @override
  _MyAppChildState createState() => _MyAppChildState();
}

class _MyAppChildState extends State<MyAppChild> {
  @override
  Widget build(BuildContext context) {
    // instantiating ScreenUtil singleton instance, as this will be used throughout
    // the app to get screen size and other stuff
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return HomePage();
  }
}
