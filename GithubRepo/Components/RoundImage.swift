//
//  RoundImage.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = self.frame.width/2.0
        self.contentMode = .scaleAspectFill
        layer.cornerRadius = radius
        clipsToBounds = true
        
    }

}
