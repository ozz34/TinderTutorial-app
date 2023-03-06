//
//  SettingsCell.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 06.03.2023.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        backgroundColor = .systemBlue
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
