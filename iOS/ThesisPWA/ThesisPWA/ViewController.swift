//
//  ViewController.swift
//  ThesisPWA
//
//  Created by Tjarco Kerssens on 26/04/2019.
//  Copyright © 2019 Tjarco Kerssens. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LocationDelegate {
    
    @IBOutlet weak var randomImageView: UIImageView!
    @IBOutlet weak var alteredImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    let imageFetcher = ImageFetcher()
    let locationWatcher = LocationWatcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFetcher.addAlteredImageView(imageView: alteredImageView)
        imageFetcher.startFetchingImage(into: randomImageView)
        locationWatcher.startWatching(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        logPostMainTimeAndExit()
    }
    
    private func logPostMainTimeAndExit(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print("Calculated post-main time: \(String(format: "%.2f", appDelegate.getCurrentMillis() - appDelegate.timing))")
        exit(0)
    }
    
    func locationUpdated(longitude: Double, latitude: Double) {
        locationLabel.text = "Longitude: \(longitude)\nLatitude: \(latitude)"
    }
}

