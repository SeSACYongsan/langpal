import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 50),
                Text(
                  "YOUR LANGUAGE MATE",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivoNarrow(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "LANGPAL",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.archivo(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      const Shadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          icon: Image.asset(
                            "assets/images/google_logo.png",
                            width: 30,
                          ),
                          label: const Text(
                            "SIGN IN WITH GOOGLE",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            elevation: 10,
                          ),
                          icon: Image.asset(
                            "assets/images/apple_logo.png",
                            width: 30,
                          ),
                          label: const Text(
                            "SIGN IN WITH APPLE",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
