//
//  NetworkManager.swift
//  EngineerAIAssignment
//
//  Created by Kushal Mandala on 25/12/19.
//  Copyright © 2019 Indovations. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    static func getPosts(url : String,completion : @escaping(Posts)-> Void){
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard data != nil else{
                completion(Posts())
                return
             }
            do
            {
                let jsonDecoder = JSONDecoder()
                let infoPost = try jsonDecoder.decode(Posts.self, from: data!)
                completion(infoPost)
             }
            catch
            {
                print("Error in \(error)")
             }
        }.resume()
    }
    
}
