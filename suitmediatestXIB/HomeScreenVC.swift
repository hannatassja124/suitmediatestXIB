//
//  HomeScreenVC.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 27/05/22.
//

import Foundation
import UIKit

protocol isAbleToReceiveData {
  func pass(data: user)
}

class HomeScreenVC: UIViewController, isAbleToReceiveData {
    
    //MARK: - Variable
    let welcomeLabel = UILabel()
    var nameLabel = UILabel()
    let infoLabel = UILabel()
    let bigNameLabel = UILabel()
    let emailLabel = UILabel()
    let websiteLabel = UILabel()
    let profileIV = UIImageView()
    let chooseButton = customButtonStyle()
    private var userData: user! = nil
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkEmpty()
        setup()
        setSubview()
        setAutoLayout()
        
    }
    
    override func viewDidLayoutSubviews() {
        profileIV.layer.borderWidth = 1
        profileIV.layer.masksToBounds = false
        profileIV.layer.borderColor = UIColor.white.cgColor
        profileIV.layer.cornerRadius = profileIV.frame.height/2
        profileIV.clipsToBounds = true
    }
    
    //MARK: - Function
    func setup(){
        applyBackground()
        
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.welcome
        welcomeLabel.textColor = UIColor.darkText

        nameLabel.font = UIFont.subtitle
        nameLabel.textColor = UIColor.darkText
        
        profileIV.image = UIImage(named: "image 2.png")
        profileIV.contentMode = .scaleAspectFit
        
        infoLabel.text = "Select a user to show the profile"
        infoLabel.font = UIFont.heading
        infoLabel.textColor = UIColor.greyText
        
        bigNameLabel.font = .title
        bigNameLabel.textColor = .greyText
        
        emailLabel.font = .heading
        emailLabel.textColor = .greyText
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goToWebsite(sender:)))
        websiteLabel.isUserInteractionEnabled = true
        websiteLabel.addGestureRecognizer(tap)
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        websiteLabel.attributedText = underlineAttributedString
        
        websiteLabel.text = "website"
        websiteLabel.font = .heading
        websiteLabel.textColor = .primary
        
        chooseButton.setTitle("Choose a User", for: .normal)
        chooseButton.addTarget(self, action: #selector(goToUserList), for: .touchUpInside)
    
    }
    
    func setSubview(){
        view.addSubview(welcomeLabel)
        view.addSubview(nameLabel)
        view.addSubview(profileIV)
        view.addSubview(infoLabel)
        view.addSubview(chooseButton)
        view.addSubview(bigNameLabel)
        view.addSubview(websiteLabel)
        view.addSubview(emailLabel)
    }
    
    func setAutoLayout(){
        let marginGuide = view.layoutMarginsGuide
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints =  false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileIV.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.translatesAutoresizingMaskIntoConstraints =  false
        bigNameLabel.translatesAutoresizingMaskIntoConstraints =  false
        emailLabel.translatesAutoresizingMaskIntoConstraints =  false
        websiteLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        //welcome Label
        welcomeLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 13).isActive = true
        
        //name Label
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 35).isActive = true
        
        //profile Image View
        profileIV.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 100).isActive = true
        profileIV.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        profileIV.widthAnchor.constraint(equalToConstant: 164.0).isActive = true
        profileIV.heightAnchor.constraint(equalToConstant: 164.0).isActive = true
        
        //info Label
        infoLabel.topAnchor.constraint(equalTo: profileIV.bottomAnchor, constant: 35.0).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        
        //choose user button
        chooseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseButton.topAnchor.constraint(equalTo: profileIV.bottomAnchor, constant: 333).isActive = true
        chooseButton.heightAnchor.constraint(equalTo: chooseButton.widthAnchor, multiplier: 1.0/7.0).isActive = true
        
        //big name label
        bigNameLabel.topAnchor.constraint(equalTo: profileIV.bottomAnchor, constant: 53.0).isActive = true
        bigNameLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        
        //email label
        emailLabel.topAnchor.constraint(equalTo: bigNameLabel.bottomAnchor, constant: 8.0).isActive = true
        emailLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        
        //website label
        websiteLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10.0).isActive = true
        websiteLabel.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor).isActive = true
        
    }
    
    func checkEmpty(){
        if userData != nil {
            infoLabel.isHidden = true
            bigNameLabel.isHidden = false
            emailLabel.isHidden = false
            websiteLabel.isHidden = false
        } else {
            infoLabel.isHidden = false
            bigNameLabel.isHidden = true
            emailLabel.isHidden = true
            websiteLabel.isHidden = true
        }
    }
    
    func pass(data: user) {
        print("data")
        
        userData = data
        nameLabel.text = "\(userData.first_name) \(userData.last_name)"
        bigNameLabel.text = "\(userData.first_name) \(userData.last_name)"
        emailLabel.text = "\(userData.email)"
        
        guard let imageURL = URL(string: "\(userData.avatar)") else {
            fatalError("image not found")
        }
        profileIV.load(url: imageURL)
        
        checkEmpty()
    }
    
    //MARK: - Button Action
    @objc func goToUserList(sender: UIButton!) {
        print("Go to user list")
        
        let vc = UserScreenVC()
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissPage(sender:)))
        vc.navigationItem.title = "Users"
        vc.delegate = self

        let navVC = customNavController(rootViewController: vc)
        presentDetail(navVC)
    }
    
    @objc func dismissPage(sender: UIButton!){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goToWebsite(sender: UITapGestureRecognizer){
        let vc = WebviewVC()
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissPage(sender:)))
        
        let navVC = customNavController(rootViewController: vc)
        presentDetail(navVC)
    }
}
