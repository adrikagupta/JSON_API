import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_api/models/post.dart';
import 'package:json_api/screens/createPost.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  List postList = [];
  @override
  void initState() { 
    super.initState();
    fetchPosts();
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
    }
    else{
      throw Exception('Failed to load Posts');
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.height;
    return Scaffold(
      body: isLoading? Center(child: CircularProgressIndicator()):
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: height*0.15,
                width: width,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                        child: Container(
                        height: height*0.13,
                        width: MediaQuery.of(context).size.width,
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
                              top:65,
                              left:50,
                              child: Row(
                                children: <Widget>[
                                  FlatButton.icon(
                                    color: Color.fromRGBO(207, 117, 91,1),
                                    onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePost())), 
                                    textColor: Colors.white,
                                    icon: Icon(Icons.add), 
                                    label:Text("Add Post")
                                    ),
                                    SizedBox(width: 20,),
                                    FlatButton.icon(
                                    color: Color.fromRGBO(108, 102, 116,1),
                                    onPressed: (){}, 
                                    textColor: Colors.white,
                                    icon: Icon(Icons.get_app), 
                                    label:Text("Get a Post")
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
                          postCard(index),
                          postThumbnail(index),
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
  postThumbnail(int index){
    return Positioned(
      left:0,
      top:90,
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
            child: Text("${postList[index].id}",style: TextStyle(fontSize: 23,color: Colors.white),),
          ),
        ),
      ),
    );
  }

  postCard(int index){
    return Container(
      height:240,
      padding: EdgeInsets.only(left:32,right:10),
      margin: EdgeInsets.only(left: 30.0),
      decoration:BoxDecoration(
      color: Color.fromRGBO(231, 154, 134,0.8),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
      // boxShadow: <BoxShadow>[
      //    BoxShadow(  
      //     color: Colors.black12,
      //     blurRadius: 10.0,
      //     offset: Offset(0.0, 10.0),
      //   ),
      // ],
    ),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical:10),
          child: Text(postList[index].title,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, fontFamily: 'Acme'),
          ),
        ),
        // SizedBox(height: 5,),
        Text(postList[index].body,style: TextStyle(fontSize: 16,fontFamily: 'Faustina'),),
    ],),
    );
  }
}