class Answer {
  final String id;
  final String ownerID;
  final String questionID;
  final String content;
  final DateTime date;
  Answer({
    required this.id,
    required this.ownerID,
    required this.questionID,
    required this.content,
    required this.date,
  });
  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map["id"],
      ownerID: map["ownerID"],
      questionID: map["questionID"],
      content: map["content"],
      date: DateTime.parse(map["date"]),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ownerID": ownerID,
      "questionID": questionID,
      "content": content,
      "date": date.toString(),
    };
  }
}
