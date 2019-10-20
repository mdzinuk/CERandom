//
//  CEPersonListCell.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit


class CEPersonListCell: UITableViewCell, CEReusableViewNibLoading {
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var inprogressView: UIView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        configure(with: .none)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        showAnimation()
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(with person: Random.Person?) {
        if let person = person {
            nameLbl?.text = person.name.first
            dobLbl?.text = person.dob.date.description
            genderLbl?.text = person.gender
            hideAnimation()
        } else {
            showAnimation()
        }
    }
    
    private func showAnimation() {
        nameLbl.alpha = 0.0
        dobLbl.alpha = 0.0
        genderLbl.alpha = 0.0
        inprogressView.isHidden = false
        activityView.startAnimating()
    }
    
    private func hideAnimation() {
        nameLbl.alpha = 1.0
        dobLbl.alpha = 1.0
        genderLbl.alpha = 1.0
        inprogressView.isHidden = true
        activityView.stopAnimating()
    }
}
