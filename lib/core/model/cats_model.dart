class Cats {
  Cats({
    this.description,
    this.imageUrl,
    this.statusCode,
  });

  String? description;
  String? imageUrl;
  int? statusCode;

  factory Cats.fromJson(Map<String, dynamic> json) => Cats(
        description: json["description"],
        imageUrl: json["imageUrl"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "imageUrl": imageUrl,
        "statusCode": statusCode,
      };
}
