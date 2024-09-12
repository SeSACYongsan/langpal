import 'package:flutter/material.dart';
import 'package:langpal/screens/main_screen.dart';
import 'package:langpal/screens/sign_in_screen.dart';

import 'screens/initialization_screen.dart';
import 'screens/my_answer_detail_screen.dart';
import 'screens/my_answers_screen.dart';
import 'screens/my_page_screen.dart';
import 'screens/my_question_detail_screen.dart';
import 'screens/my_questions_screen.dart';
import 'screens/new_question_screen.dart';
import 'screens/notifications_detail_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile_setting_screen.dart';
import 'screens/question_detail_screen.dart';
import 'screens/subscription_detail_screen.dart';
import 'screens/subscription_plans_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      //home: InitializationScreen(),
      //home: MainScreen()
      //home:MyAnswersScreen(),
      //home: MyAnswerDetailScreen(),
      //home: MyPageScreen()
      //home:MyQuestionsScreen()
      //home: MyQuestionDetailScreen()
      //home: NewQuestionScreen()
      //home: NotificationsScreen()
      //home: NotificationsDetailScreen()
      //home:ProfileSettingScreen()
      home: QuestionDetailScreen()
      //home: SignInScreen(),
      //home:SubscriptionDetailScreen()
      //home:SubscriptionPlansScreen()
    ),
  );
}
