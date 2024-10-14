import 'package:langpal/models/langpal_user.dart';
import 'package:langpal/repositories/answer_repository.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'answer_card_view_model.g.dart';

@riverpod
class AnswerCardViewModel extends _$AnswerCardViewModel {
  late final AnswerRepository answerRepository;
  late final UserRepository userRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    answerRepository = AnswerRepository();
    userRepository = UserRepository();
    return null;
  }

  Future<LangpalUser?> fetchUserByAnswerID(String answerID) async {
    final answer = await answerRepository.fetchAnswerByID(answerID);
    final ownerID = answer!.ownerID;
    final owner = await userRepository.fetchUserByID(ownerID);
    return owner;
  }
}
