//
//  HomeController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 28.02.2023.
//

import UIKit

class HomeController: UIViewController {
    // MARK: - Properties
    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    
    private let deckView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        
        return view
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCards()
    }
    
    // MARK: - Helpers
    func configureCards() {
        let user1 = User(name: "Jane Doe", age: 22, images: [#imageLiteral(resourceName: "jane1"), #imageLiteral(resourceName: "jane2")])
        let user2 = User(name: "Megan", age: 21, images: [#imageLiteral(resourceName: "kelly3"), #imageLiteral(resourceName: "kelly1")])
        let viewModel1 = CardViewModel(user: user1)
        let viewModel2 = CardViewModel(user: user2)
        
        let cardView1 = CardView(viewModel: viewModel1)
        let cardView2 = CardView(viewModel: viewModel2)
        
        deckView.addSubview(cardView1)
        cardView1.fillSuperview()
        deckView.addSubview(cardView2)
        cardView2.fillSuperview()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [topStack,
                                                   deckView,
                                                   bottomStack])
        stack.axis = .vertical
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,
                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                     right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        stack.bringSubviewToFront(deckView)
    }
}
