//
//  CEPersonDetailViewController.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

class CEPersonDetailViewController: UIViewController {
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var natLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullName.text = "Full Name: "
        dobLabel.text = "DOB: "
        genderLabel.text = "Gender: "
        natLabel.text = "Nat: "
    }
}
