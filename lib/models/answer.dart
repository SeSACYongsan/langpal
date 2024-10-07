class Answer {
  final String id;
  final String ownerID;
  final String questionID;
  final String content;
  Answer({
    required this.id,
    required this.ownerID,
    required this.questionID,
    required this.content,
  });
  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map["id"],
      ownerID: map["ownerID"],
      questionID: map["questionID"],
      content: map["content"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ownerID": ownerID,
      "questionID": questionID,
      "content": content,
    };
  }
}
