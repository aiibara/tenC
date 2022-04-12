//
//  DashboardViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 07/04/22.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainBP: UIView!
    @IBOutlet weak var mainDate: UILabel!
    @IBOutlet weak var mainTime: UILabel!
    @IBOutlet weak var mainSys: UILabel!
    @IBOutlet weak var mainSysColor: UIImageView!
    @IBOutlet weak var mainDia: UILabel!
    @IBOutlet weak var mainDiaColor: UIImageView!
    @IBOutlet weak var mainPulse: UILabel!
    
    @IBOutlet weak var tableBp: UITableView!
    
    @IBOutlet weak var noLogLabel: UILabel!
    var logs: [BP] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Log", style: .done, target: self, action: #selector(navigateToAddLog))
        
        if let userData = UserDefaults.standard.object(forKey: "user") as? Data {
            let name = try! JSONDecoder().decode(User.self, from: userData).name
            navigationItem.title = "Welcome, \(name.uppercased())"
        }
        
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableBp.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        tableBp.dataSource = self
        tableBp.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.noLogLabel.isHidden = true
        if fetchData() {
            DispatchQueue.main.async {
                self.tableBp.reloadData()
            }
        }
    }
    
    func fetchData() -> Bool {
        if var result = BPCoreDataManager.shared.fetchBPLogs(dateFrom: Calendar.current.startOfDay(for: Date()), dateTo: NSDate() as Date), result.count > 0 {
            mainBP.isHidden = false
            tableBp.isHidden = false
            let firstLog = result.first
            result.removeFirst()
            logs = result
            mainDate.text = Helper.formatDateAdv(date: firstLog!.date)
            mainTime.text = Helper.formatDate(date: firstLog!.date, format: "HH:mm")
            mainSys.text = "\(firstLog?.sysVal ?? 0)"
            mainDia.text = "\(firstLog?.diaVal ?? 0)"
            mainSysColor.tintColor = firstLog?.getSysColor()
            mainDiaColor.tintColor = firstLog?.getDiaColor()
            mainPulse.text = "\(firstLog?.pulse ?? 0)"
            return true
        } else {
            mainBP.isHidden = true
            tableBp.isHidden = true
            noLogLabel.isHidden = false
            return false
        }
    }
    
    @objc func navigateToAddLog() {
        performSegue(withIdentifier: "addLogSegue", sender: "dashboard")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.setData(bp: logs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
}
