//
//  RegisterViewController.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 07/04/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: CustomPicker!
    @IBOutlet weak var firstStepper: CustomStepper!
    @IBOutlet weak var secondStepper: CustomStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onPressDone))
        
        // Do any additional setup after loading the view.
        dateField.configurePicker(.date)
        dateField.setTitle("Date of birth")
        firstStepper.setTitle("Weight")
        secondStepper.setTitle("Height")
    }
    
    @objc func onPressDone() {
        guard let user = validateField() else { return }
        saveData(user: user)
        navigateToDashboard()
    }
    
    func validateField() -> User? {
        let name = nameField.text
        let dob = dateField.getValue()
        let weight = Int(firstStepper.getValue())
        let height = Int(secondStepper.getValue())
        if name == "" { return nil }
        if (weight < 1) { return nil }
        if height < 1 { return nil }
        
        return User(name: name!, dob: dob, weight: weight, height: height)
    }
    
    func saveData(user: User) {
        let data = try! JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: "user")
    }
    
    func navigateToDashboard() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBarController
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.window?.rootViewController = nil
        sceneDelegate.window?.rootViewController = nextViewController
        UIView.transition(with: sceneDelegate.window!, duration: 0.4, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
}
