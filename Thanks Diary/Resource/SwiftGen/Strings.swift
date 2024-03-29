// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// 생체인증을 다시 시도하시겠습니까?
  internal static let alertBioauth = L10n.tr("Localizable", "alert_bioauth", fallback: "생체인증을 다시 시도하시겠습니까?")
  /// 글을 삭제 하시겠습니까?
  internal static let alertDelete = L10n.tr("Localizable", "alert_delete", fallback: "글을 삭제 하시겠습니까?")
  /// * 오류가 발생했습니다 *
  /// 
  /// 
  /// 오류내용을 joun406@gmail.com
  /// 으로 보내주시면 빠르게 수정하겠습니다.
  /// 
  /// 감사합니다!
  internal static let alertErrorMessage = L10n.tr("Localizable", "alert_error_message", fallback: "* 오류가 발생했습니다 *\n\n\n오류내용을 joun406@gmail.com\n으로 보내주시면 빠르게 수정하겠습니다.\n\n감사합니다!")
  /// 비밀번호 입력
  internal static let alertPassword = L10n.tr("Localizable", "alert_password", fallback: "비밀번호 입력")
  /// 변경 내용이 저장되지 않았습니다. 수정사항을 저장하지 않고 뒤로 가시겠습니까?
  internal static let alertWarningNotSave = L10n.tr("Localizable", "alert_warning_not_save", fallback: "변경 내용이 저장되지 않았습니다. 수정사항을 저장하지 않고 뒤로 가시겠습니까?")
  /// 이미 존재하는 이메일입니다.
  /// 다른 이메일로 변경해 주세요.
  internal static let alreadySignup = L10n.tr("Localizable", "already_signup", fallback: "이미 존재하는 이메일입니다.\n다른 이메일로 변경해 주세요.")
  /// 알림 설정 권한이 거부되었습니다.
  /// 
  /// 설정으로 이동하여 알림을 허용해주세요.
  internal static let appSetting1 = L10n.tr("Localizable", "app_setting_1", fallback: "알림 설정 권한이 거부되었습니다.\n\n설정으로 이동하여 알림을 허용해주세요.")
  /// 설정으로 이동
  internal static let appSetting2 = L10n.tr("Localizable", "app_setting_2", fallback: "설정으로 이동")
  /// 뒤로가기
  internal static let back = L10n.tr("Localizable", "back", fallback: "뒤로가기")
  /// 취소
  internal static let cancel = L10n.tr("Localizable", "cancel", fallback: "취소")
  /// 닫기
  internal static let close = L10n.tr("Localizable", "close", fallback: "닫기")
  /// 색상 설정
  internal static let colorSet = L10n.tr("Localizable", "color_set", fallback: "색상 설정")
  /// 완료
  internal static let complete = L10n.tr("Localizable", "complete", fallback: "완료")
  /// 내용
  internal static let contents = L10n.tr("Localizable", "contents", fallback: "내용")
  /// 다크 모드
  internal static let darkmode = L10n.tr("Localizable", "darkmode", fallback: "다크 모드")
  /// 삭제
  internal static let delete = L10n.tr("Localizable", "delete", fallback: "삭제")
  /// 자세하게
  internal static let detail = L10n.tr("Localizable", "detail", fallback: "자세하게")
  /// 오류가 발생하였습니다.
  /// 
  /// 앱을 다시 실행하거나 관리자에게 문의해주세요.
  internal static let error = L10n.tr("Localizable", "error", fallback: "오류가 발생하였습니다.\n\n앱을 다시 실행하거나 관리자에게 문의해주세요.")
  /// 앱 종료
  internal static let exit = L10n.tr("Localizable", "exit", fallback: "앱 종료")
  /// 앱 종료
  internal static let exitApp = L10n.tr("Localizable", "exit_app", fallback: "앱 종료")
  /// 로그인을 실패하였습니다.
  internal static let failLogin = L10n.tr("Localizable", "fail_login", fallback: "로그인을 실패하였습니다.")
  /// 회원가입을 실패하였습니다.
  internal static let failSignup = L10n.tr("Localizable", "fail_signup", fallback: "회원가입을 실패하였습니다.")
  /// 나눔바른고딕
  internal static let font1 = L10n.tr("Localizable", "font_1", fallback: "나눔바른고딕")
  /// 나눔바른펜
  internal static let font2 = L10n.tr("Localizable", "font_2", fallback: "나눔바른펜")
  /// 온글잎 하루나눔
  internal static let font3 = L10n.tr("Localizable", "font_3", fallback: "온글잎 하루나눔")
  /// 온글잎 하곰체
  internal static let font4 = L10n.tr("Localizable", "font_4", fallback: "온글잎 하곰체")
  /// 온글잎 위리체
  internal static let font5 = L10n.tr("Localizable", "font_5", fallback: "온글잎 위리체")
  /// 온글잎 복숭씨
  internal static let font6 = L10n.tr("Localizable", "font_6", fallback: "온글잎 복숭씨")
  /// 온글잎 연유체
  internal static let font7 = L10n.tr("Localizable", "font_7", fallback: "온글잎 연유체")
  /// 프리텐다드
  internal static let font8 = L10n.tr("Localizable", "font_8", fallback: "프리텐다드")
  /// 코트라 희망체
  internal static let font9 = L10n.tr("Localizable", "font_9", fallback: "코트라 희망체")
  /// 폰트 설정
  internal static let fontSet = L10n.tr("Localizable", "font_set", fallback: "폰트 설정")
  /// yyyy년 M월 d일
  internal static let formatDate1 = L10n.tr("Localizable", "format_date1", fallback: "yyyy년 M월 d일")
  /// dd'일' (E)
  internal static let formatDate2 = L10n.tr("Localizable", "format_date2", fallback: "dd'일' (E)")
  /// YYYY년 M월
  internal static let formatDate3 = L10n.tr("Localizable", "format_date3", fallback: "YYYY년 M월")
  /// 내용을 입력해 주세요.
  internal static let inputContents = L10n.tr("Localizable", "input_contents", fallback: "내용을 입력해 주세요.")
  /// 내용을 입력해 주세요.
  internal static let inputTitle = L10n.tr("Localizable", "input_title", fallback: "내용을 입력해 주세요.")
  /// 문의하기
  internal static let inquiry = L10n.tr("Localizable", "inquiry", fallback: "문의하기")
  /// 라이트 모드
  internal static let lightmode = L10n.tr("Localizable", "lightmode", fallback: "라이트 모드")
  /// 비밀번호가 일치하지 않습니다.
  internal static let mismatchPassword = L10n.tr("Localizable", "mismatch_password", fallback: "비밀번호가 일치하지 않습니다.")
  /// 모드 설정
  internal static let modeSet = L10n.tr("Localizable", "mode_set", fallback: "모드 설정")
  /// 다음
  internal static let next = L10n.tr("Localizable", "next", fallback: "다음")
  /// 아니오
  internal static let no = L10n.tr("Localizable", "no", fallback: "아니오")
  /// 앱 버전 정보를 찾을 수 없습니다.
  internal static let nonExistentAppinfo = L10n.tr("Localizable", "non_existent_appinfo", fallback: "앱 버전 정보를 찾을 수 없습니다.")
  /// 로그인한 이메일이 없습니다.
  internal static let nonExistentEmail = L10n.tr("Localizable", "non_existent_email", fallback: "로그인한 이메일이 없습니다.")
  /// 이메일이 존재하지 않습니다.
  internal static let nonExistentUser = L10n.tr("Localizable", "non_existent_user", fallback: "이메일이 존재하지 않습니다.")
  /// 작성한 일기가 없습니다.
  internal static let notExistDiary = L10n.tr("Localizable", "not_exist_diary", fallback: "작성한 일기가 없습니다.")
  /// Localizable.strings
  ///   Thanks Diary
  /// 
  ///   Created by 강조은 on 2023/07/23.
  internal static let ok = L10n.tr("Localizable", "ok", fallback: "확인")
  /// 알림 설정이 켜져있어야 시간 설정이 가능합니다.
  internal static let onAlarm = L10n.tr("Localizable", "on_alarm", fallback: "알림 설정이 켜져있어야 시간 설정이 가능합니다.")
  /// 비밀번호
  internal static let password = L10n.tr("Localizable", "password", fallback: "비밀번호")
  /// 설정할 비밀번호를 입력해 주세요.
  internal static let passwordContents1 = L10n.tr("Localizable", "password_contents_1", fallback: "설정할 비밀번호를 입력해 주세요.")
  /// 비밀번호를 입력해 주세요.
  internal static let passwordContents2 = L10n.tr("Localizable", "password_contents_2", fallback: "비밀번호를 입력해 주세요.")
  /// 비밀번호가 일치하지 않습니다
  internal static let passwordIncorrect = L10n.tr("Localizable", "password_incorrect", fallback: "비밀번호가 일치하지 않습니다")
  /// 비밀번호를 다시 한번 입력해 주세요
  internal static let passwordRetry = L10n.tr("Localizable", "password_retry", fallback: "비밀번호를 다시 한번 입력해 주세요")
  /// 진행중
  internal static let progress = L10n.tr("Localizable", "progress", fallback: "진행중")
  /// 오늘의 일기를 작성해볼까요?💌
  internal static let pushContentsGeneral = L10n.tr("Localizable", "push_contents_general", fallback: "오늘의 일기를 작성해볼까요?💌")
  /// 💙감사일기를 작성할 시간이에요💙
  internal static let pushTitleGeneral = L10n.tr("Localizable", "push_title_general", fallback: "💙감사일기를 작성할 시간이에요💙")
  /// ** 문구가 변경되지 않을 경우 스위치를 껐다 켜주세요! **
  internal static let pushWarningMessage = L10n.tr("Localizable", "push_warning_message", fallback: "** 문구가 변경되지 않을 경우 스위치를 껐다 켜주세요! **")
  /// 테마적용을 위해 앱을 종료해주세요.
  internal static let restartApp = L10n.tr("Localizable", "restart_app", fallback: "테마적용을 위해 앱을 종료해주세요.")
  /// 다시시도
  internal static let retry = L10n.tr("Localizable", "retry", fallback: "다시시도")
  /// 검색어를 입력하세요
  internal static let searchMessage = L10n.tr("Localizable", "search_message", fallback: "검색어를 입력하세요")
  /// 검색 결과가 없습니다.
  internal static let searchNotResult = L10n.tr("Localizable", "search_not_result", fallback: "검색 결과가 없습니다.")
  /// 설정
  internal static let setting = L10n.tr("Localizable", "setting", fallback: "설정")
  /// 알림 설정
  internal static let settingAlarm = L10n.tr("Localizable", "setting_alarm", fallback: "알림 설정")
  /// 암호 설정
  internal static let settingName1 = L10n.tr("Localizable", "setting_name1", fallback: "암호 설정")
  /// 앱 평가
  internal static let settingName10 = L10n.tr("Localizable", "setting_name10", fallback: "앱 평가")
  /// 앱 정보
  internal static let settingName11 = L10n.tr("Localizable", "setting_name11", fallback: "앱 정보")
  /// 비밀번호 설정
  internal static let settingName12 = L10n.tr("Localizable", "setting_name12", fallback: "비밀번호 설정")
  /// 생체인증
  internal static let settingName13 = L10n.tr("Localizable", "setting_name13", fallback: "생체인증")
  /// 문구 설정
  internal static let settingName14 = L10n.tr("Localizable", "setting_name14", fallback: "문구 설정")
  /// 언어 설정
  internal static let settingName15 = L10n.tr("Localizable", "setting_name15", fallback: "언어 설정")
  /// 알림 설정
  internal static let settingName2 = L10n.tr("Localizable", "setting_name2", fallback: "알림 설정")
  /// 테마 설정
  internal static let settingName3 = L10n.tr("Localizable", "setting_name3", fallback: "테마 설정")
  /// 건의 게시판
  internal static let settingName4 = L10n.tr("Localizable", "setting_name4", fallback: "건의 게시판")
  /// 오픈소스 라이선스
  internal static let settingName5 = L10n.tr("Localizable", "setting_name5", fallback: "오픈소스 라이선스")
  /// 앱 버전
  internal static let settingName6 = L10n.tr("Localizable", "setting_name6", fallback: "앱 버전")
  /// 시간 설정
  internal static let settingName7 = L10n.tr("Localizable", "setting_name7", fallback: "시간 설정")
  /// 테마 선택
  internal static let settingName8 = L10n.tr("Localizable", "setting_name8", fallback: "테마 선택")
  /// 건의 게시판
  internal static let settingName9 = L10n.tr("Localizable", "setting_name9", fallback: "건의 게시판")
  /// 비밀번호를 6자 이상 입력해 주세요.
  internal static let shortPassword = L10n.tr("Localizable", "short_password", fallback: "비밀번호를 6자 이상 입력해 주세요.")
  /// 간단하게
  internal static let simple = L10n.tr("Localizable", "simple", fallback: "간단하게")
  /// 시작하기
  internal static let start = L10n.tr("Localizable", "start", fallback: "시작하기")
  /// 단순히 일기를 작성하는건
  /// 
  /// 부정적인 감정에 집중하기 쉬워요.
  /// 
  /// 감사일기를 작성하면
  /// 
  /// 긍정적인 감정에 집중할 수 있어요!
  internal static let startPage1Message1 = L10n.tr("Localizable", "start_page1_message1", fallback: "단순히 일기를 작성하는건\n\n부정적인 감정에 집중하기 쉬워요.\n\n감사일기를 작성하면\n\n긍정적인 감정에 집중할 수 있어요!")
  /// 감사일기 작성 방법
  internal static let startPage2Message1 = L10n.tr("Localizable", "start_page2_message1", fallback: "감사일기 작성 방법")
  /// 긍정문으로 작성해요
  internal static let startPage2Message2 = L10n.tr("Localizable", "start_page2_message2", fallback: "긍정문으로 작성해요")
  /// 작은 일에도 감사한 일을 찾아보세요
  internal static let startPage2Message3 = L10n.tr("Localizable", "start_page2_message3", fallback: "작은 일에도 감사한 일을 찾아보세요")
  /// 매일매일 작성해요
  internal static let startPage2Message4 = L10n.tr("Localizable", "start_page2_message4", fallback: "매일매일 작성해요")
  /// 감사한 일을 항상 생각해요
  internal static let startPage2Message5 = L10n.tr("Localizable", "start_page2_message5", fallback: "감사한 일을 항상 생각해요")
  /// 감사일기를 작성하고
  /// 나다운 하루를 만들어 보세요!
  internal static let startPage3Message1 = L10n.tr("Localizable", "start_page3_message1", fallback: "감사일기를 작성하고\n나다운 하루를 만들어 보세요!")
  /// 감사일기를 사용하면서 불편했거나
  /// 개선했으면 하는 점을 남겨주세요!
  /// 
  /// ** 모든 글은 익명으로 게시되니
  /// 자유로운 의견 작성 부탁드립니다. **
  internal static let suggestNotice = L10n.tr("Localizable", "suggest_notice", fallback: "감사일기를 사용하면서 불편했거나\n개선했으면 하는 점을 남겨주세요!\n\n** 모든 글은 익명으로 게시되니\n자유로운 의견 작성 부탁드립니다. **")
  /// [개발자 답변]
  internal static let suggestReplyDeveloper = L10n.tr("Localizable", "suggest_reply_developer", fallback: "[개발자 답변]")
  /// 감사일기
  internal static let thanksDiary = L10n.tr("Localizable", "thanks_diary", fallback: "감사일기")
  /// 제목
  internal static let title = L10n.tr("Localizable", "title", fallback: "제목")
  /// 제목과 내용을 모두 입력해 주세요.
  internal static let toast = L10n.tr("Localizable", "toast", fallback: "제목과 내용을 모두 입력해 주세요.")
  /// 일기가 저장되었습니다
  internal static let toastCompleteDiary = L10n.tr("Localizable", "toast_complete_diary", fallback: "일기가 저장되었습니다")
  /// 오늘
  internal static let today = L10n.tr("Localizable", "today", fallback: "오늘")
  /// 감사일기는 매일매일 작성하는게 중요해요!
  /// 우측 하단 버튼을 통해 일기를 작성해주세요!
  internal static let todayNotContents = L10n.tr("Localizable", "today_not_contents", fallback: "감사일기는 매일매일 작성하는게 중요해요!\n우측 하단 버튼을 통해 일기를 작성해주세요!")
  /// 아직 오늘의 일기를 작성하지 않았어요!
  internal static let todayNotTitle = L10n.tr("Localizable", "today_not_title", fallback: "아직 오늘의 일기를 작성하지 않았어요!")
  /// 오늘의 감사일기
  internal static let todayThanksDiary = L10n.tr("Localizable", "today_thanks_diary", fallback: "오늘의 감사일기")
  /// 오늘도
  internal static let todayWell = L10n.tr("Localizable", "today_well", fallback: "오늘도")
  /// 대기중
  internal static let waiting = L10n.tr("Localizable", "waiting", fallback: "대기중")
  /// 작성 완료
  internal static let writeComplete = L10n.tr("Localizable", "write_complete", fallback: "작성 완료")
  /// 이메일 형식이 잘못되었습니다.
  internal static let wrongEmailForget = L10n.tr("Localizable", "wrong_email_forget", fallback: "이메일 형식이 잘못되었습니다.")
  /// 이메일 형식이 잘못되었습니다.
  internal static let wrongEmailFormat = L10n.tr("Localizable", "wrong_email_format", fallback: "이메일 형식이 잘못되었습니다.")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
