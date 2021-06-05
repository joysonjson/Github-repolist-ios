//
//  RepoCollectionViewCell.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import UIKit
import SDWebImage

class RepoCollectionViewCell: UICollectionViewCell {

    let profileImage : RoundedImageView = {
        let image = RoundedImageView()
        return image
    }()
    private let titleLabel: Label = {
        let label = Label(frame: .zero)
        label.configure(size: .large, weight: .semibold, numberOfLines: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let descriptionLabel: Label = {
        let label = Label(frame: .infinite,color: .gray)
        label.configure(size: .reqular, weight: .regular, numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
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
    
        profileImage.anchor(top: self.contentView.topAnchor, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: UIDevice.isPad ? 120 : 60, height:UIDevice.isPad ? 120 : 60))
        profileImage.centerXInSuperview()
        titleLabel.anchor(top: profileImage.bottomAnchor, leading:  self.contentView.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15),size: CGSize(width: self.frame.width - 30, height: 40))

        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading:  self.contentView.leadingAnchor, bottom: self.contentView.bottomAnchor, trailing: nil,padding: UIEdgeInsets(top: 0, left: 15, bottom: 6, right: 15))
        descriptionLabel.preferredMaxLayoutWidth = self.frame.size.width - 30
        self.contentView.backgroundColor = .systemBackground
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.shadowDecorate()
        self.contentView.roundCorners(corners: [.topLeft], radius: 20)
    }
    func configure(image: URL?,title: String, description: String){
        profileImage.sd_setImage(with: image, completed: nil)
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
