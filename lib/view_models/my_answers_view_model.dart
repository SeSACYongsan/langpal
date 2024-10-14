import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/view_models/my_answer_detail_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_answers_view_model.g.dart';

@riverpod
class MyAnswersViewModel extends _$MyAnswersViewModel {
  late final AnswerRepository answerRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    answerRepository = AnswerRepository();
    ref.listen(myAnswerDetailViewModelProvider, (previous, next) {
      if (next is AsyncData) {
        fetchMyAnswers();
      }
    });
    return null;
  }

  Future<void> fetchMyAnswers() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final answers = await answerRepository.fetchAnswersByUserID(currentUser.id);
    state = AsyncData({
      "user": currentUser,
      "answers": answers,
    });
  }
}
