//
//  ComplexGrid.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import Foundation

import UIKit

class ComplexGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        
        switch indexPath.row%2 {
        case 0:
            cell.backgroundColor = .blue
        case 1:
            cell.backgroundColor = .yellow
        default:
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    
    var collectionView: UICollectionView! = nil
    fileprivate let headerId = "headerId"
    fileprivate let padding: CGFloat = 16

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        
    }
   
    
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayoutDiffSection())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        header.setImage(url: "https://images.unsplash.com/photo-1622744929532-af45c7d4a77d?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60")
        return header
    }
  
    
}
extension ComplexGridViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 2)
        
        group.interItemSpacing = .fixed(CGFloat(10))
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    func createLayoutDiffSection() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var columns = 1
            switch sectionIndex{
            case 0:
                columns = 1
            case 2:
                columns = Int(self.view.frame.width / 100)
            case 3:
                columns = Int(self.view.frame.width / 150)
            default:
                columns = Int(self.view.frame.width / 200)
                
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupHeight = columns == 1 ?
                NSCollectionLayoutDimension.absolute(44) :
                NSCollectionLayoutDimension.fractionalWidth(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }

    
}
