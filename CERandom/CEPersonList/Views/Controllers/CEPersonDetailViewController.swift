//
//  CEPersonDetailViewController.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

class CEPersonDetailViewController: UIViewController {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var natLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var personInfo: PersonInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullName.text = personInfo?.fullName
        dobLabel.text = personInfo?.birthday
        genderLabel.text = personInfo?.contact
        natLabel.text = "....................."
        
        CEPersonDetailViewModel()
            .getLargeImage(from: personInfo?.pictureLink ?? "") { (image: UIImage?) in
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.photoView.image = image
                }
        }
    }
}
