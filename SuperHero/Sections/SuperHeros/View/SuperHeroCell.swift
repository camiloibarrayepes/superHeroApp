//
//  SuperHeroCollectionViewCell.swift
//  SuperH12
//
//  Created by CAMILO.IBARRAY on 10/05/22.
//

import UIKit
import AlamofireImage

class SuperHeroCell: UICollectionViewCell {

    @IBOutlet weak var descriptionContainer: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPublisher: UILabel!
    @IBOutlet weak var itemHeight: UILabel!
    @IBOutlet weak var itemWeigth: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var onRemoveCallback: ((_ view: SuperHeroCell) -> Void)?
    
    var item: SuperHeroViewModel? {
        didSet {
            itemName.text = item?.name
            itemPublisher.text = item?.publisher
            itemHeight.text = item?.height
            itemWeigth.text = item?.weigth
            
            guard let url = URL(string: item?.image ?? "") else {
                return
            }
            activityIndicator.startAnimating()
            itemImage.af.setImage(withURL: url, completion:  { [weak self] _ in
                self?.activityIndicator.stopAnimating()
            })
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImage.image = nil
    }
    
    @IBAction func onRemoveTap(_ sender: Any) {
        onRemoveCallback?(self)
    }
}
