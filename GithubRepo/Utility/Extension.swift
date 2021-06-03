//
//  Extension.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)

    }
    private var mainStoryBoard:UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main)
    }
    func getViewController<T:UIViewController> (with title:String = "") -> T {
        let string = String.init(describing: T.self)
        let myViewController = self.mainStoryBoard.instantiateViewController(withIdentifier: string)
        myViewController.title = title
        return myViewController as! T
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
}
