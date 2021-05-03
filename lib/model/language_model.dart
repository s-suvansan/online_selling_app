class LanguageModel {
  LanguageModel({
    //base layout view
    this.home = "Home",
    this.favourites = "Favourites",
    this.settings = "Settings",
    // home and favourite view
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
    // product info view
    this.productInfo = "Product Info",
    this.postedAt = "Posted at {}",
    this.postedBy = "Posted by {}",
    this.negotiable = "Negotiable",
    this.desc = "Description",
    this.showMore = "Show more",
    this.showLess = "Show less",
    this.call = "Call",
    this.whatsapp = "WhatsApp",
    this.sorryCouldnotOpen = "Sorry, could not open.",
  });
  //base layout view
  String home;
  String favourites;
  String settings;
  // home and favourite view
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
  // product info view
  String productInfo;
  String postedAt;
  String postedBy;
  String negotiable;
  String desc;
  String showMore;
  String showLess;
  String call;
  String whatsapp;
  String sorryCouldnotOpen;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        //base layout view
        home: json["home"] ?? "Home",
        favourites: json["fav"] ?? "Favourites",
        settings: json["settings"] ?? "Settings",
        // home and favourite view
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
        // product info view
        productInfo: json["productInfo"] ?? "Product Info",
        postedAt: json["postedAt"] ?? "Posted at {}",
        postedBy: json["postedBy"] ?? "Posted by {}",
        negotiable: json["negotiable"] ?? "Negotiable",
        desc: json["desc"] ?? "Description",
        showMore: json["showMore"] ?? "Show more",
        showLess: json["showLess"] ?? "Show less",
        call: json["call"] ?? "Call",
        whatsapp: json["whatsapp"] ?? "WhatsApp",
        sorryCouldnotOpen: json["sorryCouldnotOpen"] ?? "Sorry, could not open.",
      );
}
