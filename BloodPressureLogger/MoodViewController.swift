//
//  MoodViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 10/04/22.
//

import UIKit

class MoodViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var moodInput: UISegmentedControl!
    @IBOutlet weak var moodNotesInput: UITextView!
    
    override func viewDidLoad() {
        let font = UIFont.systemFont(ofSize: 50)
        moodInput.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        
        moodNotesInput.layer.borderColor =   UIColor.lightGray.cgColor
        moodNotesInput.layer.borderWidth = 1;
        moodNotesInput.layer.cornerRadius = 5;
        moodNotesInput.isEditable = true
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        moodNotesInput.delegate = self
        moodNotesInput.text = "what's in your mind?"
        moodNotesInput.textColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(saveData))
    }
    
    @objc func saveData() {
        let type = moodInput.titleForSegment(at: moodInput.selectedSegmentIndex)!
        let createdDate = NSDate() as Date
        var notes = moodNotesInput.text ?? ""
        if moodNotesInput.textColor == .lightGray { notes = "" }
        MoodCoreDataManager.shared.addMood(emo: Emo(type: type, createdDate: createdDate, notes: notes))
        performSegue(withIdentifier: "goToActivity", sender: nil)
    }
    
    @IBAction func onValueChanged(_ sender: Any) {
//        print(moodInput.selectedSegmentIndex)
//        print(moodInput.titleForSegment(at: moodInput.selectedSegmentIndex)!)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "what's in your mind ?"
            textView.textColor = .lightGray
        }
    }
}
