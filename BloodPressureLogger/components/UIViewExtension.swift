//
//  UIViewExtension.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import Foundation
import UIKit

extension UIView {
    
    func loadViewFromNib(nibName:String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("unable to convert nib \(nibName)")}
        return view
    }
}
