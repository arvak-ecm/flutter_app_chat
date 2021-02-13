class InfoResponse {
    InfoResponse({
        this.code,
        this.descrip,
    });

    String code;
    String descrip;

    factory InfoResponse.fromJson(Map<String, dynamic> json) => InfoResponse(
        code: json["code"],
        descrip: json["descrip"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "descrip": descrip,
    };
}