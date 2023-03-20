//
//  MessagesController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 14.03.2023.
//

import UIKit

final class MessagesController: UITableViewController {
    // MARK: - Properties
    private let user: User
    private let identifier = "MessageCell"
    private let headerView = MatchHeader()
    
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
        configureTableView()
        configureNavigationBar()
        fetchMatches()
    }
    
    // MARK: - Actions
    @objc func handleDismissal() {
        dismiss(animated: true)
    }
   
    // MARK: - API
    private func fetchMatches() {
        Service.fetchMatches { [weak self] matches in
            self?.headerView.matches = matches
        }
    }
    
    // MARK: - Helpers
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
        
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.frame.width,
                                  height: 200)
        tableView.tableHeaderView = headerView
        headerView.delegate = self
    }

    private func configureNavigationBar() {
        let leftButton = UIImageView()
        leftButton.setDimensions(height: 28, width: 28)
        leftButton.isUserInteractionEnabled = true
        leftButton.image = UIImage(named: "app_icon")?
            .withRenderingMode(.alwaysTemplate)
        leftButton.tintColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleDismissal))
        leftButton.addGestureRecognizer(tap)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        let icon = UIImageView(image: UIImage(named: "top_right_messages")?
            .withRenderingMode(.alwaysTemplate))
        icon.tintColor = .systemPink
        navigationItem.titleView = icon
    }
}

// MARK: - UITableViewDataSource
extension MessagesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MessagesController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        label.text = "Messages"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        view.addSubview(label)
        label.centerY(inView: view,
                      leftAnchor: view.leftAnchor,
                      paddingLeft: 12)
        return view
    }
}

// MARK: - MatchHeaderDelegate
extension MessagesController: MatchHeaderDelegate {
    func matchHeader(_ header: MatchHeader, wantsToStartChatWith uid: String) {
        Service.fetchUser(withUid: uid) { user in
            print("Start chat message with: \(user.name)")
        }
    }
}
