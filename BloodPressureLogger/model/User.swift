//
//  User.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import Foundation

struct User : Codable {
    var name: String
    var dob: Date
    var weight: Int
    var height: Int
}
