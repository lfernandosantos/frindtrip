//
//  UIImageCategory.swift
//  Friend Trip
//
//  Created by Luiz Fernando dos Santos on 16/06/2018.
//  Copyright © 2018 LFSantos. All rights reserved.
//

import UIKit

class UIImageCategory {
    static func getIconCategory(_ category: String) -> UIImage? {

        if category == "Beer" {
            return UIImage(named: ConstantsNamedImages.categoryBeer)
        }
        if category == "Adventure" {
            return UIImage(named: ConstantsNamedImages.categoryAdventure)
        }
        if category == "Beach" {
            return UIImage(named: ConstantsNamedImages.categoryBeach)
        }
        if category == "Party" {
            return UIImage(named: ConstantsNamedImages.categoryParty)
        } else {
            return UIImage(named: ConstantsNamedImages.categoryAdventure)
        }
    }

    static func getImgCategory(_ category: String) -> UIImage? {

        if category == "Beer" {
            return UIImage(named: ConstantsNamedImages.imgCategoryBeer)
        }
        if category == "Adventure" {
            return UIImage(named: ConstantsNamedImages.imgCategoryAdventure)
        }
        if category == "Beach" {
            return UIImage(named: ConstantsNamedImages.imgCategoryBeach)
        }
        if category == "Party" {
            return UIImage(named: ConstantsNamedImages.imgCategoryParty)
        } else {
            return UIImage(named: ConstantsNamedImages.imgCategoryAdventure)
        }
    }
    
}
