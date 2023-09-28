//
//  NetworkManager.swift
//  Networking
//
//  Created by Валентина Лінчук on 27/09/2023.
//

import Foundation

class NetworkManager {
    
    enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    enum APIs: String {
        case posts
        case users
        case comments
    }
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    //GET
    func getAllPosts(_ complitionHandler: @escaping ([Post]) -> ()) {
        if let url = URL(string: baseURL + APIs.posts.rawValue) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error in request")
                } else {
                    if let resp = response as? HTTPURLResponse, resp.statusCode == 200, let responseData = data {
                        let posts = try? JSONDecoder().decode([Post].self, from: responseData)
                        
                        complitionHandler(posts ?? [])
                    }
                }
            }.resume()
        }
    }
    
    //POST
    func postCreatePost(_ post: Post, complitionHandler: @escaping () -> ()) {
        guard let url = URL(string: baseURL + APIs.posts.rawValue), let data = try? JSONEncoder().encode(post) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue //enum
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Lengh")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Error")
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 201, let responseData = data {
                let json = try? JSONSerialization.jsonObject(with: responseData)
                print(json)
                complitionHandler()
            }
        }
    }
}
