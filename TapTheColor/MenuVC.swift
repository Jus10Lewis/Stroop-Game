//
//  MenuVC.swift
//  TapTheColor
//
//  Created by Justin Lewis on 12/4/18.
//  Copyright © 2018 Justin Lewis. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var highScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let highScore = UserDefaults.standard.integer(forKey: "highScore")
        highScoreLabel.text = "Current High Score: \(highScore)"
    }

}
