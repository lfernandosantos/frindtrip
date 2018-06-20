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

        if category == GlobalConstants.Categories.BEER {
            return UIImage(named: ConstantsNamedImages.categoryBeer)
        }
        if category == GlobalConstants.Categories.ADVENTURE {
            return UIImage(named: ConstantsNamedImages.categoryAdventure)
        }
        if category == GlobalConstants.Categories.CLUB {
            return UIImage(named: ConstantsNamedImages.categoryClub)
        }
        if category == GlobalConstants.Categories.PARTY {
            return UIImage(named: ConstantsNamedImages.categoryParty)
        } else {
            return UIImage(named: ConstantsNamedImages.categoryAdventure)
        }
    }

    static func getImgCategory(_ category: String) -> UIImage? {

        if category == GlobalConstants.Categories.BEER {
            return UIImage(named: ConstantsNamedImages.imgCategoryBeer)
        }
        if category == GlobalConstants.Categories.ADVENTURE {
            return UIImage(named: ConstantsNamedImages.imgCategoryAdventure)
        }
        if category == GlobalConstants.Categories.CLUB {
            return UIImage(named: ConstantsNamedImages.imgCategoryClub)
        }
        if category == GlobalConstants.Categories.PARTY {
            return UIImage(named: ConstantsNamedImages.imgCategoryParty)
        } else {
            return UIImage(named: ConstantsNamedImages.imgCategoryAdventure)
        }
    }
    
}
