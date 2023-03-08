class DangerRatingData {
  static String danger(String dangerRating) {
    if (dangerRating == "1") {
      return "Easy Going";
    } else if (dangerRating == "2") {
      return "Excitement guaranteed";
    } else {
      return "Excitement Blast";
    }
  }
}
