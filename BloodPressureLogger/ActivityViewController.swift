//
//  ActivityViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 10/04/22.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityTableView: UITableView!
    var activityDate : Date = NSDate() as Date
    
    var activities = [Act]()
    var selectedActivity : Act?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(navigateToAddLog))
        
        
        activityTableView.dataSource = self
        activityTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if fetchData() {
            DispatchQueue.main.async {
                self.activityTableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func fetchData() -> Bool {
        guard let result = ActivityCoreDataManager.shared.fetchActivities(dateFrom: Helper.getStartDateof(date: activityDate), dateTo: Helper.getEndDateof(date: activityDate)) else { return false }
        activities = result
        return true
    }
    
    @objc func navigateToAddLog() {
        performSegue(withIdentifier: "goToAddLog", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(Helper.formatDate(date: activities[indexPath.row].start!, format: "HH:mm")) - \(Helper.formatDate(date: activities[indexPath.row].end!, format: "HH:mm"))"
        content.secondaryText = "\(activities[indexPath.row].desc!)"
        cell.contentConfiguration = content
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Edit") { [weak self] (action, view, completionHandler) in
            self?.selectedActivity = self?.activities[indexPath.row]
            self?.performSegue(withIdentifier: "editActivitySegue", sender: nil)
            completionHandler(true)
        }
        action.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.selectedActivity = self?.activities[indexPath.row]
            self?.confirmationDelete(completionHandler: completionHandler)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func confirmationDelete(completionHandler: @escaping (Bool)->Void) {
        let alert = UIAlertController(title: "Delete Planet", message: "Are you sure you want to permanently delete?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { alertAction in
            self.deleteAction(alertAction: alertAction, completionHandler: completionHandler)
        })
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            alertAction in
            self.cancelAction(alertAction: alertAction, completionHandler: completionHandler)
        })
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteAction(alertAction: UIAlertAction!, completionHandler: (Bool)->Void) {
        guard let id = self.selectedActivity?.id else {return}
        ActivityCoreDataManager.shared.deleteActivity(id: id)
        if fetchData() {
            DispatchQueue.main.async {
                self.activityTableView.reloadData()
            }
        }
        completionHandler(true)
    }
    
    func cancelAction(alertAction: UIAlertAction!, completionHandler: (Bool)->Void) {
        self.dismiss(animated: true, completion: nil)
        completionHandler(true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editActivitySegue" {
            let destination = segue.destination as! ActivityFormViewController
            destination.activityDate = self.activityDate
            destination.activity = self.selectedActivity
            destination.isNew = false
        }
    }
}
