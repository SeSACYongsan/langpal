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
              ],
            ),
          )
        ],
      ),
    );
  }
}
