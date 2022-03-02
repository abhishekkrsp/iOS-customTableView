//
//  ContactCell.swift
//  CustomTableView
//
//  Created by Abhishek Kumar on 02/03/22.
//

import Foundation
import UIKit
extension UIImage {
    static let fav = UIImage(named: "fav_image")
}
class ContactCell: UITableViewCell {
    
    var link = ViewController()
    let name = UILabel()
    let buttonFav = UIButton(type: .system)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(name)
        addSubview(buttonFav)
        configure()
        setupConstraints()
        buttonFav.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
    }
    
    @objc private func handleFavorite() {
        print("handlefav")
        link.someFunctionCall(cell: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureName()
        configureButtonFav()
    }
    
    func setupConstraints() {
        setupNameConstraints()
        setupButtonFavConstraints()
    }
    func configureName() {
        name.adjustsFontSizeToFitWidth = true
        name.numberOfLines = 1
    }
    func configureButtonFav() {
        buttonFav.setTitle("UIButton", for: .normal)
        buttonFav.setImage(UIImage.fav, for: .normal)
        buttonFav.tintColor = .red
        buttonFav.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        
    }
    
    func setupNameConstraints() {
//        name.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        name.translatesAutoresizingMaskIntoConstraints                 = false
        name.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40)
            .isActive = true
        name.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupButtonFavConstraints() {
        buttonFav.translatesAutoresizingMaskIntoConstraints = false
        buttonFav.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonFav.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 40).isActive = true
        buttonFav.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30).isActive = true
        buttonFav.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonFav.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
