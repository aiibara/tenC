//
//  HistoryDetailViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 11/04/22.
//

import UIKit

class HistoryDetailViewController: UIViewController {

    @IBOutlet weak var historyDetailTableView: UITableView!

    var date : Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Helper.formatDateAdv(date: date)
    }
    

}
