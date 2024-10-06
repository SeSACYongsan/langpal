import 'package:langpal/models/question_type.dart';

class Question {
  final String id;
  final String ownerID;
  final String ownerName;
  final int point;
  final QuestionType questionType;
  final String content;
  Question({
    required this.id,
    required this.ownerName,
    required this.ownerID,
    required this.point,
    required this.questionType,
    required this.content,
  });
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map["id"],
      ownerID: map["ownerID"],
      ownerName: map["ownerName"],
      point: int.parse(map["point"]),
      questionType: QuestionType.values.byName(map["questionType"]),
      content: map["content"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ownerID": ownerID,
      "ownerName": ownerName,
      "point": point.toString(),
      "questionType": questionType.name,
      "content": content,
    };
  }
}
