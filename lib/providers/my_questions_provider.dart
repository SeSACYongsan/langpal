import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/providers/current_user_id_provider.dart';

final myQuestionsProvider = FutureProvider((ref) async {
  final currentUserID = ref.read(currentUserIDProvider);
});
