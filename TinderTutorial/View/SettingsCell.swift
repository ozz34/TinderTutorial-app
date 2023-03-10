//
//  SettingsCell.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 06.03.2023.
//

import UIKit

protocol SettingsCellDelegate: AnyObject {
    func settingsCell(_ cell: SettingsCell,
                      wantsToUpdateUserWith value: String,
                      forSection section: SettingsSections)
    func settingsCell(_ cell: SettingsCell,
                      wantsToUpdateAgeRangeWith sender: UISlider)
}

class SettingsCell: UITableViewCell {
    // MARK: - Properties
    var viewModel: SettingsViewModel! {
        didSet {
            configureUI()
        }
    }
    
    weak var delegate: SettingsCellDelegate?
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        tf.leftView = paddingView
        tf.leftViewMode = .always
       
        tf.addTarget(self,
                     action: #selector(handleUpdateUserInfo),
                     for: .editingDidEnd)
        
        return tf
    }()
    
    var sliderStack = UIStackView()
    
    let minAgeLabel = UILabel()
    let maxAgeLabel = UILabel()
    
    lazy var minAgeSlider = createAgeRangeSlider()
    lazy var maxAgeSlider = createAgeRangeSlider()
    
    // MARK: - Lyfecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(inputField)
        inputField.fillSuperview()
        
        let minStack = UIStackView(arrangedSubviews: [minAgeLabel,
                                                     minAgeSlider])
        minStack.spacing = 24
        
        let maxStack = UIStackView(arrangedSubviews: [maxAgeLabel,
                                                     maxAgeSlider])
        maxStack.spacing = 24
        
        sliderStack = UIStackView(arrangedSubviews: [minStack,
                                                         maxStack])
        sliderStack.axis = .vertical
        sliderStack.spacing = 16
        
        contentView.addSubview(sliderStack)
        sliderStack.centerX(inView: self)
        sliderStack.anchor(left: leftAnchor,
                           right: rightAnchor,
                           paddingLeft: 24,
                           paddingRight: 24)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func handleAgeRangeChanged(sender: UISlider) {
        if sender == minAgeSlider {
            minAgeLabel.text = viewModel.minAgeLabelText(forValue: sender.value)
        } else {
            maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: sender.value)
        }
        delegate?.settingsCell(self, wantsToUpdateAgeRangeWith: sender)
    }
    
    @objc func handleUpdateUserInfo(sender: UITextField) {
        guard let value = sender.text else { return }
        delegate?.settingsCell(self,
                               wantsToUpdateUserWith: value,
                               forSection: viewModel.section)
    }
    
    //MARK: - Helpers
    func createAgeRangeSlider() -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 18
        slider.maximumValue = 60
        
        slider.addTarget(self,
                         action: #selector(handleAgeRangeChanged),
                         for: .valueChanged)
        return slider
    }
    
    func configureUI() {
        inputField.isHidden = viewModel.shouldHideInputField
        sliderStack.isHidden = viewModel.shouldHideSlider
        
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
        
        minAgeLabel.text = viewModel.minAgeLabelText(forValue: viewModel.minAgeSliderValue)
        maxAgeLabel.text = viewModel.maxAgeLabelText(forValue: viewModel.maxAgeSliderValue)
        
        minAgeSlider.setValue(viewModel.minAgeSliderValue, animated: true)
        maxAgeSlider.setValue(viewModel.maxAgeSliderValue, animated: true)
    }
}
