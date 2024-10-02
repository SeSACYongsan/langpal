import 'package:langpal/models/question_type.dart';

class Question {
  final String id;
  final String ownerID;
  final int point;
  final QuestionType questionType;
  final String content;
  Question(
      {required this.id,
      required this.ownerID,
      required this.point,
      required this.questionType,
      required this.content});
}
