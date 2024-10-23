import 'package:flutter/foundation.dart';
import 'package:langpal/repositories/question_repository.dart';
import 'package:langpal/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_view_model.g.dart';

@riverpod
class MainViewModel extends _$MainViewModel {
  late final UserRepository userRepository;
  late final QuestionRepository questionRepository;
  @override
  Future<Map<String, dynamic>?> build() async {
    questionRepository = QuestionRepository();
    userRepository = UserRepository();
    return null;
  }

  Future<void> fetchUnchosenQuestions() async {
    final questions = await questionRepository.fetchUnchosenQuestions();
    final questionOwnerIDs = questions!.map((question) => question.ownerID);
    final questionOwnerIDSet = Set.from(questionOwnerIDs);
    final questionOwnerProfilePhotoMap = {};
    for (final questionOwnerID in questionOwnerIDSet) {
      final profilePhoto =
          await userRepository.fetchProfilePhotoByUserID(questionOwnerID);
      questionOwnerProfilePhotoMap[questionOwnerID] = profilePhoto;
    }
    List<Uint8List?> questionOwnerProfilePhotos = [];
    for (final questionOwnerID in questionOwnerIDs) {
      final profilePhoto = questionOwnerProfilePhotoMap[questionOwnerID];
      questionOwnerProfilePhotos.add(profilePhoto);
    }
    state = AsyncData({
      "questions": questions,
      "profilePhotos": questionOwnerProfilePhotos,
    });
  }
}
