//
//  BottomControlsStackView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 28.02.2023.
//
import UIKit

// MARK: - BottomControlsStackViewDelegate
protocol BottomControlsStackViewDelegate: AnyObject {
    func handleLike()
    func handleDislike()
    func handleRefresh()
}

final class BottomControlsStackView: UIStackView {
    // MARK: - Properties
    weak var delegate: BottomControlsStackViewDelegate?
    
    private let refreshButton = UIButton(type: .system)
    private let dislikeButton = UIButton(type: .system)
    private let superLikeButton = UIButton(type: .system)
    private let likeButton = UIButton(type: .system)
    private let boostButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        distribution = .fillEqually
        
        refreshButton.setImage(UIImage(named: "refresh_circle")?
            .withRenderingMode(.alwaysOriginal),for: .normal)
        dislikeButton.setImage(UIImage(named: "dismiss_circle")?
            .withRenderingMode(.alwaysOriginal),for: .normal)
        superLikeButton.setImage(UIImage(named: "super_like_circle")?.withRenderingMode(.alwaysOriginal),
                                 for: .normal)
        likeButton.setImage(UIImage(named: "like_circle")?
            .withRenderingMode(.alwaysOriginal), for: .normal)
        boostButton.setImage(UIImage(named: "boost_circle")?
            .withRenderingMode(.alwaysOriginal), for: .normal)
        
        refreshButton.addTarget(self,
                                action: #selector(handleRefresh),
                                for: .touchUpInside)
        
        likeButton.addTarget(self,
                                action: #selector(handleLike),
                                for: .touchUpInside)
        
        dislikeButton.addTarget(self,
                                action: #selector(handleDislike),
                                for: .touchUpInside)
        
        [refreshButton,
         dislikeButton,
         superLikeButton,
         likeButton,
         boostButton].forEach { view in
            addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func handleRefresh() {
        delegate?.handleRefresh()
    }
    
    @objc func handleLike() {
        delegate?.handleLike()
    }
    
    @objc func handleDislike() {
        delegate?.handleDislike()
    }
}
