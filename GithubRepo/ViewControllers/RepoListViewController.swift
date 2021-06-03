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
    
    @IBOutlet weak var repoCollectionView: UICollectionView!
    init?(coder: NSCoder, selectedLanguage: String) {
        super.init(coder: coder)
        self.selectedLanguage = selectedLanguage
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        getData()
    }
    private func setUp(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
             layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.bounds.width/3 - 16, height: 200)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = UIDevice.isPad ? 25 : 10
        self.repoCollectionView.collectionViewLayout = layout
        self.repoCollectionView.register(RepoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RepoCollectionViewCell.self))
 
    }
   
    private func getData(){
        vm.getRepositories(langauge: self.selectedLanguage) { (res) in
            switch res {
            case .success(let results):
                self.data = results
                DispatchQueue.main.async {
                    self.repoCollectionView.reloadData()
                }
            case .failure(let error):
                self.presentAlertWithTitle(title: "Alert", message: error.rawValue, options: [.ok]) { (_) in
                }
            }

        }
        
    }
    
}
extension RepoListViewController:UICollectionViewDelegate{
    
}
extension RepoListViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RepoCollectionViewCell.self), for: indexPath) as! RepoCollectionViewCell
        let item = self.data[indexPath.row]
        cell.configure(image:  item.owner?.avatar_url?.absoluteString ?? "", title: item.name ?? "", description: item.description ?? "")
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 0) {
            self.navigationController?.navigationBar.barTintColor = .white
        } else {
            self.navigationController?.navigationBar.barTintColor = .clear
        }
    }
    
}
