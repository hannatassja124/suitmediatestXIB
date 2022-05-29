//
//  LoginScreenViewController.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 27/05/22.
//

import Foundation
import UIKit

class LoginScreenVC: UIViewController {
    
    // MARK: - Variable
    let nameTF = customTextField()
    let palindromeTF = customTextField()
    let icIV = UIImageView()
    let checkButton = customButtonStyle()
    let nextButton = customButtonStyle()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setSubview()
        setAutoLayout()
    }
    
    // MARK: - Function
    func setup() {
        view.layer.contents = #imageLiteral(resourceName: "background 1").cgImage
        
        icIV.image = UIImage(named: "ic_photo.png")
        icIV.contentMode = .scaleAspectFit
        
        nameTF.placeholder = "Name"
        palindromeTF.placeholder = "Palindrome"
        
        checkButton.setTitle("CHECK", for: .normal)
        nextButton.setTitle("NEXT", for: .normal)
        
        checkButton.addTarget(self, action: #selector(checkPalindrome), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(goToHomeScreen), for: .touchUpInside)
    }
    
    func setSubview(){
        view.addSubview(icIV)
        view.addSubview(nameTF)
        view.addSubview(palindromeTF)
        view.addSubview(checkButton)
        view.addSubview(nextButton)
    }
    
    func setAutoLayout(){
        let marginGuide = view.layoutMarginsGuide
        
        icIV.translatesAutoresizingMaskIntoConstraints = false
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        palindromeTF.translatesAutoresizingMaskIntoConstraints = false
        checkButton.translatesAutoresizingMaskIntoConstraints =  false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        //ic_photo
        icIV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        icIV.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 105).isActive = true
        icIV.widthAnchor.constraint(equalTo: icIV.heightAnchor, multiplier: 16/9).isActive = true
        
        //name text field
        nameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTF.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15).isActive = true
        nameTF.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -15).isActive = true
        nameTF.topAnchor.constraint(equalTo: icIV.bottomAnchor, constant: 58.12).isActive = true
        
        //palindrome text field
        palindromeTF.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        palindromeTF.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 15).isActive = true
        palindromeTF.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -15).isActive = true
        palindromeTF.topAnchor.constraint(equalTo: nameTF.bottomAnchor, constant: 22.12).isActive = true
        
        //check button
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkButton.topAnchor.constraint(equalTo: palindromeTF.bottomAnchor, constant: 45).isActive = true
        checkButton.heightAnchor.constraint(equalTo: checkButton.widthAnchor, multiplier: 1.0/7.0).isActive = true
        
        //next button
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 15).isActive = true
        nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor, multiplier: 1.0/7.0).isActive = true
        
    }
    
    //MARK: - Button Action
    @objc func checkPalindrome(sender: UIButton!){
        guard let palindrome = palindromeTF.text?.lowercased(), !palindrome.isEmpty else {return showAlert(title: "Error", message: "Field Palindrome is Empty")}
        
        let compare = (palindrome == String(palindrome.reversed()))
        
        if compare == true {
            showAlert(title: "Check", message: "is Palindrome")
        } else {
            showAlert(title: "Check", message: "not Palindrome")
        }
        
        print("check palindrome")
        
    }
    
    @objc func goToHomeScreen(_ sender: UIButton!){
        guard let name = nameTF.text, !name.isEmpty else {
            return showAlert(title: "Error", message: "Field Name is Empty")
        }
        
        print("go to home screen")
        
        let vc = HomeScreenVC() 
        vc.nameLabel.text = name
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissPage(sender:)))
        vc.navigationItem.title = "Home"
        
        let navVC = customNavController(rootViewController: vc)
        
        presentDetail(navVC)
    }
    
    @objc func dismissPage(sender: UIBarButtonItem){
        print("dismiss home screen page")
        dismiss(animated: true, completion: nil)
    }
    
}
