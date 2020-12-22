class Issue {
    Issue({
        this.id,
        this.createdAt,
        this.createdBy,
        this.title,
        this.content,
        this.photos,
        this.status,
        this.isEnable,
        this.accountPublic,
    });

    int id;
    String createdAt;
    String createdBy;
    String title;
    String content;
    List<String> photos;
    int status;
    bool isEnable;
    AccountPublic accountPublic;

    factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        photos: json["photos"] == null ? null : List<String>.from(json["photos"].map((x) => x)),
        status: json["status"] == null ? null : json["status"],
        isEnable: json["isEnable"] == null ? null : json["isEnable"],
        accountPublic: json["accountPublic"] == null ? null : AccountPublic.fromJson(json["accountPublic"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt,
        "createdBy": createdBy == null ? null : createdBy,
        "title": title == null ? null : title,
        "content": content == null ? null : content,
        "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x)),
        "status": status == null ? null : status,
        "isEnable": isEnable == null ? null : isEnable,
        "accountPublic": accountPublic == null ? null : accountPublic.toJson(),
    };
}

class AccountPublic {
    AccountPublic({
        this.id,
        this.name,
        this.avatar,
    });

    int id;
    String name;
    String avatar;

    factory AccountPublic.fromJson(Map<String, dynamic> json) => AccountPublic(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "avatar": avatar == null ? null : avatar,
    };
}