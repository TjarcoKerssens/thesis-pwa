//
//  ImageAlter.swift
//  ThesisPWA
//
//  Created by Tjarco Kerssens on 26/04/2019.
//  Copyright © 2019 Tjarco Kerssens. All rights reserved.
//

import UIKit

class ImageAlter{
    
    func applyFilters(onImage image: UIImage) -> UIImage?{
        guard let inputImage = CIImage(image: image) else {return nil}
        guard let outputImage = inputImage.invertColors()?.applyContrast() else {return nil}
        return UIImage(ciImage: outputImage)
    }
}

extension CIImage{
    func invertColors() -> CIImage?{
        return self.applyingFilter("CIColorInvert")
    }
    
    func applyContrast() -> CIImage?{
        let parameters = ["inputContrast": NSNumber(value: 2)]
        return self.applyingFilter("CIColorControls", parameters: parameters)
    }
}
