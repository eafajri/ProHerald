//
//  RoleCardTableViewCell.swift
//  ProHerald
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit

class RoleCardTableViewCell: UITableViewCell {
    
    private enum Constant {
        static let margin = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        static let buttonHeight: CGFloat = 24
    }
    
    var title: String = "" {
        didSet {
            button.setTitle(title, for: .normal)
        }
    }
    
    var isActive: Bool = false {
        didSet {
            if isActive {
                button.backgroundColor = .blue
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.blue, for: .normal)
            }
        }
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.tintColor = UIColor.blue
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        button.setTitleColor(.blue, for: .normal)
        
        button.addTarget(self, action: #selector(onTapButton), for: .allEvents)
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(button)
        contentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.margin.top),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.margin.bottom),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constant.margin.left),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constant.margin.right),
            button.heightAnchor.constraint(equalToConstant: Constant.buttonHeight)
        ])
    }
    
    var tapButton: (() -> Void)?
    @objc private func onTapButton() {
        tapButton?()
    }
}
