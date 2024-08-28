import 'package:langpal/models/question_type.dart';

class Question {
  final String owner;
  final int point;
  final QuestionType questionType;
  final String content;
  Question(
      {required this.owner,
      required this.point,
      required this.questionType,
      required this.content});
}
