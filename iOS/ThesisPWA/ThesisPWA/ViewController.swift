//
//  ViewController.swift
//  ThesisPWA
//
//  Created by Tjarco Kerssens on 26/04/2019.
//  Copyright © 2019 Tjarco Kerssens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var randomImageView: UIImageView!
    @IBOutlet weak var alteredImageView: UIImageView!
    
    let imageFetcher = ImageFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFetcher.addAlteredImageView(imageView: alteredImageView)
        imageFetcher.startFetchingImage(into: randomImageView)
    }
}

