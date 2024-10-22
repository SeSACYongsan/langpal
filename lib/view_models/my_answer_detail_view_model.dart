import 'package:langpal/models/answer.dart';
import 'package:langpal/models/question.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_answer_detail_view_model.g.dart';

@riverpod
class MyAnswerDetailViewModel extends _$MyAnswerDetailViewModel {
  late final AnswerRepository answerRepository;
  late final QuestionRepository questionRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    answerRepository = AnswerRepository();
    questionRepository = QuestionRepository();
    return null;
  }

  Future<void> deleteAnswerByID(String answerID) async {
    await answerRepository.deleteAnswerByID(answerID);
    updateState();
  }

  Future<void> fetchMyAnswerDetail(String answerID) async {
    final answer = await answerRepository.fetchAnswerByID(answerID);
    final question =
        await questionRepository.fetchQuestionByID(answer!.questionID);
    updateState(
      question: question,
      answer: answer,
      isEditable: false,
      answerText: "",
    );
  }

  void initializeTextFieldByAnswerID(String answerID) {
    final answer = state.value!["answer"] as Answer;
    updateState(answerText: answer.content);
  }

  void setAnswerText(String answerText) {
    updateState(answerText: answerText);
  }

  void setIsEditable(bool isEditable) {
    updateState(isEditable: isEditable);
  }

  Future<void> updateAnswerByAnswerID(String answerID) async {
    final answer = await answerRepository.fetchAnswerByID(answerID);
    final newContent = state.value!["answerText"] as String;
    final modifiedAnswer = answer!.copyWith(content: newContent);
    await answerRepository.updateAnswer(modifiedAnswer);
    updateState(
      answer: modifiedAnswer,
      answerText: modifiedAnswer.content,
    );
  }

  void updateState({
    Question? question,
    Answer? answer,
    bool? isEditable,
    String? answerText,
  }) {
    state = AsyncData({
      "question": question ?? state.value!["question"] as Question,
      "answer": answer ?? state.value!["answer"] as Answer,
      "isEditable": isEditable ?? state.value!["isEditable"] as bool,
      "answerText": answerText ?? state.value!["answerText"] as String,
    });
  }
}
