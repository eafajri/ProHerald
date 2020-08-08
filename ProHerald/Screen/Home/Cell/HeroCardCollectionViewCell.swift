//
//  HeroCardCollectionViewCell.swift
//  ProHerald
//
//  Created by erric alfajri on 08/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import UIKit
import Kingfisher

class HeroCardCollectionViewCell: UICollectionViewCell {
    var name: String? {
        didSet {
            if let name: String = name {
                nameLabel.text = name
            }
        }
    }
    
    var image: String? {
        didSet {
            if let url: URL = URL(string: "\(NetworkManager.shared.baseUrl)\(image ?? "")") {
                heroImageView.kf.setImage(with: url)
            }
        }
    }
    
    private lazy var heroImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = UIColor.darkText
        label.textAlignment = .center
        label.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(heroImageView)
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onTapCard))
        contentView.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            heroImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            heroImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    var tapCard: (() -> Void)?
    @objc private func onTapCard() {
        tapCard?()
    }
}
