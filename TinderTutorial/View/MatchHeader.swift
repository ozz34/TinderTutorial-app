//
//  MatchHeader.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 14.03.2023.
//

import UIKit

class MatchHeader: UICollectionReusableView {
    // MARK: - Properties
    private let identifier = "MatchCell"
    
    private let newMatchesLabel: UILabel = {
        let label = UILabel()
        label.text = "New matches"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(MatchCell.self, forCellWithReuseIdentifier: identifier)
        
        return cv
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(newMatchesLabel)
        newMatchesLabel.anchor(top: topAnchor,
                               left: leftAnchor,
                               paddingTop: 12,
                               paddingLeft: 12)
        addSubview(collectionView)
        collectionView.anchor(top: newMatchesLabel.bottomAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              right: rightAnchor,
                              paddingTop: 4,
                              paddingLeft: 12,
                              paddingBottom: 24,
                              paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - UICollectionViewDataSource
extension MatchHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MatchCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MatchHeader: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MatchHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 80, height: 108)
    }
}
