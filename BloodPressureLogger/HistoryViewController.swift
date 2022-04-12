//
//  HistoryViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 11/04/22.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var historyTableView: UITableView!
    
    var historyData : [String: [BP]] = [:]
    var historySectionData : [String] = []
    
    var selectedDate : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        historyTableView.dataSource = self
        historyTableView.delegate = self
        fetchData()
    }
    
    func fetchData() -> Bool {
        guard let result = BPCoreDataManager.shared.fetchBPLogs(dateFrom: nil, dateTo: nil) else {return false}
        self.historySectionData = []
        self.historyData = [:]
 
        for i in result {
            let sectionTitle = Helper.formatDateAdv(date: i.date)
            if self.historyData[sectionTitle] == nil {
                self.historyData[sectionTitle] = [i]
                self.historySectionData.append(sectionTitle)
            }else {
                self.historyData[Helper.formatDateAdv(date: i.date)]!.append(i)
            }
        }
        DispatchQueue.main.async {
            self.historyTableView.reloadData()
        }
        return true
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "seeHistoryDetail", sender: nil)
//    }
//

    func numberOfSections(in tableView: UITableView) -> Int {
        return historyData.keys.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        tableView.sectionHeaderHeight = 70
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 160, height: 70))
        label.text = "\(self.historySectionData[section])"
        label.textColor = .bpPrimary
        label.font = .systemFont(ofSize: 21, weight: .bold)
        
        let tapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(self.headerTapped(_:))
            )
        header.addSubview(label)
        header.tag = section
        header.addGestureRecognizer(tapGestureRecognizer)
        return header
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(Array(self.historyData.keys)[section])"
//    }
    
    @objc func headerTapped(_ sender: UITapGestureRecognizer ) {
        let label = self.historySectionData[sender.view!.tag]
        self.selectedDate = self.historyData[label]![0].date
        performSegue(withIdentifier: "seeHistoryDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historyData[self.historySectionData[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        guard let bp = self.historyData[self.historySectionData[indexPath.section]]?[indexPath.row] else { return cell }
        cell.setData(bp: bp)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! HistoryDetailViewController
        destination.date = self.selectedDate
        self.tabBarController?.tabBar.isHidden = true
    }
}
