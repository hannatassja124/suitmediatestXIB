//
//  Style.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 27/05/22.
//

import Foundation
import UIKit

class customNavController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.tintColor = UIColor.primary
        
        self.modalPresentationStyle = .fullScreen
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.font: UIFont.subtitle, .foregroundColor: UIColor.primary]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
    }
}

class customTextField: UITextField {
    let insetConstant = UIEdgeInsets(top: 7.94, left: 20, bottom: 7.94, right: 16)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insetConstant)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insetConstant)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insetConstant)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.secondaryActive.cgColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = UIColor.white
        self.borderStyle = .roundedRect
        self.clipsToBounds = true
        self.font = UIFont.subheading
        
        self.frame.size.height = 39.88
    }
    
    required init?(coder: NSCoder) {
        fatalError("custom text field has not been implemented")
    }
}

class customButtonStyle: UIButton {
    let insetConstant = UIEdgeInsets(top: 12.35, left: 0, bottom: 12.35, right: 0)

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.layer.backgroundColor = UIColor.primary.cgColor
        self.titleLabel?.font = .button
        
        self.frame.size.height = 41
        self.frame.size.width = 310
        
        self.contentEdgeInsets = insetConstant
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("custom button has not been implemented")
    }
}
