import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:Text("Create Post"),
        centerTitle: true,
        backgroundColor: Colors.orange[400],
        elevation: 0,
      ),
      body: Container(
        height:height ,
        width: width,
        child: Center(
          child: Container(
            height: height*0.5,
            width: width*0.4,
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
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "title....",
                     
                      labelText: 'Post Title'),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}