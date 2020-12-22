class User {
    User({
        this.id,
        this.createdAt,
        this.createdBy,
        this.modifiedAt,
        this.modifiedBy,
        this.name,
        this.dateOfBirth,
        this.address,
        this.gender,
        this.phoneNumber,
        this.email,
        this.avatar,
        this.token,
    });

    int id;
    String createdAt;
    String createdBy;
    String modifiedAt;
    String modifiedBy;
    String name;
    String dateOfBirth;
    String address;
    bool gender;
    String phoneNumber;
    String email;
    String avatar;
    String token;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        createdBy: json["createdBy"] == null ? null : json["createdBy"],
        modifiedAt: json["modifiedAt"] == null ? null : json["modifiedAt"],
        modifiedBy: json["modifiedBy"] == null ? null : json["modifiedBy"],
        name: json["name"] == null ? null : json["name"],
        dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
        address: json["address"] == null ? null : json["address"],
        gender: json["gender"] == null ? null : json["gender"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        email: json["email"] == null ? null : json["email"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        token: json["token"] == null ? null : json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt,
        "createdBy": createdBy == null ? null : createdBy,
        "modifiedAt": modifiedAt == null ? null : modifiedAt,
        "modifiedBy": modifiedBy == null ? null : modifiedBy,
        "name": name == null ? null : name,
        "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
        "address": address == null ? null : address,
        "gender": gender == null ? null : gender,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "avatar": avatar == null ? null : avatar,
        "token": token == null ? null : token,
    };
}