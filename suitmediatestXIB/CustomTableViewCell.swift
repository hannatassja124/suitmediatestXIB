//
//  CustomTableViewCell.swift
//  suitmediatestXIB
//
//  Created by Hannatassja Hardjadinata on 28/05/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //MARK: - Variable
    let userIV = UIImageView()
    let usernameLabel = UILabel()
    let emailLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userIV.contentMode = .scaleAspectFit
        
        usernameLabel.font = UIFont.subheading
        emailLabel.font = UIFont.body
        
        self.contentView.addSubview(userIV)
        self.contentView.addSubview(usernameLabel)
        self.contentView.addSubview(emailLabel)
        
        userIV.translatesAutoresizingMaskIntoConstraints =  false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userIV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        userIV.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        userIV.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userIV.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: userIV.rightAnchor, constant: 20).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: userIV.rightAnchor, constant: 20).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userIV.layer.borderWidth = 1
        userIV.layer.masksToBounds = false
        userIV.layer.borderColor = UIColor.white.cgColor
        userIV.layer.cornerRadius = userIV.frame.height/2
        userIV.clipsToBounds = true
        
    }
    
}
