//
//  CustomStepper.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import UIKit

@IBDesignable
final class CustomStepper: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var stepper: UIStepper!
    @IBOutlet private weak var stepperTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    func configureView() {
        guard let view = self.loadViewFromNib(nibName: "CustomStepper") else {return}
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func setTitle(_ title:String) {
        self.titleLabel.text = title
    }
    
    func getValue() -> Int {
        return Int(self.stepper.value)
    }
    
    func setValue(_ val: Int) {
        self.stepper.value = Double(val)
        self.stepperTextField.text = "\(val)"
    }
    
    func configureStepper(minValue:Int, maxValue:Int) {
        self.stepper.minimumValue = Double(minValue)
        self.stepper.maximumValue = Double(maxValue)
    }
    
    @IBAction func onStepperValueChanged(_ sender: Any) {
        stepperTextField.text = "\(Int(stepper.value))"
    }
    
    @IBAction func onStepperTextChange(_ sender: Any) {
        stepper.value = Double(stepperTextField.text ?? "0") ?? 0
    }
    
    @IBAction func onStepperTextFocus(_ sender: Any) {
        if stepperTextField.text == "0" {
            stepperTextField.text = ""
        }
    }
    
    @IBAction func onStepperTextUnFocus(_ sender: Any) {
        if stepperTextField.text == "" {
            stepperTextField.text = "0"
        }
    }
}
