//
//  RepoListViewController.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import UIKit

class RepoListViewController: UIViewController {
    var selectedLanguage: String = ""
    
    init?(coder: NSCoder, selectedLanguage: String) {
        self.selectedLanguage = selectedLanguage
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
