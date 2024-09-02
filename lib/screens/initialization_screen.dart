import 'package:flutter/material.dart';

class InitializationScreen extends StatelessWidget {
  const InitializationScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "당신의 모국어",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: DropdownMenu(
                            enableFilter: true,
                            requestFocusOnTap: true,
                            inputDecorationTheme: InputDecorationTheme(),
                            width: 200,
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: "Korean", label: "한국어"),
                              DropdownMenuEntry(value: "English", label: "영어"),
                              DropdownMenuEntry(value: "Japanese", label: "일본어")
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "배우고 싶은 언어",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: DropdownMenu(
                            enableFilter: true,
                            requestFocusOnTap: true,
                            inputDecorationTheme: InputDecorationTheme(),
                            width: 200,
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: "Korean", label: "한국어"),
                              DropdownMenuEntry(value: "English", label: "영어"),
                              DropdownMenuEntry(value: "Japanese", label: "일본어")
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "구사 수준",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: DropdownMenu(
                            enableFilter: true,
                            requestFocusOnTap: true,
                            inputDecorationTheme: InputDecorationTheme(),
                            width: 200,
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: "Korean", label: "한국어"),
                              DropdownMenuEntry(value: "English", label: "영어"),
                              DropdownMenuEntry(value: "Japanese", label: "일본어")
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
}
