import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/providers/current_user_provider.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:langpal/view_models/my_answer_detail_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_answers_view_model.g.dart';

@riverpod
class MyAnswersViewModel extends _$MyAnswersViewModel {
  late final UserRepository userRepository;
  late final AnswerRepository answerRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    answerRepository = AnswerRepository();
    userRepository = UserRepository();
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
    List<LangpalUser?> answerOwners = [];
    for (final answer in answers!) {
      final owner = await userRepository.fetchUserByID(answer.ownerID);
      answerOwners.add(owner);
    }
    state = AsyncData({
      "answers": answers,
      "answerOwners": answerOwners,
    });
  }
}
