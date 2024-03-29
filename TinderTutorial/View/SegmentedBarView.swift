//
//  SegmentedBarView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 12.03.2023.
//

import UIKit

final class SegmentedBarView: UIStackView {
    // MARK: - Lifecycle
    init(numberOfSegments: Int) {
        super.init(frame: .zero)

        (0 ..< numberOfSegments).forEach { _ in
            let barView = UIView()
            barView.backgroundColor = .barDeselectedColor
            addArrangedSubview(barView)
        }
        spacing = 4
        distribution = .fillEqually
        arrangedSubviews.first?.backgroundColor = .white
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    func setHighlighted(index: Int) {
        arrangedSubviews.forEach { $0.backgroundColor = .barDeselectedColor }
        arrangedSubviews[index].backgroundColor = .white
    }
}
