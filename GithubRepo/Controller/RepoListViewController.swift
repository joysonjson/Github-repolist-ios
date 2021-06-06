//
//  RepoListViewController.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import UIKit
import Hero

/**
 RepoListViewController shows the list of repositoories for a language in collection view based on sort selected option

 # Notes: #
 1. Parameters must be **selectedLanguage**  sent though init
*/

class RepoListViewController: UIViewController {
    var selectedLanguage: String = ""
    let vm = RepoViewModel()
    var data: [Repository] = []
    var incompleteResult : Bool = false
    private var page = 1
    
    @IBOutlet weak var repoCollectionView: UICollectionView!
    init?(coder: NSCoder, selectedLanguage: String) {
        super.init(coder: coder)
        self.selectedLanguage = selectedLanguage
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    // current selected sort options default it is stars
    private var sortOption: SortOption = .stars {
        didSet {
            self.page = 1
            self.getData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repoCollectionView.register(RepoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RepoCollectionViewCell.self))
        self.setUp()
        self.setupNavigationBarItem()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        enableHero()
        self.title = self.selectedLanguage
    }
    override func viewWillDisappear(_ animated: Bool) {
        disableHero()
    }
    
// layout of collectionview setup
    private func setUp(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let pad: CGFloat = UIDevice.isPhone ? 7 : 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: pad, bottom: 0, right: pad)
        let dime = self.view.frame.width > self.view.frame.height ? self.view.frame.height : self.view.frame.width
        layout.itemSize = CGSize(width:dime/3 - 16, height: dime/3)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = UIDevice.isPad ? 25 : 10
        self.repoCollectionView.collectionViewLayout = layout
    }

//     bar item to open sorting options
    private func setupNavigationBarItem() {
        let barButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(openFilter(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    //    Funcation called clicking on sort bar item
    @objc private func openFilter(_ sender: Any) {
        self.showAlertController(title: "Sort Based On", options: SortOption.allCases) { ( opted) in
            self.sortOption = opted
        }
    }
   // api call  of the repositories and then reloads the collectionview
    private func getData(){
        vm.getRepositories(langauge: self.selectedLanguage, sort: sortOption.rawValue,page:self.page) { (status,repositories,error) in
            if (status){
                if (self.page == 1){
                    self.data = repositories?.items ?? []
                    self.incompleteResult = !(repositories?.incomplete_results ?? false)
                    if (repositories?.items?.count == 0) {
                        self.presentAlertWithTitle(title: "Error", message: "Unable to find result for the language", options: [.ok]) { (_) in
                        }
                    }
                }else{
                    self.data.append(contentsOf: repositories?.items ?? [])
                    self.incompleteResult = !(repositories?.incomplete_results ?? false)

                }
                DispatchQueue.main.async {
                    self.repoCollectionView.reloadData()
                }
            }else{
                if (self.page == 1){
                    DispatchQueue.main.async {
                        self.presentAlertWithTitle(title: "Error", message: error ?? "", options: [.ok]) { (_) in
                            self.navigationController?.popViewController(animated: true)

                        }
                    }
                }
            }
        }
    }
}
extension RepoListViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RepoCollectionViewCell
        cell.profileImage.heroID = String(describing: indexPath.row)
        guard let vc = storyboard?.instantiateViewController(identifier: String(describing: RepoDetailsViewController.self), creator: { coder in
            return RepoDetailsViewController(coder: coder, repository: self.data[indexPath.row], idSelcted: indexPath.row)
          }) else {
              fatalError("Failed to load RepoListViewController from storyboard.")
          }

        self.showHero(vc, navigationAnimationType: .selectBy(presenting:.zoom, dismissing:.zoomOut))
    }
    
}
extension RepoListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RepoCollectionViewCell.self), for: indexPath) as! RepoCollectionViewCell
        let item = self.data[indexPath.row]
        cell.configure(image:  item.owner?.avatar_url, title: item.name ?? "", description: item.description ?? "")
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.repoCollectionView.contentOffset.y >= (self.repoCollectionView.contentSize.height - self.repoCollectionView.bounds.size.height)) {
            if incompleteResult{
                page = page + 1
                self.getData()
            }
        }
    }
}
