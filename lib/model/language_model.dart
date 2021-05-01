class LanguageModel {
  LanguageModel({
    this.home = "Home",
    this.favourites = "Favourites",
    this.settings = "Settings",
    this.min = "min",
    this.mins = "mins",
    this.hr = "hr",
    this.hrs = "hrs",
    this.day = "day",
    this.days = "days",
    this.month = "month",
    this.months = "months",
    this.year = "year",
    this.years = "years",
    this.ago = "ago",
    this.rs = "Rs",
    this.justNow = "Just now",
  });

  String home;
  String favourites;
  String settings;
  String min;
  String mins;
  String hr;
  String hrs;
  String day;
  String days;
  String months;
  String month;
  String year;
  String years;
  String ago;
  String rs;
  String justNow;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        home: json["home"] ?? "Home",
        favourites: json["fav"] ?? "Favourites",
        settings: json["settings"] ?? "Settings",
        min: json["min"] ?? "min",
        mins: json["mins"] ?? "mins",
        hr: json["hr"] ?? "hr",
        hrs: json["hrs"] ?? "hrs",
        day: json["day"] ?? "day",
        days: json["days"] ?? "days",
        month: json["month"] ?? "month",
        months: json["months"] ?? "months",
        year: json["year"] ?? "year",
        years: json["years"] ?? "years",
        ago: json["ago"] ?? "ago",
        rs: json["rs"] ?? "Rs",
        justNow: json["justNow"] ?? "Just now",
      );
}
