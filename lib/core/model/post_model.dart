class PostModel {
  List<PostModelData>? data;
  String? status;

  PostModel({this.data, this.status});

  PostModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PostModelData>[];
      json['data'].forEach((v) {
        data!.add(PostModelData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class PostModelData {
  int? id;
  String? title;
  String? body;

  PostModelData({this.id, this.title, this.body});

  PostModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
