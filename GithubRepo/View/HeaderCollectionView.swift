//
//  HeaderCollectionView.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import Foundation
import UIKit
class HeaderView: UICollectionReusableView {
    
    let imageView: CachedImageView = {
        let iv = CachedImageView(image: #imageLiteral(resourceName: "stretchy_header"))
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code for layout
        
        backgroundColor = .red
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    func setImage(url: String){
        self.imageView.downloadImageFrom(urlString: url, imageMode: .center)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
