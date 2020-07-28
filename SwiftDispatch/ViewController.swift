//
//  ViewController.swift
//  SwiftDispatch
//
//  Created by jiang hua hu on 2020/7/28.
//  Copyright © 2020 xjjd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func toDispatchAction(_ sender: Any) {
        let dispatchVC = DispatchViewController()
        self.navigationController?.pushViewController(dispatchVC, animated: true)
    }
}

