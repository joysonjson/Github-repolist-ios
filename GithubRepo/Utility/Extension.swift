//
//  Extension.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
import UIKit
import Hero
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)

    }

    func push(viewController:UIViewController) {
        guard let navigation = self.navigationController else {
            return
        }
        navigation.pushViewController(viewController, animated: true)
    }
    func presentAlertWithTitle(title: String, message: String, options: [AlertOptions], completion: @escaping (AlertOptions) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option.rawValue, style: .default, handler: { (action) in
                completion(options[index])
            }))
        }
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)

        }
    }
    // call this in viewWillDisappear(animated:) in the destination view controller when you leave the SHero enabled view controller and you want to disable SHero
    // already added in SViewController
    func disableHero() {
        navigationController?.hero.isEnabled = false
    }
    
    // call this in viewWillAppear(animated:) if you're coming from a view controller that has SHero disabled into a view controller that needs SHero enabled
    // needed if you can navigate back to this view controller with the navigationItem back button
    // already added in SViewController
    func enableHero() {
        hero.isEnabled = true
        navigationController?.hero.isEnabled = true
    }
    
    func showHero(_ viewController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        viewController.hero.isEnabled = true
        navigationController?.hero.isEnabled = true
        navigationController?.hero.navigationAnimationType = navigationAnimationType
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension URLRequest{
    mutating func addBody(param:[String:Any]?){
        let requestData = try? JSONSerialization.data(withJSONObject: param, options: [])
        self.httpBody = requestData
    }

    mutating func addBody(formdata:[String:Any]?){
        guard let data = formdata else { return  }
        let jsonString = data.reduce("") { "\($0)\($1.0)=\($1.1)&" }
        self.httpBody = jsonString.data(using: .utf8, allowLossyConversion: false)!
    }
    
}


extension UINavigationController {
    func show(_ viewController: UIViewController, navigationAnimationType: HeroDefaultAnimationType = .autoReverse(presenting: .slide(direction: .leading))) {
        viewController.hero.isEnabled = true
        hero.isEnabled = true
        hero.navigationAnimationType = navigationAnimationType
        pushViewController(viewController, animated: true)
    }
}

public extension URL {
    func queryItems(_ key: String, value: String?) -> URL {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // Create query item
        let queryItem = URLQueryItem(name: key, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        return urlComponents.url!
    }
}

extension UICollectionViewCell {
    func shadowDecorate() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
  
}


public enum fontSize: CGFloat  {
    case small =  12
    case reqular = 14
    case medium = 16
    case large = 18
    case largest = 20
}


public extension UIDevice {
    class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}


public extension UIFont {
    static func setFont(_ weight: UIFont.Weight = .regular, size: CGFloat = 14) -> UIFont {
        if UIDevice.isPad{
            return .systemFont(ofSize: size * 1.4 , weight: weight)
        }
        return .systemFont(ofSize: size, weight: weight)
    }
}

public extension String{
    func getDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:SSZ"
        //        2021-06-03T18:45:25Z
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy h:mm a"  //"MMM d, h:mm a" for  Sep 12, 2:11 PM
        guard let date = dateFormatterGet.date(from: self) else {return ""}
        return dateFormatterPrint.string(from: date)
    }
    
    func correctUrl()-> String{
        return replacingOccurrences(of: "\\s?\\{/[\\w\\s]*\\}", with: "", options: .regularExpression)
    }
    
    
}
