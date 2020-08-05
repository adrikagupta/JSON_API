class Post{
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.body,this.id,this.title,this.userId});

  factory Post.fromJson(Map<String,dynamic>json){
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map toMap() {
    var post = Map<String, dynamic>();
    post["title"] = title;
    post["body"] = body;
    return post;
  }
}

