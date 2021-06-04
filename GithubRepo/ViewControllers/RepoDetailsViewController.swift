//
//  RepoDetailsViewController.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import UIKit
enum DetailsToShowOptions:String, CaseIterable  {
    case fullName = "Full Name"
    case description = "Description"
    case stars = "Stars"
    case forks = "Forks"
    case lastUpdated = "Last Updated"
}


class RepoDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsTableView: UITableView!
    private var repository: Repository?
    private var contributors: [Contributer] = []
    private var comemnts: [Comment] = []
    private var issues: [Issue] = []

    private let cellId = "cellId"
    var idSelcted: Int = 0
    private var dataToDispaly:[DetailsToShowOptions] = DetailsToShowOptions.allCases
    let vm = RepoDetailsViewModel()
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
        getApiData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 60
        detailsTableView.sectionHeaderHeight = UITableView.automaticDimension
        detailsTableView.estimatedSectionHeaderHeight = 60
        enableHero()

    }
    override func viewWillDisappear(_ animated: Bool) {
        disableHero()
    }
    func getApiData(){
        vm.getDetailsData(contributeUrl: self.repository?.contributors_url?.absoluteString, issueUrl: self.repository?.issues_url, commentsUrl: self.repository?.comments_url) { (status, contributer, issues, comments) in
            
            self.contributors = contributer
            self.comemnts = comments
            self.issues = issues
            self.detailsTableView.reloadData()
            debugPrint(self.contributors,self.comemnts,self.issues)
        }
    
    }
}

extension RepoDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.dataToDispaly.count : 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        let opt = self.dataToDispaly[indexPath.row]
        cell.textLabel?.text = opt.rawValue
        cell.detailTextLabel?.text = vm.getValue(type: opt, repo: self.repository)
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section != 0 ) { return nil}
        let imag = CachedImageView(frame: .zero)
        imag.contentMode = .scaleAspectFit
        imag.downloadImageFrom(urlString: self.repository?.owner?.avatar_url?.absoluteString ?? "", imageMode: .center) 
        imag.heroID = String(describing: idSelcted)
        imag.fillSuperview()
        imag.centerXInSuperview()
        return imag
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func didReceiveMemoryWarning() {
        imageCache.removeAllObjects()
    }
}

extension RepoDetailsViewController: UITableViewDelegate{
    
}
