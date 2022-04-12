//
//  CustomTableViewCell.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import UIKit

@IBDesignable
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var SysColor: UIImageView!
    @IBOutlet weak var SysLabel: UILabel!
    @IBOutlet weak var DiaColor: UIImageView!
    @IBOutlet weak var DiaLabel: UILabel!
    
    @IBOutlet weak var PulseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(bp: BP) {
        self.timeLabel.text = Helper.formatDate(date: bp.date, format: "HH:mm")
        self.SysLabel.text = "\(bp.sysVal)"
        self.DiaLabel.text = "\(bp.diaVal)"
        self.SysColor.tintColor = bp.getSysColor()
        self.DiaColor.tintColor = bp.getDiaColor()
        self.PulseLabel.text = "\(bp.pulse)"
    }
    
}
