//
//  Label.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
import UIKit

public class Label: UILabel {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public convenience init(frame: CGRect,color:UIColor = .label  ,bgColor: UIColor = .clear,borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) {
        self.init(frame: frame)
        self.clipsToBounds = true
        self.textColor = color
        self.backgroundColor = bgColor
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }
    func configure(size: fontSize = .medium ,weight: UIFont.Weight = .regular, numberOfLines: Int = 1 ){
        self.font = UIFont.setFont(weight, size: size.rawValue)
        if numberOfLines != 1 {
            self.lineBreakMode = .byWordWrapping
            self.numberOfLines = numberOfLines
        }else{
            self.lineBreakMode = .byTruncatingTail
        }
    }
}
