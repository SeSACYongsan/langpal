enum QuestionType {
  meaning,
  isNatural,
  what,
  difference,
  examples,
}

extension ParseToString on QuestionType {
  String toKoreanName() {
    switch (this) {
      case QuestionType.meaning:
        return "무슨 뜻입니까?";
      case QuestionType.isNatural:
        return "이 표현은 자연스럽습니까?";
      case QuestionType.what:
        return "무엇입니까?";
      case QuestionType.difference:
        return "차이점은 무엇입니까?";
      case QuestionType.examples:
        return "예문을 들어주세요.";
    }
  }
}
