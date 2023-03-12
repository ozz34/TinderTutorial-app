//
//  ProfileController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 10.03.2023.
//

import UIKit

class ProfileController: UIViewController {
    // MARK: - Properties
    private let user: User
    private let identifier = "ProfileCell"
    
    private lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: view.frame.width,
                           height: view.frame.width + 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProfileCell.self, forCellWithReuseIdentifier: identifier)
        
        return cv
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "dismiss_down_arrow")?.withRenderingMode(.alwaysOriginal),
                        for: .normal)
        button.addTarget(self,
                         action: #selector(handleDismiss),
                         for: .touchUpInside)
        return button
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Captain America"
        return label
    }()
    
    private let professionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Actor"
        
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Cool boy"
        return label
    }()
    
    private lazy var dislikeButton: UIButton = {
        let button = createButton(withImage: UIImage(named: "dismiss_circle") ?? UIImage())
        button.addTarget(self,
                         action: #selector(handleDislike),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var superlikeButton: UIButton = {
        let button = createButton(withImage: UIImage(named: "super_like_circle") ?? UIImage())
        button.addTarget(self,
                         action: #selector(handleSuperlike),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = createButton(withImage: UIImage(named: "like_circle") ?? UIImage())
        button.addTarget(self,
                         action: #selector(handleLike),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    // MARK: - Actions
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    @objc func handleDislike() {
       
    }
    
    @objc func handleSuperlike() {
        
    }
    
    @objc func handleLike() {
        
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(dismissButton)
        dismissButton.setDimensions(height: 40, width: 40)
        dismissButton.anchor(top: collectionView.bottomAnchor,
                             right: view.rightAnchor,
                             paddingTop: -20,
                             paddingRight: 16)
        
        let infoStack = UIStackView(arrangedSubviews: [infoLabel,
                                                      professionLabel,
                                                      bioLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 4
        view.addSubview(infoStack)
        infoStack.anchor(top: collectionView.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor,
                         paddingTop: 12,
                         paddingLeft: 12,
                         paddingRight: 12)
        configureBottomControls()
    }
    
    func configureBottomControls() {
        let stack = UIStackView(arrangedSubviews: [dislikeButton,
                                                  superlikeButton,
                                                  likeButton])
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.spacing = -32
        stack.setDimensions(height: 80, width: 300)
        stack.centerX(inView: view)
        stack.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                    paddingBottom: 32)
    }
    
    func createButton(withImage image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }
}
// MARK: - UICollectionViewDataSource
extension ProfileController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        user.imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if indexPath.row == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .blue
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: view.frame.width + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
