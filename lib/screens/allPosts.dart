import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_api/models/post.dart';
import 'package:json_api/screens/createPost.dart';
import 'package:json_api/screens/getPost.dart';

class AllPosts extends StatefulWidget {
  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  bool isLoading = false;
  List postList = [];

  @override
  void initState() { 
    super.initState();
    fetchPosts();
  }

  addPost()async{
     await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePost()));
  }

  fetchPosts()async{
    setState(() {
      isLoading = true;
    });
    final response = await http.get("https://jsonplaceholder.typicode.com/posts");
    if(response.statusCode==200){
      postList = (jsonDecode(response.body) as List).map((post) => Post.fromJson(post)).toList();
      setState(() {
        isLoading = false;
      });
      return postList;
    }
    else{
      throw Exception('Failed to load Posts');
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
  
    return Scaffold(
      body: isLoading? Center(child: CircularProgressIndicator()):
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: orientation==Orientation.portrait? height*0.15:height*0.3,
                width: width,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                        child: Container(
                        height: orientation==Orientation.portrait?height*0.13:height*0.23,
                        width:width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/gen1.jpg"),
                            fit: BoxFit.cover
                          )
                        ),
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.only(top:10),
                          child: Text("All the Posts",textAlign: TextAlign.center, style: TextStyle(fontSize: 40,color: Colors.white, fontFamily: 'Acme'),),
                        ),
                      ),
                    ),
                    Positioned(
                              top: orientation==Orientation.portrait? height*0.09:height*0.15,
                              left:orientation==Orientation.portrait? width*0.06:width*0.25,
                              child: Row(
                                children: <Widget>[
                                  FlatButton.icon(
                                    color: Color.fromRGBO(207, 117, 91,1),
                                    onPressed: ()=>addPost(),
                                    textColor: Colors.white,
                                    icon: Icon(Icons.add), 
                                    label:Text("Add Post", style: TextStyle(fontSize: 15,letterSpacing: 1.2, fontWeight: FontWeight.bold,))
                                    ),
                                    SizedBox(width: orientation==Orientation.portrait?20:70,),
                                    FlatButton.icon(
                                    color: Color.fromRGBO(108, 102, 116,1),
                                    onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPost())), 
                                    textColor: Colors.white,
                                    icon: Icon(Icons.get_app), 
                                    label:Text("Get a Post", style: TextStyle(fontSize: 15,letterSpacing: 1.2, fontWeight: FontWeight.bold,))
                                    ),
                                ],
                              ),
                            ),
                  ],
                ),
              ),
              SizedBox(height:height*0.015),
            
                Container(
                    height: height*0.8,
                      child: ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (BuildContext context, int index){
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal:10,vertical: 10),
                          child: Stack(
                            children: <Widget>[
                              postCard(index,context),
                              postThumbnail(index,context),
                            ],
                          ),
                        );
                      }
                      ),
                  ),
            ],
          ),
        ),
      )
      ,
    );
  }
  postThumbnail(int index,context){
    var orientation = MediaQuery.of(context).orientation;
    return Positioned(
      left:0,
      top:orientation==Orientation.portrait?90:55,
      child: Container(
        // margin: EdgeInsets.symmetric(vertical:5),
        alignment: FractionalOffset.centerLeft,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(90, 125, 141,1)
          ),
          child: Center(
            child: Text( "${postList[index].id}",style: TextStyle(fontSize: 23,color: Colors.white),),
          ),
        ),
      ),
    );
  }

  postCard(int index,context){
    var orientation = MediaQuery.of(context).orientation;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: orientation==Orientation.portrait? 250:170,
      width:width,
      padding: EdgeInsets.only(left:35,right:10),
      margin: EdgeInsets.only(left: 30.0),
      decoration:BoxDecoration(
      color: Color.fromRGBO(231, 154, 134,0.7),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical:10),
          child: Text(postList[index].title,
          style: TextStyle(fontSize: 19,color:Colors.black87,fontWeight: FontWeight.bold,decoration: TextDecoration.underline, fontFamily: 'Acme'),
          ),
        ),
        // SizedBox(height: 5,),
        Text(postList[index].body,style: TextStyle(fontSize: 16,fontFamily: 'Faustina'),),
    ],),
    );
  }
}
