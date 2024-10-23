import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:langpal/models/language.dart';
import 'package:langpal/models/level.dart';
import 'package:langpal/router.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/initialization_view_model.dart';

class InitializationScreen extends ConsumerStatefulWidget {
  const InitializationScreen({super.key});
  @override
  ConsumerState<InitializationScreen> createState() =>
      _InitializationScreenState();
}

class _InitializationScreenState extends ConsumerState<InitializationScreen>
    with RouteAwareMixin {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(initializationViewModelProvider);
    return asyncData.when(
      loading: () {
        return const LoadingScreen();
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error);
      },
      data: (data) {
        if (data == null) {
          return const LoadingScreen();
        } else {
          final level = data["level"] as Level;
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  "assets/images/earth.png",
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Placeholder();
                  },
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
                              BoxShadow(
                                  offset: Offset(5, 5), color: Colors.black12),
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
                                  initialSelection: Language.korean,
                                  onSelected: (value) {
                                    ref
                                        .read(initializationViewModelProvider
                                            .notifier)
                                        .setFirstLanguage(value!);
                                  },
                                  requestFocusOnTap: true,
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  inputDecorationTheme:
                                      const InputDecorationTheme(),
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
                                  initialSelection: Language.english,
                                  onSelected: (value) {
                                    ref
                                        .read(initializationViewModelProvider
                                            .notifier)
                                        .setTargetLanguage(value!);
                                  },
                                  textStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  requestFocusOnTap: true,
                                  inputDecorationTheme:
                                      const InputDecorationTheme(),
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
                                child: SegmentedButton<Level>(
                                  segments: [
                                    ButtonSegment(
                                      value: Level.beginner,
                                      label: Text(
                                        Level.beginner.toKoreanName(),
                                      ),
                                    ),
                                    ButtonSegment(
                                      value: Level.intermediate,
                                      label: Text(
                                        Level.intermediate.toKoreanName(),
                                      ),
                                    ),
                                    ButtonSegment(
                                      value: Level.advanced,
                                      label: Text(
                                        Level.advanced.toKoreanName(),
                                      ),
                                    ),
                                  ],
                                  onSelectionChanged: (value) {
                                    ref
                                        .read(initializationViewModelProvider
                                            .notifier)
                                        .setLevel(value.first);
                                  },
                                  selected: {level},
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
      },
    );
  }

  @override
  void didPopNext() {
    ref.read(initializationViewModelProvider.notifier).resetState();
    super.didPopNext();
  }

  @override
  void didPush() {
    ref.read(initializationViewModelProvider.notifier).resetState();
    super.didPush();
  }

  @override
  void initState() {
    Future(() {
      ref.read(initializationViewModelProvider.notifier).resetState();
    });
    super.initState();
  }
}
