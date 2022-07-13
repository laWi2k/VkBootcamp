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
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        settingConstraints()
        fetchApps()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    
    private func fetchApps() {
        NetworkService.shared.parseJson("https://publicstorage.hb.bizmrg.com/sirius/result.json") { [weak self] result in
            switch result {
            case .success(let data):
                self?.apps = data.body.services
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let app = apps[indexPath.row]
        
        
        cell.appName.text = app.appName
        cell.appDescription.text = app.appDescription
        cell.appIcon.load(url: app.iconUrl)
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let urlSchemes = [
            "vk",
            "mygamesapp",
            "sferum",
            "youla",
            "samokat",
            "citydrive",
            "ru.mail.cloud",
            "vseapteki",
            "ru.mail.calendar"
        ]
        
        let app = apps[indexPath.item]
        let application = UIApplication.shared
        
        let appUrl = URL(string: "\(urlSchemes[indexPath.item])://")
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
    
    
    
    
    
    @objc func settingConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}

extension UIImageView {
    func load(url: String) {
        if let url = URL(string: url){
            DispatchQueue.global().async {
                [weak self] in
                if let data = try? Data (contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}





