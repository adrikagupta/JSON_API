import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_api/animations/fadeAnimation.dart';
import 'package:json_api/models/post.dart';

class GetPost extends StatefulWidget {
  @override
  _GetPostState createState() => _GetPostState();
}

class _GetPostState extends State<GetPost> {
  TextEditingController idController = TextEditingController();

   String url = 'https://jsonplaceholder.typicode.com/posts';
   bool gotPost = false;
   Post requiredPost;
   getPost()async{
     final response = await http.get("https://jsonplaceholder.typicode.com/posts/${idController.text}");
     if(response.statusCode ==200){
      requiredPost = Post.fromJson(jsonDecode(response.body));
       setState(() {
         gotPost = true;
       });
     }
     else{
       Fluttertoast.showToast(
        msg: "No such Post available",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal[400],
        textColor: Colors.white,
        fontSize: 16.0
    );
     }
   }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title:Text("Get a Post", style: TextStyle(fontFamily: 'Acme',fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: FadeAnimation(1,
            Container(
            height:orientation==Orientation.portrait?height*0.85:height*1.5,
            width: width,
            child: Center(
              child: Container(
                margin:EdgeInsets.symmetric(vertical:20),
                height:orientation==Orientation.portrait?height*0.8:height*1.3,
                width: orientation==Orientation.portrait?width*0.85:width*0.6,
                decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadiusDirectional.circular(20),
                    boxShadow: <BoxShadow>[
                    BoxShadow(  
                     color: Colors.black12,
                     blurRadius: 10.0,
                     offset: Offset(0.0, 10.0),
                   ),
                 ],
                ),
               
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                      controller: idController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.teal[400])),
                          labelText: 'Type Id'),
                       ),
                      SizedBox(height: 10,),
                       FlatButton(
                         color: Colors.teal[400],
                         onPressed: (){
                          getPost();
                         },
                         child: Text("Get", style: TextStyle(fontSize: 16,color: Colors.white),),
                       ),
                       SizedBox(height: 20,),
                       gotPost? Container(
                         height: orientation==Orientation.portrait?height*0.5:height*0.8,
                         width: double.infinity,
                         margin: EdgeInsets.symmetric(horizontal:10),
                         padding: EdgeInsets.symmetric(horizontal:10),
                         child: Text("Details:\n\nuserId:  ${requiredPost.userId} \n\ntitle:  ${requiredPost.title} \n\nbody:  ${requiredPost.body} ",
                         style: TextStyle(fontSize: 16),
                         ),
                       ):Container()
                    ],
                  ),
                ),
              ),
            ),
        ),
          ),
      ),
    );
  }
}