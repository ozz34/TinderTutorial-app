//
//  MatchCell.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 14.03.2023.
//

import UIKit

class MatchCell: UICollectionViewCell {
    // MARK: - Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "jane1"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        iv.setDimensions(height: 80, width: 80)
        iv.layer.cornerRadius = 80 / 2
        
        return iv
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stack = UIStackView(arrangedSubviews: [profileImageView,
                                                  userNameLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 6
        
        addSubview(stack)
        stack.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
