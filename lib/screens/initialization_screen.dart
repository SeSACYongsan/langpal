import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/providers/firstLanguageProvider.dart';
import 'package:langpal/providers/targetLanguageProvider.dart';

class InitializationScreen extends ConsumerStatefulWidget {
  const InitializationScreen({super.key});
  @override
  ConsumerState<InitializationScreen> createState() =>
      _InitializationScreenState();
}

class _InitializationScreenState extends ConsumerState<InitializationScreen> {
  final firstLanguageTextEditingController = TextEditingController();
  final targetLanguageTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    firstLanguageTextEditingController.text =
        ref.watch(firstLanguageProvider).toKoreanName();
    targetLanguageTextEditingController.text =
        ref.watch(targetLanguageProvider).toKoreanName();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/earth.png",
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(offset: Offset(5, 5), color: Colors.black12),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "당신의 모국어",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: DropdownMenu(
                            onSelected: (value) {
                              ref
                                  .read(firstLanguageProvider.notifier)
                                  .setLanguage(value!);
                            },
                            controller: firstLanguageTextEditingController,
                            requestFocusOnTap: true,
                            inputDecorationTheme: const InputDecorationTheme(),
                            width: 200,
                            dropdownMenuEntries:
                                Language.values.map((language) {
                              return DropdownMenuEntry(
                                  value: language,
                                  label: language.toKoreanName());
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "배우고 싶은 언어",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: DropdownMenu(
                            onSelected: (value) {
                              ref
                                  .read(targetLanguageProvider.notifier)
                                  .setLanguage(value!);
                            },
                            controller: targetLanguageTextEditingController,
                            requestFocusOnTap: true,
                            inputDecorationTheme: const InputDecorationTheme(),
                            width: 200,
                            dropdownMenuEntries:
                                Language.values.map((language) {
                              return DropdownMenuEntry(
                                  value: language,
                                  label: language.toKoreanName());
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "구사 수준",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: DropdownMenu(
                            onSelected: (value) {},
                            requestFocusOnTap: true,
                            inputDecorationTheme: const InputDecorationTheme(),
                            width: 200,
                            dropdownMenuEntries: const [
                              DropdownMenuEntry(value: "Beginner", label: "초급"),
                              DropdownMenuEntry(
                                  value: "Intermediate", label: "중급"),
                              DropdownMenuEntry(value: "Advanced", label: "고급")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        elevation: 10,
                      ),
                      onPressed: () {},
                      child: const Text(
                        "다음으로",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    firstLanguageTextEditingController.dispose();
    targetLanguageTextEditingController.dispose();
    super.dispose();
  }
}
