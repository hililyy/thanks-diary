//
//  AlarmSettingCell.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/09/01.
//

import UIKit

class AlarmSettingCell: UITableViewCell {

    @IBOutlet weak var alarmSwitchBtn: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}