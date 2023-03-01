//
//  CardView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

class CardView: UIView {
    // MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "jane1")
        
        return iv
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "Jane Doe",
                                                       attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy),.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "  20", attributes: [.font: UIFont.systemFont(ofSize: 24),.foregroundColor: UIColor.white]))
        label.attributedText = attributedText
        
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "info_icon")?.withRenderingMode(.alwaysOriginal),
                        for: .normal)

        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureGestureRecognizers()
        
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
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
            print("began")
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
    }
    
    @objc func handleChangePhoto(sender: UITapGestureRecognizer) {

    }
    
    // MARK: - Helpers
    private func panCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationTranform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTranform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer) {
        UIView.animate(withDuration: 0.75,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { _ in
            print("complete")
        }
    }
    
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    
    func configureGestureRecognizers() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
}
