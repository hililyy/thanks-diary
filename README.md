# 감사일기 📝
> 다이어리 애플리케이션입니다.</br>
> 기획부터 디자인, 개발까지 모두 혼자 진행한 프로젝트입니다. 🙏🏻 </br>
> 사용자의 의견을 기반으로 앱의 기능도, 코드도 천천히, 꾸준히 성장하고 있습니다.🥹 </br>
> 다운로드 2000회👆🏻, 업데이트 1.2만회👆🏻 (23/12/05 기준) </br>
> [앱스토어 바로가기✨](https://apps.apple.com/kr/app/%EC%98%A4%EB%8A%98%EB%8F%84-%EA%B0%90%EC%82%AC%EC%9D%BC%EA%B8%B0/id6443505485)

<details>
<summary>더 보기</summary>
<img width="1142" alt="image" src="https://github.com/hililyy/thanks-diary/assets/76806444/837fbbee-8428-4cce-9329-e6178f4075f8">
  <img width="1117" alt="image" src="https://github.com/hililyy/thanks-diary/assets/76806444/9b51e8d8-614d-42f6-94ce-e890918a207d">

</details>

</br>

## 미리보기
![image](https://github.com/hililyy/thanks-diary/assets/76806444/ceac9b68-d583-459d-8d7f-b161ecf08e88)

</br>

## 개발정보
- 사용언어: Swift  
- 라이브러리 및 프레임워크
  - SnapKit, Then(Code Base)
  - RxSwift, RxCocoa
  - Coredata
  - Firebase(Realtime Database, Analytics)
  - SwiftLint, SwiftGen
  - Fastlane
  - FSCalendar
  - Lottie
  - Acknowlist
- 아키텍처: MVVM
- 최소버전: iOS 14.0

</br>

## 기능정의

1. 일기 CRUD
- 제목과 내용이 있는 자세히 적기, 내용만 있는 간단히 적기 기능이 있습니다.
- 메인화면에서 캘린더와 함께 날짜별로 글을 확인할 수 있습니다.
2. 알림
- 사용자가 설정한 시간에 푸시알림을 전송하여 일기 작성을 알립니다.
3. 비밀번호
- 사용자가 설정한 비밀번호를 앱 시작시 입력합니다.
- 생체인증(Face ID, Touch ID)를 통해서도 앱 잠금 해제가 가능합니다.
4. 모드설정
- 라이트모드와 다크모드를 선택할 수 있습니다.
- 5가지 색상의 앱 포인트 컬러를 선택할 수 있습니다.
- 9가지 종류의 폰트를 선택할 수 있습니다.
5. 건의게시판
- 모든 유저가 실시간 동기화 가능한 게시판을 통해 쉽게 건의사항을 작성할 수 있습니다.

</br>

## 버전기록 (15회)
<details>
<summary>버전 1.5.4</summary>
    
  </br>
  
[Feature🙋🏻‍♀️]
- 푸시 알림이 안오는 오류 수정
</details>

<details>
<summary>버전 1.5.3</summary>
    
  </br>
  
[Feature🙋🏻‍♀️]
- 건의사항을 반영하여 자세히 작성하기에서 뒤로가기 버튼을 눌러도 일기가 저장되도록 변경
- 홈 화면 일기 애니메이션 추가
- 좀 더 편리한 앱 사용을 위해 전체적으로 부분부분 로직 수정
- 자잘한 오류 수정
   
  </br>
  
 [Tech💻]
 - 일기 CRUD UITest Code 추가
</details>

<details>
<summary>버전 1.5.2</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 자잘한 오류 수정
</details>

<details>
<summary>버전 1.5.1</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 자잘한 오류 수정
</details>

<details>
<summary>버전 1.5.0</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 화면잠금 생체인증(Face ID, Touch ID) 기능 추가
  - 앱 평가 기능 추가
    
  </br>
  
   [Tech💻]
   - 일기 CRUD escaping -> async/await으로 변경
</details>

<details>
<summary>버전 1.4.0</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 앱 포인트 컬러 선택 기능 추가
  - 앱 폰트 선택 기능 추가
</details>

<details>
<summary>버전 1.3.1</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 자잘한 오류 / UI 수정
    
  </br>
  
   [Tech💻]
   - FastLane 적용 (자동배포도구)
</details>

<details>
<summary>버전 1.3.0</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 건의게시판 기능을 추가
  - 다크모드를 좀 더 밝은 색상으로 변경
  - 자세한 일기 작성과 조회 방식을 좀 더 간편하게 수정

  </br>
  
   [Tech💻]
   - CocoaPod 제거 -> Swift Package Manager로 변경
   - SwiftLint 추가 (정형화된 코드 컨벤션 도입)
   - SwiftGen 추가 (리소스 이름 입력 시 오타 방지)
   - Firebase Analytics 추가
</details>

<details>
<summary>버전 1.2.1</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 자잘한 오류 / UI 수정

  </br>
  
   [Tech💻]
   - 메인화면 RxSwift, RxCocoa 적용(일기 CRUD 로직, 테이블 뷰, 버튼 Target)

</details>

<details>
<summary>버전 1.2.0</summary>
  
  </br>
  
  [Feature🙋🏻‍♀️]
  - 다크모드/라이트모드 선택 (유저 건의 반영)
  - 자잘한 오류 수정

</details>

<details>
<summary>버전 1.1.0</summary>
    
  </br>
  
  [Feature🙋🏻‍♀️]
  - 알림기능 재 추가
  - 자잘한 오류 수정

  </br>
  
   [Tech💻]
   - BaseView, BaseTableViewCell, BaseNavigationViewController 추가 (중복 코드 제거)
   - 메인 화면, 설정 화면 전체 Storyboard -> Code(SnapKit)로 변경 (스토리보드 제거 -> 전체 Code Base로 변경)
   - 설정화면 알림설정, 비밀번호 설정 리팩토링 (복잡한 로직 가독성 좋게 수정)
</details>

<details>
<summary>버전 1.0.3</summary>
  
  </br>
  
  [Feature🙋🏻‍♀️]
  - UI/UX 수정
  - 앱 안정화 진행
  - 이전 날짜 일기 작성 가능하도록 기능 변경

  </br>
  
   [Tech💻]
   - MVC -> MVVM 으로 구조 변경
   - 전체 폴더링 구조 / 파일 명 수정
   - Floating Button Code(NSLayoutConstraint)로 직접 구현 (Floaty 라이브러리 제거)
   - 온보딩 화면 전체 Storyboard -> Code(NSLayoutConstraint)로 변경
   - 메인화면 로직 개선(리팩토링)
</details>

<details>
<summary>버전 1.0.2</summary>
  
  </br>
  
  [Feature🙋🏻‍♀️]
  - 알림 기능 임시 삭제 (알림 기능으로 인한 앱 충돌 발생으로 안정화된 서비스를 빠르게 제공하기 위해 제거하는 방향으로 결정)

  </br>
  
  [Tech💻]
- 온보딩 화면 PageViewController로 변경
- 온보딩 화면 부분적 Storyboard -> Code(NSLayoutConstraint)로 변경
- UIViewController -> BaseViewController 변경 (중복 코드 제거)
- Singleton을 사용하여 공용 객체 사용
</details>

<details>
<summary>버전 1.1.0-Beta(미출시)</summary>
  
  </br>
  
  [Tech💻]
  - 애플, 카카오, 구글 소셜로그인 (Firebase 연동)
  - Firebase RealtimeDatabase를 통한 일기 데이터 관리
  - 로컬에서 작성한 일기 Firebase로 동기화
  - 기존 MVC 패턴을 더 확실히 적용하여 다시 리팩토링 (Controller를 좀 더 가볍게 수정)
  
  </br>
  
  ** 미출시 이유 
  - 유저 데이터 및 일기 데이터를 Firebase에 저장하는 과정에서 보안 이슈 (유저 정보를 보안적 지식 없이 함부로 관리하는 것에 위험성을 느껴 개발 중단)
  - 단순히 일기를 저장하는 앱인데 로그인 기능이 추가되어 사용자 입장에서 번거로움을 느낄 것 같다고 생각함
  - 추후 앱의 기능이 더 확장되었을 때 구조를 갖추고 추가 보완하기로 결정
  
</details>

<details>
<summary>버전 1.0.1</summary>
  
  </br>
  
  [Feature🙋🏻‍♀️]
  - 특정 날짜에서 일기가 작성되지 않는 오류 수정
  - 앱 시작하기 로티 이미지 추가
  - 글 작성하기 UI/UX 수정

</details>

<details>
<summary>버전 1.0.0</summary>
  
  </br>
  
  [Feature🙋🏻‍♀️]

  - 전체 기능 개발
  - 온보딩
  - 일기 CRUD
  - 푸시 알림
  - 비밀번호

  </br>

  [Tech💻]
  
  - MVC
  - Local Push Notification
  - StoryBoard

</details>
