//
//  ThanksDiaryUITests.swift
//  ThanksDiaryUITests
//
//  Created by 강조은 on 2023/10/10.
//

import XCTest

final class ThanksDiaryUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch() // 앱 실행
    }
    
    override func tearDown() {
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }
 
    func test_detail_create() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let writeButton = app.buttons["button_main_floating"]
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        let writeDatailButton = app.buttons["button_main_floating_detail"]
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        let titleTextView = app.textViews["textView_title_detail"]
        XCTAssertTrue(titleTextView.exists)
        
        titleTextView.tap() // TextView 탭
        titleTextView.typeText("싱글태스킹 운영체제") // 키보드 텍스트 입력
        
        let contentsTextView = app.textViews["textView_contents_detail"]
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("싱글 태스킹 운영체제는 한번에 오직 하나의 프로그램만 실행할 수 있으나 멀티태스킹 운영체제는 하나 이상의 프로그램이 동시에 실행할 수 있게 한다. 이는 운영체제의 작업 스케줄링 하부 시스템에 의해 제각기 반복적으로 인터럽트 처리되는 여러 프로세스 사이에서 이용 가능한 프로세서 시간을 쪼개는 시분할을 통해 이루어진다.") // 키보드 텍스트 입력
        
        let completeButton = app.buttons["button_complete_detail"]
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
        
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        XCTAssertTrue(titleTextView.exists)
        
        titleTextView.tap() // TextView 탭
        titleTextView.typeText("사용자 운영체제 / 다중") // 키보드 텍스트 입력
        
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("는 사용자 구별이 없으나 여러 프로그램이 나란히 실행하는 것은 허용한다.[4] 다중 사용자 운영체제는 디스크 공간과 같은 리소스와 프로세스를 식별하는 기능을 갖춘 멀티태스킹의 기본 개념을 확장하며, 여러 사용자에 속해 있으면서 여러 사용자가 동시에 시스템과 상호 작용할 수 있게 한다. 시분할 운영체제들은 시스템의 효율적인 이용을 위해 태스크를 스케줄링하며, 프로세서 시간, 기억 공간, 인쇄, 기타 자원을 여러 사용자에게 비용적으로 할당") // 키보드 텍스트 입력
        
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
        
        
        
        
        
        
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        XCTAssertTrue(titleTextView.exists)
        
        titleTextView.tap() // TextView 탭
        titleTextView.typeText("마치며") // 키보드 텍스트 입력
        
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("다시 생각해보니깐, ‘어떤 의미 없는 문장을 넣을까?’는 정말 의미 없는 고민 같습니다. 저는 예전에 잡지에 빼낀 한 문단을 로렘 입숨처럼 사용했는데, 똑같은 문장만 계속 넣으니 식상해서 다른 문장을 찾아보는 기억이 있습니다. 이것도 일종의 의미 없는 고민에 속하는거죠. 지금이라도 알았으니 다행이네요. 더 이상 고민하지 마세요!") // 키보드 텍스트 입력
        
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
        
        
        
        
        
        
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        XCTAssertTrue(titleTextView.exists)
        
        titleTextView.tap() // TextView 탭
        titleTextView.typeText("한글입숨") // 키보드 텍스트 입력
        
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("서 만드신 한글용 로렘 입숨 사이트입니다. 여기도 비슷하게 문단 수와 문단 길이를 입력하면 됩니다만 텍스트 소스가 있는 걸 보니, 어떤 글에서 발췌한 내용을 가져오는 것 같습니다.") // 키보드 텍스트 입력
        
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
        
        
        
        
        
        
        
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        XCTAssertTrue(titleTextView.exists)
        
        titleTextView.tap() // TextView 탭
        titleTextView.typeText("로렘 입숨") // 키보드 텍스트 입력
        
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("로렘 입숨(lorem ipsum; 줄여서 립숨, lipsum)은 출판이나 그래픽 디자인 분야에서 폰트, 타이포그래피, 레이아웃 같은 그래픽 요소나 시각적 연출을 보여줄 때 사용하는 표준 채우기 텍스트로, 최종 결과물에 들어가는 실제적인 문장 내용이 채워지기 전에 시각 디자인 프로젝트 모형의 채움 글로도 이용된다. 이런 용도로 사용할 때 로렘 입숨을 그리킹(greeking)이라고도 부르며, 때로 로렘 입숨은 공간만 차지하는 무언가를 지칭하는") // 키보드 텍스트 입력
        
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
        
        
        
        
        
        
        
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        XCTAssertTrue(titleTextView.exists)
        
        titleTextView.tap() // TextView 탭
        titleTextView.typeText("소개") // 키보드 텍스트 입력
        
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("우리는 몇 일 전에 의뢰받은 작업의 레이아웃을 구성하고 있습니다. 크게 공간을 분배하고 레이아웃을 맞추고, 이제는 임의로 글을 채워넣어서 이 레이아웃이 괜찮은지 판별해야 합니다. 근데 여기에 무슨 말을 넣을까요? 의미 없는 말을 넣으면 쉽고 편하겠지만 ‘asdfghjkl’ 나 ‘으앙아아아아으아아아아아’ 아니면 ’일하기실하다다다다다다다다다’… 뭔가 좀 그렇습니다. 그래서 백과사전 같은 곳에서 글을 가져와 봅니다. 프린터? 낙타? 인크래더블2? 뭘 검색해서 가져올까…? 이것도 아무데서 가져오면 되겠지만 이상하게 고민되고 복사해서 가져와도 뭔가 좀 거슬리긴 합니다. 차라리 의미 없는 문장들이 있으면 좋지 않을까?") // 키보드 텍스트 입력
        
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
    }
    
    func test_simple_create() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let writeButton = app.buttons["button_main_floating"]
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        let writeDatailButton = app.buttons["button_main_floating_simple"]
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        let contentsTextView = app.textViews["textView_contents_simple"]
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("국가는 모성의 보호를 위하여 노력하여야 한다. 국가는 여자의 복지와 권익의 향상을 위하여 노력하여야 한다. 이 헌법시행 당시의 법령과 조약은 이 헌법에 위배되지 아니하는 한 그 효력을 지속한다. 대통령은 제4항과 제5항의 규정에 의하여 확정된 법률을 지체없이 공포하여야 한다. 제5항에 의하여 법률이 확정된 후 또는 제4항에 의한 확정법률이 정부에 이송된 후 5일 이내에 대통령이 공포하지 아니할 때에는 국회의장이 이를 공포한다. 대법원장과 대법관이 아닌 법관은 대법관회의의 동의를 얻어 대법원장이 임명한다. 대통령은 국가의 독립·영토의 보전·국가의 계속성과 헌법을 수호할 책무를 진다.") // 키보드 텍스트 입력
        
        let completeButton = app.buttons["button_complete_simple"]
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
        
        
        
        
        
        
        
        XCTAssertTrue(writeButton.exists)
        
        writeButton.tap()
        
        XCTAssertTrue(writeDatailButton.exists)
        
        writeDatailButton.tap()
        
        XCTAssertTrue(contentsTextView.exists)
        
        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("모든 국민은 헌법과 법률이 정한 법관에 의하여 법률에 의한 재판을 받을 권리를 가진다. 감사원은 원장을 포함한 5인 이상 11인 이하의 감사위원으로 구성한다. 국회는 정부의 동의없이 정부가 제출한 지출예산 각항의 금액을 증가하거나 새 비목을 설치할 수 없다. 혼인과 가족생활은 개인의 존엄과 양성의 평등을 기초로 성립되고 유지되어야 하며, 국가는 이를 보장한다. 모든 국민은 법률이 정하는 바에 의하여 국가기관에 문서로 청원할 권리를 가진다. 헌법개정안은 국회가 의결한 후 30일 이내에 국민투표에 붙여 국회의원선거권자 과반수의 투표와 투표자 과반수의 찬성을 얻어야 한다. 대한민국의 경제질서는 개인과 기업의 경제상의 자유와 창의를 존중함을 기본으로 한다.") // 키보드 텍스트 입력
        
        XCTAssertTrue(completeButton.exists)
        
        completeButton.tap()
        
    }
    
    func test_detail_read() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let tableView = app.tables["tableView_main"]

        var detailCell: XCUIElement?
        var currentIndex = 0

        var mainCellTitleText = ""
        while detailCell == nil && currentIndex < tableView.cells.count {
            let cell = tableView.cells.element(boundBy: currentIndex)
            
            if cell.identifier == "DetailDiaryTVCell" {
                detailCell = cell
            } else {
                currentIndex += 1
            }
        }

        if let detailCell {
            mainCellTitleText = detailCell.staticTexts["label_cell_detail_title"].label
            
            detailCell.tap()
        } else {
            print("자세한 일기 셀이 없음")
        }
        
        let detailTitleText = app.textViews["textView_title_detail"].value as? String ?? ""
        
        if mainCellTitleText == detailTitleText {
            print("성공")
        } else {
            print("실패")
            print("mainText: \(mainCellTitleText) detailText: \(detailTitleText)")
        }
    }
    
    func test_simple_read() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let tableView = app.tables["tableView_main"]

        var simpleCell: XCUIElement?
        var currentIndex = 0

        var mainCellTitleText = ""
        while simpleCell == nil && currentIndex < tableView.cells.count {
            let cell = tableView.cells.element(boundBy: currentIndex)
            
            if cell.identifier == "SimpleDiaryTVCell" {
                simpleCell = cell
            } else {
                currentIndex += 1
            }
        }

        if let simpleCell {
            mainCellTitleText = simpleCell.staticTexts["label_cell_simple_title"].label
            
            simpleCell.tap()
        } else {
            print("간단한 일기 셀이 없음")
        }
        
        let detailTitleText = app.textViews["textView_contents_simple"].value as? String ?? ""
        
        if mainCellTitleText == detailTitleText {
            print("성공")
        } else {
            print("실패")
            print("mainText: \(mainCellTitleText) detailText: \(detailTitleText)")
        }
    }
    
    func test_detail_update() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let tableView = app.tables["tableView_main"]

        var detailCell: XCUIElement?
        var currentIndex = 0

        var mainCellTitleText = ""
        while detailCell == nil && currentIndex < tableView.cells.count {
            let cell = tableView.cells.element(boundBy: currentIndex)
            
            if cell.identifier == "DetailDiaryTVCell" {
                detailCell = cell
            } else {
                currentIndex += 1
            }
        }

        if let detailCell {
            mainCellTitleText = detailCell.staticTexts["label_cell_detail_title"].label
            
            detailCell.tap()
        } else {
            print("자세한 일기 셀이 없음")
        }
        
        let detailTitleText = app.textViews["textView_title_detail"].value as? String ?? ""
        
        if mainCellTitleText == detailTitleText {
            print("조회 성공")
            
            let titleTextView = app.textViews["textView_title_detail"]
            XCTAssertTrue(titleTextView.exists)
            
            titleTextView.tap() // TextView 탭
            titleTextView.typeText("제목 수정") // 키보드 텍스트 입력
            
            let contentsTextView = app.textViews["textView_contents_detail"]
            XCTAssertTrue(contentsTextView.exists)
            
            contentsTextView.tap() // TextView 탭
            contentsTextView.typeText("내용 수정") // 키보드 텍스트 입력
            
            let completeButton = app.buttons["button_complete_detail"]
            XCTAssertTrue(completeButton.exists)
            
            completeButton.tap()
        } else {
            print("실패")
            print("mainText: \(mainCellTitleText) detailText: \(detailTitleText)")
        }
    }
    
    func test_simple_update() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let tableView = app.tables["tableView_main"]

        var simpleCell: XCUIElement?
        var currentIndex = 0

        var mainCellTitleText = ""
        while simpleCell == nil && currentIndex < tableView.cells.count {
            let cell = tableView.cells.element(boundBy: currentIndex)
            
            if cell.identifier == "SimpleDiaryTVCell" {
                simpleCell = cell
            } else {
                currentIndex += 1
            }
        }

        if let simpleCell {
            mainCellTitleText = simpleCell.staticTexts["label_cell_simple_title"].label
            
            simpleCell.tap()
        } else {
            print("간단한 일기 셀이 없음")
        }
        
        let detailTitleText = app.textViews["textView_contents_simple"].value as? String ?? ""
        
        if mainCellTitleText == detailTitleText {
            print("조회 성공")
            
            let contentsTextView = app.textViews["textView_contents_simple"]
            XCTAssertTrue(contentsTextView.exists)
            
            contentsTextView.tap() // TextView 탭
            contentsTextView.typeText("내용 수정") // 키보드 텍스트 입력
            
            let completeButton = app.buttons["button_complete_simple"]
            XCTAssertTrue(completeButton.exists)
            
            completeButton.tap()
        } else {
            print("실패")
            print("mainText: \(mainCellTitleText) detailText: \(detailTitleText)")
        }
    }
    
    func test_detail_delete() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let tableView = app.tables["tableView_main"]

        var detailCell: XCUIElement?
        var currentIndex = 0

        var mainCellTitleText = ""
        while detailCell == nil && currentIndex < tableView.cells.count {
            let cell = tableView.cells.element(boundBy: currentIndex)
            
            if cell.identifier == "DetailDiaryTVCell" {
                detailCell = cell
            } else {
                currentIndex += 1
            }
        }

        if let detailCell {
            mainCellTitleText = detailCell.staticTexts["label_cell_detail_title"].label
            
            detailCell.tap()
        } else {
            print("자세한 일기 셀이 없음")
        }
        
        let detailTitleText = app.textViews["textView_title_detail"].value as? String ?? ""
        
        if mainCellTitleText == detailTitleText {
            print("조회 성공")
            
            let deleteButton = app.buttons["button_delete_detail"]
            XCTAssertTrue(deleteButton.exists)
            
            deleteButton.tap()
            
            let alertRightButton = app.buttons["button_left_right"]
            XCTAssertTrue(alertRightButton.exists)
            
            alertRightButton.tap()
            
        } else {
            print("실패")
            print("mainText: \(mainCellTitleText) detailText: \(detailTitleText)")
        }
    }
    
    func test_simple_delete() throws {
        sleep(3) // 런치 화면 로티 지속 시간
        
        let tableView = app.tables["tableView_main"]

        var simpleCell: XCUIElement?
        var currentIndex = 0

        var mainCellTitleText = ""
        while simpleCell == nil && currentIndex < tableView.cells.count {
            let cell = tableView.cells.element(boundBy: currentIndex)
            
            if cell.identifier == "SimpleDiaryTVCell" {
                simpleCell = cell
            } else {
                currentIndex += 1
            }
        }

        if let simpleCell {
            mainCellTitleText = simpleCell.staticTexts["label_cell_simple_title"].label
            
            simpleCell.tap()
        } else {
            print("간단한 일기 셀이 없음")
        }
        
        let detailTitleText = app.textViews["textView_contents_simple"].value as? String ?? ""
        
        if mainCellTitleText == detailTitleText {
            print("조회 성공")
            
            let deleteButton = app.buttons["button_delete_simple"]
            XCTAssertTrue(deleteButton.exists)
            
            deleteButton.tap()
        } else {
            print("실패")
            print("mainText: \(mainCellTitleText) detailText: \(detailTitleText)")
        }
    }
}
