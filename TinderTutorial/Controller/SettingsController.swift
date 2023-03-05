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
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        tableView.separatorStyle = .none
        
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
    }
}
