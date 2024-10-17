import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:langpal/screens/error_screen.dart';
import 'package:langpal/screens/loading_screen.dart';
import 'package:langpal/view_models/profile_setting_view_model.dart';

class ProfileSettingScreen extends ConsumerStatefulWidget {
  const ProfileSettingScreen({super.key});
  @override
  ConsumerState<ProfileSettingScreen> createState() =>
      _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends ConsumerState<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(profileSettingViewModelProvider);
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
          final username = data["username"] as String;
          final profileImage = data["profileImage"] as XFile?;
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
                SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(5, 5),
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                if (profileImage == null)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(90),
                                      elevation: 5,
                                      shape: const CircleBorder(),
                                    ),
                                    onPressed: () async {
                                      await onTapProfilePhoto();
                                    },
                                    child: Text(
                                      "프로필 사진",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: Image.file(
                                      File(profileImage.path),
                                    ),
                                  ),
                                const SizedBox(height: 30),
                                Text(
                                  "닉네임 입력",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    onChanged: (value) {
                                      ref
                                          .read(profileSettingViewModelProvider
                                              .notifier)
                                          .setUsername(value);
                                    },
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              elevation: 10,
                            ),
                            onPressed: () async {
                              await onTapNext(username);
                            },
                            child: Text(
                              "다음으로",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
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
  void initState() {
    super.initState();
    Future(() {
      ref.read(profileSettingViewModelProvider.notifier).resetState();
    });
  }

  Future<void> onTapNext(String username) async {
    if (username.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            icon: Icon(Icons.error),
            title: Text("닉네임을 입력해주세요"),
          );
        },
      );
    } else {
      await ref
          .read(profileSettingViewModelProvider.notifier)
          .addToFirestoreAndUpdateUser();
      context.go("/main");
    }
  }

  Future<void> onTapProfilePhoto() async {
    await ref
        .read(profileSettingViewModelProvider.notifier)
        .getImageFromGallery();
  }
}
