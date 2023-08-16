//
//  SettingAlarmDetailView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/24.
//

import UIKit

final class SettingAlarmDetailView: BaseView {
    
    // MARK: - UI components
    
    private let backgroundView = UIView().then { view in
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    }
    
    private let containerView = UIView().then { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
    }
    
    let datePicker = UIDatePicker().then { pickerView in
        pickerView.overrideUserInterfaceStyle = .light
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "ko_KR")
        pickerView.datePickerMode = .time
        pickerView.date = Date()
    }
    
    private let buttonView = UIView()
    
    private let cancelButton = UIButton(type: .custom).then { button in
        button.setTitle("text_cancel".localized, for: .normal)
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_17
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.setTitleColor(Color.COLOR_GRAY1, for: .normal)
    }
    
    private let okButton = UIButton(type: .custom).then { button in
        button.setTitle("text_ok".localized, for: .normal)
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_17
        button.backgroundColor = Color.COLOR_LIGHTGRAYBLUE
        button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        button.setTitleColor(Color.COLOR_GRAY1, for:.normal)
    }
    
    private let backButton = UIButton().then { button in
        button.backgroundColor = .clear
    }
    
    private var lineViewX = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY3
    }
    
    private var lineViewY = UIView().then { view in
        view.backgroundColor = Color.COLOR_GRAY3
    }
    
    // MARK: - Function
    
    func setDatepickerDate(date: Date?) {
        datePicker.date = date ?? Date()
    }
    
    // MARK: - UI, Target
    
    var backButtonTapHandler: () -> () = {}
    var okButtonTapHandler: (Date) -> () = { _ in }
    var cancelButtonTapHandler: () -> () = {}
    var selectedTime = Date()
    
    override func setTarget() {
        backButton.addTarget { _ in
            self.backButtonTapHandler()
        }
        
        okButton.addTarget { _ in
            self.okButtonTapHandler(self.selectedTime)
        }
        
        cancelButton.addTarget { _ in
            self.cancelButtonTapHandler()
        }
        
        datePicker.addTarget(for: .valueChanged) { sender in
            guard let picker = sender as? UIDatePicker else { return }
            self.selectedTime = picker.date
        }
    }
    
    // MARK: - Constraint
    
    override func addSubView() {
        addSubviews([backgroundView, containerView])
        backgroundView.addSubview(backButton)
        containerView.addSubview(datePicker)
        containerView.addSubviews([buttonView, lineViewX])
        buttonView.addSubviews([cancelButton, okButton, lineViewY])
    }
    
    override func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(30)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(260)
        }

        datePicker.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(15)
            make.left.equalTo(containerView.snp.left)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(lineViewX.snp.top).offset(-15)
        }

        lineViewX.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.left.equalTo(containerView.snp.left)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(buttonView.snp.top)
            make.height.equalTo(1)
        }

        buttonView.snp.makeConstraints { make in
            make.left.equalTo(containerView.snp.left)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(containerView.snp.bottom)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.left.equalTo(buttonView.snp.left)
            make.right.equalTo(lineViewY.snp.left)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.height.equalTo(55)
        }

        lineViewY.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.left.equalTo(cancelButton.snp.right)
            make.right.equalTo(okButton.snp.left)
            make.bottom.equalTo(buttonView.snp.bottom)
            make.width.equalTo(1)
        }

        okButton.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.right.equalTo(buttonView.snp.right)
            make.bottom.equalTo(containerView.snp.bottom)
        }

        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(okButton)
            make.height.equalTo(okButton)
        }
    }
}
