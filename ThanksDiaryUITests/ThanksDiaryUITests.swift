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
        titleTextView.typeText("자세히 작성하기 제목") // 키보드 텍스트 입력
        
        let contentsTextView = app.textViews["textView_contents_detail"]
        XCTAssertTrue(contentsTextView.exists)

        contentsTextView.tap() // TextView 탭
        contentsTextView.typeText("자세히 작성하기 내용") // 키보드 텍스트 입력
        
        let completeButton = app.buttons["button_complete_detail"]
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
        contentsTextView.typeText("간단히 작성하기 내용") // 키보드 텍스트 입력
        
        let completeButton = app.buttons["button_complete_simple"]
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
