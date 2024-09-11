import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';
import 'package:langpal/providers/first_language_provider.dart';
import 'package:langpal/providers/level_provider.dart';
import 'package:langpal/providers/target_language_provider.dart';

class InitializationScreen extends ConsumerStatefulWidget {
  const InitializationScreen({super.key});
  @override
  ConsumerState<InitializationScreen> createState() =>
      _InitializationScreenState();
}

class _InitializationScreenState extends ConsumerState<InitializationScreen> {
  final firstLanguageTextEditingController = TextEditingController();
  final targetLanguageTextEditingController = TextEditingController();
  final levelTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    firstLanguageTextEditingController.text =
        ref.watch(firstLanguageProvider).toKoreanName();
    targetLanguageTextEditingController.text =
        ref.watch(targetLanguageProvider).toKoreanName();
    levelTextEditingController.text = ref.watch(levelProvider).toKoreanName();
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
                        Text(
                          "당신의 모국어",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
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
                            textStyle: Theme.of(context).textTheme.titleMedium,
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
                        Text(
                          "배우고 싶은 언어",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Center(
                          child: DropdownMenu(
                            onSelected: (value) {
                              ref
                                  .read(targetLanguageProvider.notifier)
                                  .setLanguage(value!);
                            },
                            textStyle: Theme.of(context).textTheme.titleMedium,
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
                        Text(
                          "구사 수준",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Center(
                          child: DropdownMenu(
                            controller: levelTextEditingController,
                            onSelected: (value) {
                              ref.read(levelProvider.notifier).setLevel(value!);
                            },
                            textStyle: Theme.of(context).textTheme.titleMedium,
                            requestFocusOnTap: true,
                            inputDecorationTheme: const InputDecorationTheme(),
                            width: 200,
                            dropdownMenuEntries: Level.values.map((level) {
                              return DropdownMenuEntry(
                                  value: level, label: level.toKoreanName());
                            }).toList(),
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
                      onPressed: () {
                        context.go("/profile_setting");
                      },
                      child: Text(
                        "다음으로",
                        style: Theme.of(context).textTheme.titleLarge,
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
    levelTextEditingController.dispose();
    super.dispose();
  }
}
