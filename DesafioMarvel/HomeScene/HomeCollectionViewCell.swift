//
//  HomeCollectionViewCell.swift
//  DesafioMarvel
//
//  Created by Gustavo Melki Leal on 17/05/2018.
//  Copyright © 2018 gustavoMelki. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var characterImage: UIImageView!
  
  override func awakeFromNib() {
    characterImage.clipsToBounds = true
  }
  
  
}
