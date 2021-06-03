//
//  RepoListViewController.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import UIKit

class RepoListViewController: UIViewController {
    var selectedLanguage: String = ""
    let vm = RepoViewModel()
    var data: [Repository] = []
    init?(coder: NSCoder, selectedLanguage: String) {
        super.init(coder: coder)
        self.selectedLanguage = selectedLanguage
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
//        self.startConnection()
    }
    private func getData(){
        vm.getRepositories(langauge: self.selectedLanguage) { (res) in
            switch res {
            case .success(let results):
                self.data = results
            case .failure(let error):
                self.presentAlertWithTitle(title: "Alert", message: error.rawValue, options: [.ok]) { (_) in
                }
            }

        }
        
    }
    
}
