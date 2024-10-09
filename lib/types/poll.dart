class Poll {
  final String name;
  final String desc;
  final int type; // 0 - product
  final Map<String, int?> questions;
  final String finalQuestion;
  Poll({
    required this.name,
    required this.desc,
    this.type = 0,
    required this.questions,
    required this.finalQuestion,
  });
}
