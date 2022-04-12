//
//  CustomPicker.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import UIKit

@IBDesignable
class CustomPicker: UIView {

    @IBOutlet private weak var pickerLabel: UILabel!
    @IBOutlet private weak var picker: UIDatePicker!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    func configureView() {
        guard let view = self.loadViewFromNib(nibName: "CustomPicker") else {return}
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func configurePicker(_ mode: UIDatePicker.Mode) {
        picker.datePickerMode = mode
    }
    
    func setTitle(_ title: String) {
        pickerLabel.text = title
    }
    
    func setMinDate(date:Date) {
        picker.minimumDate = date
    }
    
    func setMaxDate(date:Date) {
        picker.maximumDate = date
    }
    
    func setDate(date: Date) {
        picker.setDate(date, animated: false)
    }
    
    func getValue() -> Date {
        return picker.date
    }
}
