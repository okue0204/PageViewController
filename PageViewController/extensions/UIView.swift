//
//  UIView.swift
//  PageViewController
//
//  Created by 奥江英隆 on 2024/05/21.
//

import Foundation
import UIKit

extension UIView {
    
    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        guard let view = UINib(nibName: String(describing: Self.self),
                               bundle: bundle).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: CGColor {
        get {
            layer.shadowColor!
        }
        set {
            layer.shadowColor = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
}
