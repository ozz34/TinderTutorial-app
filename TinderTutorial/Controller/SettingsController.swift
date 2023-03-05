//
//  SettingsController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 05.03.2023.
//

import UIKit

class SettingsController: UITableViewController {
    // MARK: - Properties
    private let headerView = SettingsHeader()
    private let imagePicker = UIImagePickerController()
    private var imageIndex = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureUI()
    }
    
    // MARK: - Actions
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        print("done")
    }
    
    // MARK: - Helpers
    func configureUI() {
        imagePicker.delegate = self
        
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        tableView.separatorStyle = .none
        
        tableView.tableHeaderView = headerView
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
        setHeaderImage(selectedImage)
        dismiss(animated: true)
    }
}
