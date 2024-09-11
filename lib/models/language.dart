const Map<Language, String> languageMapper = {
  Language.mandarin: "중국어",
  Language.spanish: "스페인어",
  Language.english: "영어",
  Language.hindi: "힌디어",
  Language.bengali: "벵갈어",
  Language.portuguese: "포르투갈어",
  Language.russian: "러시아어",
  Language.japanese: "일본어",
  Language.vietnamese: "베트남어",
  Language.turkish: "튀르키예어",
  Language.korean: "한국어",
};

enum Language {
  mandarin,
  spanish,
  english,
  hindi,
  bengali,
  portuguese,
  russian,
  japanese,
  vietnamese,
  turkish,
  korean
}

extension ParseToString on Language {
  String toKoreanName() {
    return languageMapper[this]!;
  }
}
