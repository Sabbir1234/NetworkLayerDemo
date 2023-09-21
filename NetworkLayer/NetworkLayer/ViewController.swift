//
//  ViewController.swift
//  NetworkLayer
//
//  Created by Sabbir Hossain on 19/9/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.login(email: "test@gmail.com", password: "myPassword") { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

