class Poll {
  final int id;
  final String name;
  final String desc;
  final int type; // 0 - product
  final Map<String, int?>? questions;
  final String? finalQuestion;

  Poll({
    required this.id,
    required this.name,
    required this.desc,
    this.type = 0,
    this.questions,
    this.finalQuestion,
  });

  factory Poll.fromJson(Map json) {
    Map<String, int?> questions = {};
    for (String a in json["criteria"].keys) {
      questions[a] = null;
    }

    if (questions.isNotEmpty) {
      return Poll(
          id: json["poll_id"],
          name: json["name"],
          desc: json["description"],
          finalQuestion: json["question"],
          questions: questions);
    }
    return Poll(
        id: json["poll_id"], name: json["name"], desc: json["description"]);
  }
}
