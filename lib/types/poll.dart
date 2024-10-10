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
    Map<String, int?> q = {};
    for (Map a in json["criteria"] ?? []) {
      q[a["name"]] = null;
    }

    if (q.isNotEmpty) {
      return Poll(
          id: json["id"],
          name: json["name"],
          desc: json["description"],
          finalQuestion: json["question"],
          questions: q);
    }
    return Poll(id: json["id"], name: json["name"], desc: json["description"]);
  }
}
