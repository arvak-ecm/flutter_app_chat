class Message {
    Message({
        this.from,
        this.to,
        this.msg,
        this.createdAt,
        this.updatedAt,
        this.uid,
    });

    String from;
    String to;
    String msg;
    DateTime createdAt;
    DateTime updatedAt;
    String uid;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "uid": uid,
    };
}