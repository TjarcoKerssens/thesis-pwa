//
//  ImageDownloader.swift
//  ThesisPWA
//
//  Created by Tjarco Kerssens on 26/04/2019.
//  Copyright © 2019 Tjarco Kerssens. All rights reserved.
//

import UIKit

let IMAGE_URL = "https://picsum.photos/200";
let FETCH_INTERVAL: TimeInterval = 5

class ImageFetcher{
    var timer: Timer?
    var alteredImageView: UIImageView?
    
    let imageAlter = ImageAlter()
    
    /**
        Fetches a random image into the imageview every five seconds.
     */
    func startFetchingImage(into imageView: UIImageView){
        self.fetch(into: imageView)
        timer = Timer.scheduledTimer(withTimeInterval: FETCH_INTERVAL, repeats: true, block: { (timer) in
            self.fetch(into: imageView)
        })
    }
    
    func addAlteredImageView(imageView: UIImageView){
        self.alteredImageView = imageView
    }
    
    private func fetch(into imageView: UIImageView) {
        downloadImage { (data, response, error) in
            guard let data = data else {return}
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
                self.setAlteredImage(imageData: data)
            }
        }
    }
    
    /**
        If the altered image view exists, sets a copy of the image with alterations as the image of this view
     */
    private func setAlteredImage(imageData: Data){
        guard let image = UIImage(data: imageData) else {return}
        alteredImageView?.image = imageAlter.applyFilters(onImage: image)
    }
    
    private func downloadImage(completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: cachePreventionURL(), completionHandler: completionHandler).resume()
    }
    
    private func cachePreventionURL() -> URL{
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let randomString =  String((0..<6).map{ _ in letters.randomElement()! })
        return URL(string: "\(IMAGE_URL)?cache_prev=\(randomString)")! // Force unwrap, we want it to crash if the URL is not correct
    }
}
