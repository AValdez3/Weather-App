//
//  UIImageView+LoadImage.swift
//  Weather App
//
//  Created by Avelardo Valdez on 8/5/20.
//  Copyright © 2020 Avelardo Valdez. All rights reserved.
//

import UIKit


extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
