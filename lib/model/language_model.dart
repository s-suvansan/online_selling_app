class LanguageModel {
  LanguageModel({
    this.home = "Home",
  });

  String home;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        home: json["home"] ?? "Home",
      );

  Map<String, dynamic> toJson() => {
        "home": home,
      };
}
