import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:langpal/models/question_type.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  factory Question({
    required String id,
    required String ownerUsername,
    required String ownerID,
    required int point,
    required QuestionType questionType,
    required String content,
    required DateTime date,
    String? chosenAnswerID,
  }) = _Question;
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
