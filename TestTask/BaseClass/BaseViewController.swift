//
//  BaseViewController.swift
//  TestTask
//
//  Created by Ashish Yadav on 09/09/23.
//

import UIKit

class BaseViewController: UIViewController {

    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var loadingView: UIView = UIView()
    var reachability: Reachability!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetwork()
        
    }
    func setBgColor() {
            FirebaseConfigBGColor.sharedInstance.fetchCloudValues { [weak self] colorHex in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.view.backgroundColor = UIColor().colorFromHexString(colorHex)
                }
               
            }
    }
    func checkNetwork() {
       if !Reachability().isConnectedToNetwork() {
           showAlert(message: "Network not available", title: "Alert")
       } else {
           setBgColor()
       }
    }
    func showAlert(message: String , title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            self.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    func showActivityIndicator() {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = .lightGray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
        
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
            
    }
}
