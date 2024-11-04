# Langpal
![Earth Day Instagram post-7](https://github.com/user-attachments/assets/63f9395c-0d81-4fda-92cb-cb3b989a2a08)
## 📝 프로젝트 설명
Langpal은 서로가 서로의 모국어를 첨삭해주는 서비스입니다. 예를 들어, 한국어가 모국어인 제가, 다른 사람들의 한국어에 대한 질문에 답변을 해줄 수도 있고, 영어로 질문을 올릴 수도 있죠. 언어 자체의 뉘앙스를 잘 숙지하고 있는 원어민이 직접 첨삭을 해주는 것은 AI로는 어려운 작업일 것입니다. 제 서비스는 Android와 iOS 모두에 다가가기 위해 Flutter을 사용해 개발되었습니다.
## 🧑🏻‍💻 사용 기술
* Figma - 디자인 / 프로토타이핑
* Flutter - 앱 개발 프레임워크
* Firebase - Authentication / 데이터 스토리지
* Riverpod - 상태 관리 라이브러리
## 🤔 디자인 패턴
* MVVM 디자인 패턴 - 코드 가독성, 유지보수성 향상
  * Model - Repository - View Model - View

![MVVMPattern svg](https://github.com/user-attachments/assets/0209d66f-d77f-47a7-ba60-2616de398841)
## 🧮 주요 기능들
* 소셜 로그인
  * Google/Apple 계정을 통한 로그인 기능
* 초기 설정
  * 모국어, 타국어, 구사 수준 설정
  * 프로필 사진, 닉네임 설정
* 질문 게시
  * 5가지 유형으로 질문을 분류
  * 포인트 제도로 유저들로 하여금 답변의 동기 부여
* 알림 페이지
  * 답변 등록 & 답변 채택에 대한 알림 스크린
* 마이페이지
  * 내 질문 & 답변 모아보기
  * 구독 설정
  * 로그아웃

## 💿 프로젝트 설치 및 실행 방법
```zsh
flutter pub get
flutter run
```
