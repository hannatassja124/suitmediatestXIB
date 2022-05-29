//
//  Extension.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 27/05/22.
//

import Foundation
import UIKit

extension UIColor{
    static var primary: UIColor {
        return UIColor(red: 0.169, green: 0.388, blue: 0.482, alpha: 1)
    }
    
    static var secondaryActive: UIColor {
        return UIColor(red: 0.886, green: 0.89, blue: 0.894, alpha: 1)
    }
    
    static var lightText : UIColor {
        return UIColor(red: 0.383, green: 0.382, blue: 0.4, alpha: 1)
    }
    
    static var greyText : UIColor {
        return UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    }
    
    static var darkText : UIColor {
        return UIColor(red: 0.016, green: 0.008, blue: 0.114, alpha: 1)
    }
    
    static var darkText60 : UIColor {
        return UIColor(red: 0.408, green: 0.404, blue: 0.467, alpha: 1)
    }
}

extension UIFont{
    static var title: UIFont {
        guard let customFont = UIFont(name: "Poppins-SemiBold", size: 24.0) else {
            fatalError("Font is not found")
        }    
        return customFont
    }
    
    static var subtitle: UIFont {
        guard let customFont = UIFont(name: "Poppins-SemiBold", size: 18.0) else {
            fatalError("Font is not found")
        }
        return customFont
    }
    
    static var heading: UIFont {
        guard let customFont = UIFont(name: "Poppins-Medium", size: 18.0) else {
            fatalError("Font is not found")
        }
        return customFont
    }
    
    static var subheading: UIFont {
        guard let customFont = UIFont(name: "Poppins-Medium", size: 16.0) else {
            fatalError("Font is not found")
        }
        return customFont
    }
    
    static var button: UIFont {
        guard let customFont = UIFont(name: "Poppins-Medium", size: 14.0) else {
            fatalError("Font is not found")
        }
        return customFont
    }
    
    static var welcome: UIFont {
        guard let customFont = UIFont(name: "Poppins-Regular", size: 12.0) else {
            fatalError("Font is not found")
        }
        return customFont
    }
    
    static var body: UIFont {
        guard let customFont = UIFont(name: "Poppins-Medium", size: 10.0) else {
            fatalError("Font is not found")
        }
        return customFont
    }
    
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in}))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func applyBackground() {
        self.view.layer.backgroundColor = UIColor.white.cgColor
    }
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }

    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false, completion: nil)
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkText
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Poppins-Medium", size: 18)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
