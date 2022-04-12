//
//  BP.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import Foundation
import UIKit

struct BP {
    var date:Date
    var sysVal:Int
    var diaVal:Int
    var pulse:Int
    
    func getSysColor() -> UIColor {
        switch(sysVal) {
        case 0..<120:
            return .bpNormal
        case 120...129:
            return .bpElevated
        case 130...139:
            return .bpStageOne
        case 140...180:
            return .bpStageTwo
        default:
            return .bpCrisis
        }
    }
    
    func getDiaColor() -> UIColor {
        switch(diaVal) {
        case 0..<80:
            if sysVal <= 120 {
                return .bpNormal
            } else{
                return .bpElevated
            }
        case 80...89:
            return .bpStageOne
        case 90...120:
            return .bpStageTwo
        default:
            return .bpCrisis
        }
    }
}

extension UIColor {
    static let bpPrimary: UIColor = UIColor(named: "AccentColor")!
    static let bpNormal: UIColor = UIColor(named: "bpNormal")!
    static let bpElevated: UIColor = UIColor(named: "bpElevated")!
    static let bpStageOne: UIColor = UIColor(named: "bpStageOne")!
    static let bpStageTwo: UIColor = UIColor(named: "bpStageTwo")!
    static let bpCrisis: UIColor = UIColor(named: "bpCrisis")!
}
