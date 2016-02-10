//
//  BusinessCell.swift
//  Yelp
//
//  Created by Nuraini Aguse on 2/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {


    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var restauarantLabel: UILabel!
    
    @IBOutlet weak var distLabel: UILabel!

    @IBOutlet weak var ratingImageView: UIImageView!
    

    @IBOutlet weak var reviewLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var business: Business!{
        didSet{
            restauarantLabel.text = business.name
            thumbImageView.setImageWithURL(business.imageURL!)
           categoryLabel.text = business.categories
            addressLabel.text = business.address
            reviewLabel.text = "\(business.reviewCount!) Reviews"
        ratingImageView.setImageWithURL(business.ratingImageURL!)
            distLabel.text = business.distance
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.clipsToBounds = true
        restauarantLabel.preferredMaxLayoutWidth = restauarantLabel.frame.size.width
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        restauarantLabel.preferredMaxLayoutWidth = restauarantLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
