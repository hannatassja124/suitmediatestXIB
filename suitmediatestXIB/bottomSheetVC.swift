//
//  bottomSheetViewController.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 29/05/22.
//

import Foundation
import UIKit
 
class bottomSheetVC : UIViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    let defaultHeight: CGFloat = 300

    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    let userIV = UIImageView()
    let usernameLabel = UILabel()
    let selectButton = customButtonStyle()
    
    var userData: user!
    
    var delegate: passData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSubview()
        setupAutoLayout()
    }
    
    override func viewDidLayoutSubviews() {
        userIV.layer.borderWidth = 1
        userIV.layer.masksToBounds = false
        userIV.layer.borderColor = UIColor.white.cgColor
        userIV.layer.cornerRadius = userIV.frame.height/2
        userIV.clipsToBounds = true
    }
    
    func setup() {
        view.backgroundColor = .clear
        
        guard let imageURL = URL(string: "\(userData.avatar)") else {
            fatalError("image not found")
        }
        userIV.load(url: imageURL)
        
        usernameLabel.text = "\(userData.first_name) \(userData.last_name)"
        usernameLabel.font = .subheading
        
        selectButton.setTitle("Select", for: .normal)
        
        selectButton.addTarget(self, action: #selector(backToHomeScreen(sender:)), for: .touchUpInside)
    }
    
    func setupSubview(){
        view.addSubview(containerView)
        view.addSubview(userIV)
        view.addSubview(usernameLabel)
        view.addSubview(selectButton)
    }
        
    func setupAutoLayout() {
        let marginGuide = view.layoutMarginsGuide
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        userIV.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)

        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)

        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        userIV.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28).isActive = true
        userIV.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        userIV.widthAnchor.constraint(equalToConstant: 84).isActive = true
        userIV.heightAnchor.constraint(equalToConstant: 84).isActive = true
        
        usernameLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: userIV.bottomAnchor, constant: 15).isActive = true
        
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectButton.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 33.18).isActive = true
        selectButton.heightAnchor.constraint(equalTo: selectButton.widthAnchor, multiplier: 1.0/7.0).isActive = true
    }
    
    @objc func backToHomeScreen(sender:UIButton!){
        delegate.dismissData(data: userData)
        dismiss(animated: true, completion: nil)
    }
}
