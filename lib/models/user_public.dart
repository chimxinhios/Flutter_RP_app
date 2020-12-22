class UserPublic {
    UserPublic({
        this.id,
        this.name,
        this.avatar,
    });

    int id;
    String name;
    String avatar;

    factory UserPublic.fromJson(Map<String, dynamic> json) => UserPublic(
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