//
//  AddBPLogControllerViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 10/04/22.
//

import UIKit

class AddBPLogController: UIViewController {

    @IBOutlet weak var logTime: CustomPicker!
    @IBOutlet weak var sysStepper: CustomStepper!
    @IBOutlet weak var diaStepper: CustomStepper!
    @IBOutlet weak var pulseStepper: CustomStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))

        configureElements()
        
    }
    
    func configureElements() {
        logTime.setTitle("Time")
        sysStepper.setTitle("Sys /mmHg")
        diaStepper.setTitle("Dia /mmHg")
        pulseStepper.setTitle("Pulse /min")
    }
    
    @objc func saveData() {
        let time = logTime.getValue()
        let sysVal = sysStepper.getValue()
        let diaVal = diaStepper.getValue()
        let pulseVal = pulseStepper.getValue()
        BPCoreDataManager.shared.addLog(bp: BP(date: time, sysVal: sysVal, diaVal: diaVal, pulse: pulseVal))
        self.navigationController!.popToRootViewController(animated: true)
    }
    
    @objc func openCamera() {
        
    }
    
}
