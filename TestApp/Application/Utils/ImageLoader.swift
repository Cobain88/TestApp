//
//  ImageLoader.swift
//  TestApp
//
//  Created by Dario Abete on 03/05/22.
//

import Foundation
import UIKit

class ImageLoader {

    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    private var task: URLSessionDataTask?

    func loadImage(for url: URL, completion: @escaping ((_ image: UIImage?, _ error: Error?) -> Void)) {
            if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
                completion(imageInCache, nil)
                return
            }

            self.task = URLSession.shared.dataTask(with: url) { data, _ , error in

                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let data = data {
                    let image = UIImage(data: data)

                    self.cache.setObject(image ?? UIImage(), forKey: url.absoluteString as NSString)
                    completion(image, nil)
                } else {
                    completion(nil,nil)
                }
            }

        self.task?.resume()
    }
}
