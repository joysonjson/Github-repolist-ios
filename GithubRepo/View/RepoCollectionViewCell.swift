//
//  RepoCollectionViewCell.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import UIKit


class RepoCollectionViewCell: UICollectionViewCell {

    let profileImage : RoundedImageView = {
        let image = RoundedImageView()
        return image
    }()
    private let titleLabel: Label = {
        let label = Label(frame: .zero)
        label.configure(size: .large, weight: .semibold, numberOfLines: 1)
        label.text = "This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf his is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf his is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: Label = {
        let label = Label(frame: .infinite,color: .gray)
        label.configure(size: .reqular, weight: .regular, numberOfLines: 0)
        label.text = "This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf his is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf his is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf This is not a mmoney  asdfdsf"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        
    }
    func addViews(){
        self.contentView.addSubview(profileImage)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)

        profileImage.anchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), size: CGSize(width: 80, height: 80))
        titleLabel.anchor(top: profileImage.bottomAnchor, leading:  self.contentView.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0),size: CGSize(width: self.frame.width - 15, height: 40))

        descriptionLabel.anchor(top: self.titleLabel.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 3, left: 15, bottom: 5, right: 5))
        descriptionLabel.preferredMaxLayoutWidth = self.frame.size.width
        self.contentView.backgroundColor = .systemBackground
      
     
        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.shadowDecorate()
        self.contentView.roundCorners(corners: [.topLeft], radius: 20)
    }
    func configure(image: String,title: String, description: String){
        profileImage.downloadImageFrom(urlString: image, imageMode: .center)
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
