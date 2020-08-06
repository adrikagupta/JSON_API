# JSON_API
An application that fetches posts from the JSON Placeholder API and displays them.

## Table of contents
* [Features](#features)
* [Bonus Sections](#bonus-sections)
* [Code Samples](#code-samples)
* [Features](#features)
* [Video link](#video-link)


## Features
- Send a POST request to add a new post.
- GET all posts and display them in a list
- GET one particular post and display all the details about that post.
- Error handling done.
- Good folder structure.

## Bonus Sections
- Great UI and subtle animations.
- Offline caching of the posts using Hive.

## Code Samples
* All the required dependencies.
```
  cupertino_icons: ^0.1.3
  http: ^0.12.2
  fluttertoast: ^7.0.2
  simple_animations: ^1.3.3
  hive: ^1.0.0
  hive_flutter: ^0.2.1
  path_provider: ^1.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  hive_generator: ^0.5.1
  build_runner:  
```

* Before performing any of the CRUD operations, Hive needs to be initialized to, among other things, know in which directory it stores the data. It's best to initialize Hive right in the main method.
```
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  runApp(MyApp());
}

```
* Data can be stored and read only from an opened Box. Opening a Box loads all of its data from the local storage into memory for immediate access.
```
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
            return Scaffold(
              body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
```
Next, a method is created to fetch the REST service. Also if the 'posts' Hive box is empty then we put in the body of the response. If it already has been added then we use the cached data.
```
  fetchPosts()async{
    setState(() {
      isLoading = true;
    });
    final postsBox = Hive.box('posts');
    if(postsBox.isEmpty){
    final response = await http.get("https://jsonplaceholder.typicode.com/posts");
    if(response.statusCode==200){
      postsBox.put('1', response.body);
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
    else{
      final responseBody = postsBox.get("1");
       postList = (jsonDecode(responseBody) as List).map((post) => Post.fromJson(post)).toList();
      setState(() {
        isLoading = false;
      });
      return postList;

    }
  }
  ```
  
  * Next, a method to send a POST request to add a new post.
  ```
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
  ```
  * Next, a method to GET one particular post and display all the details about that post
  ```
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
  ```
  
  ## Video link
  
 Link for the video: https://drive.google.com/file/d/172oxe8oA2uV-C2VB8dJ9pP4RUSgNVQx0/view?usp=sharing
