//
//  RepoDetailsViewController.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import UIKit
import SDWebImage
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
        self.title = self.repository?.name
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
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.detailsTableView.reloadData()
            })
        }
    }
}

extension RepoDetailsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.dataToDispaly.count
        case 1:
            return self.contributors.count
        case 2:
            return self.issues.count
        case 3:
            return self.comemnts.count
        default:
            return 0
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if (self.contributors.count > 0 || self.issues.count > 0 || self.comemnts.count > 0){
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        let opt = self.dataToDispaly[indexPath.row]
        let (title,description,attr) = vm.getValue(type: opt, repo: self.repository,contributers: self.contributors, comments: self.comemnts, issues: self.issues, indexPath: indexPath)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = description
        if let body = attr{
            cell.detailTextLabel?.attributedText = body
            
        }
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension

    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let imag = CachedImageView(frame: .zero)
            imag.contentMode = .scaleAspectFit
            imag.sd_setImage(with: self.repository?.owner?.avatar_url, completed: nil)
            imag.heroID = String(describing: idSelcted)
            return imag
        case 1:
            if (self.contributors.count == 0 ) { return nil}
            return self.getHeaderLabel(text: "Contributors")
        case 2:
            if (self.issues.count == 0 ) { return nil}
            return self.getHeaderLabel(text: "Issues")

        case 3:
            if (self.comemnts.count == 0 ) { return nil}
               return self.getHeaderLabel(text: "Comments")
        default:
            return nil
        }
      
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

extension RepoDetailsViewController{
    func getHeaderLabel(text: String)->Label{
        let label = Label()
        label.configure(size: .largest, weight: .heavy, numberOfLines: 0)
        label.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 0))
        label.text = text
        return label
    }
}
