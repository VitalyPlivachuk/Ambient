//
//  Song.swift
//  Ambient
//
//  Created by Vitaly Plivachuk on 08.07.17.
//  Copyright © 2017 Vitaly Plivachuk. All rights reserved.
//

import Foundation
import UIKit

class AmbientSound {
    let name: String?
    let fileName: String?
    let image: UIImage?
    var isFavorite: Bool?
    
    init(name: String, fileName: String, image: UIImage, isFavorite: Bool) {
        self.name = name
        self.fileName = fileName
        self.image = image
        self.isFavorite = isFavorite
    }
}
