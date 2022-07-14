//
//  ViewController.swift
//  VkBootcamp
//
//  Created by Daniel on 13.07.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var apps = [Service]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Сервисы VK"
        
        view.addSubview(tableView)
        
        setupTableView()
        settingConstraints()
        fetchApps()
    }
    
    
    private func fetchApps() {
        NetworkService.shared.fetchAppsData("https://publicstorage.hb.bizmrg.com/sirius/result.json") { [weak self] result in
            switch result {
            case .success(let data):
                self?.apps = data.body.services
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.alert(title: "Error", text: error.rawValue)
            }
        }
    }
    
    private func setupTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
    }
    
    private func settingConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let app = apps[indexPath.row]
        
        cell.appName.text = app.appName
        cell.appDescription.text = app.appDescription
        cell.appIcon.load(url: app.iconUrl) { [weak cell] in
            guard let cell = cell else { return }
            cell.activityIndicator.stopAnimating()
        }

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let app = apps[indexPath.item]
        let application = UIApplication.shared
        
        let appUrl = URL(string: "\(Constants.urls[indexPath.item])://")
        let safariURL = URL(string: app.appLink)
        
        if let appUrl = appUrl, application.canOpenURL(appUrl)  {
            application.open(appUrl)
        } else {
            if let safariURL = safariURL {
                let safariVC = SFSafariViewController(url: safariURL)
                present(safariVC, animated: true)
            }
        }
    }
    

}





