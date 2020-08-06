import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_api/screens/allPosts.dart';
import 'package:path_provider/path_provider.dart'as path_provider;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meraaki Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Faustina'
      ),
      home: FutureBuilder(
        future: Hive.openBox('posts'),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            else{
              return AllPosts();
            }
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

