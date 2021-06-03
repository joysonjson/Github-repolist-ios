//
//  RepoDetailsViewController.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import UIKit

class RepoDetailsViewController: UIViewController {
    
    private var repository: Repository?
    var idSelcted: Int = 0
    
    @IBOutlet weak var avatarImageView: CahcedImage!
    init?(coder: NSCoder, repository: Repository,idSelcted:Int) {
        super.init(coder: coder)
        self.repository = repository
        self.idSelcted = idSelcted
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.avatarImageView.downloadImageFrom(urlString: self.repository?.owner?.avatar_url?.absoluteString ?? "", imageMode: .center)
        avatarImageView.heroID = String(describing: idSelcted)
        enableHero()

    }
    override func viewWillDisappear(_ animated: Bool) {
        disableHero()
    }
    

}
