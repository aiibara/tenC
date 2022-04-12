//
//  ActivityFormViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 10/04/22.
//

import UIKit

class ActivityFormViewController: UIViewController {
    
    @IBOutlet weak var activityField: UITextField!
    @IBOutlet weak var startDateField: CustomPicker!
    @IBOutlet weak var endDateField: CustomPicker!
    
    var activity : Act?
    var activityDate : Date = Date()
    var isNew : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureField(isNew: isNew)
        
        if isNew {
            navigationItem.title = "Add Activity"
        } else {
            navigationItem.title = "Edit Activity"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveData))
    }
    
    func configureField(isNew: Bool) {
        let minDate : Date = Helper.getStartDateof(date: activityDate)
        let maxDate : Date = Helper.getEndDateof(date: activityDate)
        self.startDateField.configurePicker(.time)
        self.startDateField.setTitle("Start Time")
        self.startDateField.setMinDate(date: minDate)
        self.startDateField.setMaxDate(date: maxDate)
        self.endDateField.configurePicker(.time)
        self.endDateField.setTitle("End Time")
        self.endDateField.setMinDate(date: minDate)
        self.endDateField.setMaxDate(date: maxDate)
        
        guard isNew else {
            self.activityField.text = self.activity?.desc ?? ""
            self.startDateField.setDate(date: (self.activity?.start)!)
            self.endDateField.setDate(date: (self.activity?.end)!)
            return
        }
    }
    
    @objc func saveData() {
        let activityName = activityField.text
        let startTime = startDateField.getValue()
        let endTime = endDateField.getValue()
        guard endTime > startTime, activityName != "" else { return }
        if self.activity == nil {
            self.activity = Act(id: UUID(), desc: activityName, end: endTime, start: startTime, createdDate: Date(), activityDate: activityDate)
            ActivityCoreDataManager.shared.addActivity(act: self.activity!)
        } else {
            self.activity?.desc = activityName
            self.activity?.end = endTime
            self.activity?.start = startTime
            ActivityCoreDataManager.shared.updateActivity(act: self.activity!)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
