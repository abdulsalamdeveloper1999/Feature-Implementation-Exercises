class PostApi {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostApi({this.userId, this.id, this.title, this.body});

  factory PostApi.fromJson(Map<String, dynamic> json) => PostApi(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
