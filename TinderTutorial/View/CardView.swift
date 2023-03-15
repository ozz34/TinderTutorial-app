//
//  CardView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

// MARK: - CardViewDelegate
protocol CardViewDelegate: AnyObject {
    func cardView(_ view: CardView, wantsToShowProfileFor user: User)
    func cardView(_ view: CardView, didLikeUser: Bool)
}

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

final class CardView: UIView {
    // MARK: - Properties
    var viewModel: CardViewModel
    weak var delegate: CardViewDelegate?
    
    private let gradientLayer = CAGradientLayer()
    private lazy var barStackView = SegmentedBarView(numberOfSegments: viewModel.imageURLs.count)

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = viewModel.userInfoText
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "info_icon")?
            .withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self,
                         action: #selector(handleShowProfile),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        configureGestureRecognizers()
        
        imageView.sd_setImage(with: viewModel.imageUrl)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        configureBarStackView()
        configureGradientLayer()
        
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingLeft: 16,
                         paddingBottom: 16,
                         paddingRight: 16)
        
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor,
                          paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    // MARK: - Actions
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
    }
    
    @objc func handleChangePhoto(sender: UITapGestureRecognizer) {
        let location = sender.location(in: nil).x
        let shouldNextPhoto = location > self.frame.width / 2
        if shouldNextPhoto {
            viewModel.showNextPhoto()
        } else {
            viewModel.showPreviousPhoto()
        }
        imageView.sd_setImage(with: viewModel.imageUrl)
        
        barStackView.setHighlighted(index: viewModel.index)
    }
    
    @objc func handleShowProfile() {
        delegate?.cardView(self, wantsToShowProfileFor: viewModel.user)
    }
    
    // MARK: - Helpers
    private func panCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationTranform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTranform.translatedBy(x: translation.x, y: translation.y)
    }
    
    private func resetCardPosition(sender: UIPanGestureRecognizer) {
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut, animations: {
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
            } else {
                self.transform = .identity
            }
        }) { _ in
            if shouldDismissCard {
                let didLike = direction == .right
                self.delegate?.cardView(self, didLikeUser: didLike)
            }
        }
    }
    
    private func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    private func configureGestureRecognizers() {
        let pan = UIPanGestureRecognizer(target: self,
                                         action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
    
    private func configureBarStackView() {
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor,
                            left: leftAnchor,
                            right: rightAnchor,
                            paddingTop: 8,
                            paddingLeft: 8,
                            paddingRight: 8,
                            height: 4)
    }
}
