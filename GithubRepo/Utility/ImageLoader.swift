//
//  ImageLoader.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
import UIKit

class CahcedImage: UIImageView {

    // MARK: - Constants

    let imageCache = NSCache<NSString, AnyObject>()

    // MARK: - Properties

    var imageURLString: String?

    func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }

    func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            let req = HttpCreateRequest().createRequest(httpMethod: .get, url: url)
            NetworkSession().call(with: req) { (response, data, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
            }
            
        }
    }
}
