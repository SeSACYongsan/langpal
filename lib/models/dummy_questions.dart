import 'package:langpal/models/question.dart';
import 'package:langpal/models/question_type.dart';

final List<Question> dummyQuestions = [
  Question(
      owner: "Ashley",
      point: 30,
      questionType: QuestionType.difference,
      content: "What is the difference between 사랑해 and 사랑해요?"),
  Question(
      owner: "Ashley",
      point: 20,
      questionType: QuestionType.examples,
      content: "Show me some examples using 사랑해"),
  Question(
      owner: "LintK",
      point: 15,
      questionType: QuestionType.isNatural,
      content: "뉴진스 사랑해: Is this natural?"),
  Question(
      owner: "Sunupp",
      point: 10,
      questionType: QuestionType.meaning,
      content: "What's the meaning of 브리오그?"),
  Question(
      owner: "Sunupp",
      point: 5,
      questionType: QuestionType.what,
      content: "What's egualmente in Korean?"),
];
