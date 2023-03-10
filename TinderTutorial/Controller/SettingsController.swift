//
//  SettingsController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 05.03.2023.
//

import UIKit
import JGProgressHUD

protocol SettingsControllerDelegate: AnyObject {
    func settingsController(_ controller: SettingsController,
                            wantsToUpdate user: User)
}

class SettingsController: UITableViewController {
    // MARK: - Properties
    private var user: User
    
    private lazy var headerView = SettingsHeader(user: user)
    private let imagePicker = UIImagePickerController()
    private var imageIndex = 0
    
    private let identifier = "SettingsCell"
    
    weak var delegate: SettingsControllerDelegate?
    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
    }
    
    // MARK: - Actions
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        view.endEditing(true)
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Saving Your Data"
        hud.show(in: view)
        Service.saveUserData(user: user) { error in
            self.delegate?.settingsController(self, wantsToUpdate: self.user)
        }
    }
    
    // MARK: - API
    func uploadImage(image: UIImage) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Saving Image"
        hud.show(in: view)
        
        Service.uploadImage(image: image) { imageUrl in
            self.user.imageURLs.append(imageUrl)
            hud.dismiss()
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        tableView.register(SettingsCell.self, forCellReuseIdentifier: identifier)
        
        imagePicker.delegate = self
        
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        tableView.separatorStyle = .none
        
        tableView.tableHeaderView = headerView
        tableView.backgroundColor = .systemGroupedBackground
        headerView.delegate = self
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
    }
    
    func setHeaderImage(_ image: UIImage) {
        headerView.buttons[imageIndex].setImage(image.withRenderingMode(.alwaysOriginal),
                                                for: .normal)
    }
}

// MARK: - SettingsHeaderDelegate
extension SettingsController: SettingsHeaderDelegate {
    func settingsHeader(_ header: SettingsHeader, didSelect index: Int) {
        self.imageIndex = index
        present(imagePicker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        uploadImage(image: selectedImage)
        setHeaderImage(selectedImage)
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SettingsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        SettingsSections.allCases.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SettingsCell else { return UITableViewCell() }
        guard let section = SettingsSections(rawValue: indexPath.section) else { return cell }
        let viewModel = SettingsViewModel(user: user, section: section)
        cell.viewModel = viewModel
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = SettingsSections(rawValue: indexPath.section) else { return 0 }
        
        return section == .ageRange ? 96 : 44
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = SettingsSections(rawValue: section) else { return nil }
        
        return section.description
    }
}

// MARK: - SettingsCellDelegate
extension SettingsController: SettingsCellDelegate {
    func settingsCell(_ cell: SettingsCell, wantsToUpdateAgeRangeWith sender: UISlider) {
        if sender == cell.minAgeSlider {
            user.minSeekingAge = Int(sender.value)
        } else {
            user.maxSeekingAge = Int(sender.value)
        }
    }

    func settingsCell(_ cell: SettingsCell,
                      wantsToUpdateUserWith value: String,
                      forSection section: SettingsSections) {

        switch section {
        case .name:
            user.name = value
        case .profession:
            user.profession = value
        case .age:
            user.age = Int(value) ?? 0
        case .bio:
            user.bio = value
        case .ageRange:
            break
        }
    }
}
