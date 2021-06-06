//
//  ViewController.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import UIKit

/**

 # Notes: #
 1. Inital View Controller
 2. Launch all View controller from storyboard

*/
class ViewController: UIViewController {

    @IBOutlet weak var programNameTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func searchAction(_ sender: UIButton) {
        let validation = ProgrammingLanguageValidation().validate(langauge: self.programNameTextField.text)
        if validation.success{
            guard let vc = storyboard?.instantiateViewController(identifier:  String(describing: RepoListViewController.self), creator: { coder in
                return RepoListViewController(coder: coder, selectedLanguage: validation.value!)
              }) else {
                  fatalError("Failed to load RepoListViewController from storyboard.")
              }
            self.push(viewController: vc)
        }else{
            self.presentAlertWithTitle(title: "Error", message: validation.error ?? "", options: [.ok]) { (_) in
            }
        }
    }
    

}

