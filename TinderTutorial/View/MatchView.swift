//
//  MatchView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 13.03.2023.
//

import UIKit

class MatchView: UIView {
    // MARK: - Properties
    private let currentUser: User
    private let matchedUser: User
    
    private let matchImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "itsamatch"))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let currentUserImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "jane1"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        
        return iv
    }()
    
    private let matchedUserImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "jane1"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        
        return iv
    }()
    
    private lazy var sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SEND MESSAGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(didTapSendMessage),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var keepSwipingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SEND MESSAGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(didTapKeepSwiping),
                         for: .touchUpInside)
        
        return button
    }()
    
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    lazy var views = [
    matchImageView,
    descriptionLabel,
    currentUserImageView,
    matchedUserImageView,
    sendMessageButton,
    keepSwipingButton]
    
    // MARK: - Lifecycle
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        
        configureBlurView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
    @objc func didTapSendMessage() {
        
    }
    
    @objc func didTapKeepSwiping() {
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        views.forEach { view in
            addSubview(view)
            view.alpha = 1
        }
    }
    
    func configureBlurView() {
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { self.visualEffectView.alpha = 1 }, completion: nil)
    }
}
