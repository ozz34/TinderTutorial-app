//
//  ProfileCell.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 10.03.2023.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
   // MARK: - Properties
   let imageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
