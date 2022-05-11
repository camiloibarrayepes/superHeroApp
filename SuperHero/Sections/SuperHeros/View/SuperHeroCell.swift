//
//  SuperHeroCollectionViewCell.swift
//  SuperH12
//
//  Created by CAMILO.IBARRAY on 10/05/22.
//

import UIKit

class SuperHeroCell: UICollectionViewCell {

    @IBOutlet weak var descriptionContainer: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPublisher: UILabel!
    @IBOutlet weak var itemHeight: UILabel!
    @IBOutlet weak var itemWeigth: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var item: SuperHeroViewModel {
        didSet {
            itemImage.image = UIImage(data: item.image)
            itemName.text = item.name
            itemPublisher.text = item.publisher
            itemHeight.text = item.height
            itemWeigth.text = item.weigth
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onRemoveTap(_ sender: Any) {
        
    }
}
