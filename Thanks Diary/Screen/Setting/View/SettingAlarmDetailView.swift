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
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private let containerView = UIView().then { view in
        view.backgroundColor = Asset.Color.gray4.color
        view.layer.cornerRadius = 10
    }
    
    let datePicker = UIDatePicker().then { pickerView in
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: "ko_KR")
        pickerView.datePickerMode = .time
        pickerView.date = Date()
    }
    
    private let buttonView = UIView()
    
    private let cancelButton = UIButton(type: .custom).then { button in
        button.setTitle("text_cancel".localized, for: .normal)
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_17
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
    }
    
    private let okButton = UIButton(type: .custom).then { button in
        button.setTitle("text_ok".localized, for: .normal)
        button.titleLabel?.font = Font.NANUM_ULTRALIGHT_17
        button.backgroundColor = Asset.Color.lightGrayBlue.color
        button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
    }
    
    private let backButton = UIButton().then { button in
        button.backgroundColor = .clear
    }
    
    private var lineViewX = UIView().then { view in
        view.backgroundColor = Asset.Color.gray3.color
    }
    
    private var lineViewY = UIView().then { view in
        view.backgroundColor = Asset.Color.gray3.color
    }
    
    // MARK: - Function
    
    func setDatepickerDate(date: Date?) {
        datePicker.date = date ?? Date()
    }
    
    // MARK: - UI, Target
    
    var backButtonTapHandler: () -> Void = {}
    var okButtonTapHandler: (Date) -> Void = { _ in }
    var cancelButtonTapHandler: () -> Void = {}
    var selectedTime = Date()
    
    override func initTarget() {
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
    
    override func initSubviews() {
        addSubviews([backgroundView, containerView])
        backgroundView.addSubview(backButton)
        containerView.addSubview(datePicker)
        containerView.addSubviews([buttonView, lineViewX])
        buttonView.addSubviews([cancelButton, okButton, lineViewY])
    }
    
    override func initConstraints() {
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