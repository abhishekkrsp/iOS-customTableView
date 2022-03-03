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

protocol ContactCellDelegate {
    func favorite(_ cell: ContactCell)
}

class ContactCell: UITableViewCell {
    var delegate: ContactCellDelegate?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        setupUI()
        setupConstraints()
    }
    
    @objc private func handleFavorite() {
        if let delegate = delegate {
            delegate.favorite(self)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(name)
        contentView.addSubview(buttonFav)
    }
    
    let name: UILabel = {
        let someLabel = UILabel()
        someLabel.translatesAutoresizingMaskIntoConstraints = false
        someLabel.adjustsFontSizeToFitWidth = true
        someLabel.numberOfLines = 1
        return someLabel;
    }()
    
    let buttonFav: UIButton = {
        let someButton = UIButton(type: .system)
        someButton.translatesAutoresizingMaskIntoConstraints = false
        someButton.setImage(UIImage.fav, for: .normal)
        someButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return someButton
    }()
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            name.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 0),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            buttonFav.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonFav.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 40),
            buttonFav.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            buttonFav.heightAnchor.constraint(equalToConstant: 30),
            buttonFav.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
