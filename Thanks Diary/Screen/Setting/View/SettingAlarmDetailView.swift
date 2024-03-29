//
//  SettingAlarmDetailView.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/07/24.
//

import UIKit

final class SettingAlarmDetailView: BaseView {
    
    // MARK: - UI components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray4.color
        view.layer.cornerRadius = 10
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.locale = Locale(identifier: DateFormat.LOCAL_IDENTIFIER.rawValue)
        pickerView.datePickerMode = .time
        pickerView.date = Date()
        return pickerView
    }()
    
    private let buttonView = UIView()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.cancel, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 17)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.maskedCorners = [.layerMinXMaxYCorner]
        button.setTitleColor(Asset.Color.gray1.color, for: .normal)
        return button
    }()
    
    let okButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(L10n.ok, for: .normal)
        button.titleLabel?.font = ResourceManager.instance.getFont(size: 17)
        button.backgroundColor = ResourceManager.instance.getMainColor()
        button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMaxXMaxYCorner]
        button.setTitleColor(Asset.Color.gray6.color, for: .normal)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        return button
    }()
    
    private var lineViewX: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        return view
    }()
    
    private var lineViewY: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.gray3.color
        return view
    }()
    
    // MARK: - Function
    
    func setDatepickerDate(date: Date?) {
        datePicker.date = date ?? Date()
    }
    
    // MARK: - UI, Target
    
    var datePickerHandler: (Date) -> Void = { _ in }
    
    override func initTarget() {
        datePicker.addTarget(for: .valueChanged) { sender in
            guard let picker = sender as? UIDatePicker else { return }
            self.datePickerHandler(picker.date)
        }
    }
    
    // MARK: - Constraint
    
    override func initSubviews() {
        addSubviews([
            backgroundView,
            containerView
        ])
        
        backgroundView.addSubview(backButton)
        containerView.addSubview(datePicker)
        
        containerView.addSubviews([
            buttonView,
            lineViewX
        ])
        
        buttonView.addSubviews([
            cancelButton,
            okButton,
            lineViewY
        ])
    }
    
    override func initConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.center.equalToSuperview()
            make.height.equalTo(260)
        }

        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(lineViewX.snp.top).offset(-15)
        }

        lineViewX.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(buttonView.snp.top)
            make.height.equalTo(1)
        }

        buttonView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
        }

        cancelButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(lineViewY.snp.leading)
            make.bottom.equalTo(buttonView)
            make.height.equalTo(55)
        }

        lineViewY.snp.makeConstraints { make in
            make.top.equalTo(buttonView.snp.top)
            make.leading.equalTo(cancelButton.snp.trailing)
            make.trailing.equalTo(okButton.snp.leading)
            make.bottom.equalTo(buttonView)
            make.width.equalTo(1)
        }

        okButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.bottom.equalTo(containerView)
        }

        cancelButton.snp.makeConstraints { make in
            make.size.equalTo(okButton)
        }
    }
}
