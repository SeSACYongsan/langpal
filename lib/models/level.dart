enum Level { beginner, intermediate, advanced }

extension ParseToString on Level {
  String toKoreanName() {
    switch (this) {
      case Level.beginner:
        return "초급";
      case Level.intermediate:
        return "중급";
      case Level.advanced:
        return "고급";
    }
  }
}
