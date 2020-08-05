import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_api/animations/fadeAnimation.dart';
import 'package:json_api/models/post.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
   String url = 'https://jsonplaceholder.typicode.com/posts';

  createPost(String url,{Map body})async{
    await http.post(url,body:body).then((http.Response response){
      if(response.statusCode<200 || response.statusCode>400 || json==null){
        throw Exception("Error while fetching data");
      }
      else{
        return (Post.fromJson(jsonDecode(response.body)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title:Text("Create Post",style: TextStyle( fontFamily: 'Acme', fontSize: 30),),
        centerTitle: true,
        backgroundColor: Colors.orange[400],
        elevation: 0,
      ),
      body: Container(
        height:height,
        width: width,
        child: FadeAnimation(1,
            Center(
            child: Container(
              height:orientation==Orientation.portrait? height*0.4:height*0.7,
              width:orientation==Orientation.portrait? width*0.8:width*0.6,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextField(
                    controller: titleController,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.orange[400])),
                        labelText: 'Post Title'),
                     ),
                     Spacer(flex:1),
                    TextField(
                    controller: bodyController,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.orange[400])),
                        labelText: 'Post Body'),
                     ),
                     Spacer(flex:2),
                     FlatButton(
                       color: Colors.orange[400],
                       onPressed: ()async{
                         Post newPost = Post(title: titleController.text, body: bodyController.text,id:0,userId:1);
                          await createPost(url,body:newPost.toMap());
                          Fluttertoast.showToast(
                            msg: "Post Created",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.blueGrey[400],
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                          Navigator.pop(context);
                       },
                       child: Text("Submit", style: TextStyle(fontSize: 16,color: Colors.white),),
                     ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}