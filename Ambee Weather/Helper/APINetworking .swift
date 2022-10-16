//
//  APINetworking .swift
//  Ambee Weather
//
//  Created by suryansh Bisen on 15/10/22.
//

import Foundation

class ApiNetworking {
    
    static func apiCall<T: Decodable>(_ type: T.Type, url: URLRequest, complition: @escaping (Result<T, Error>) -> Void){
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            
            guard data != nil else { complition(Result.failure(error!)); return  }
            
            do{
                let deocder = JSONDecoder()
                let decodableResponce = try deocder.decode(type.self, from: data!)
                
                complition(Result.success(decodableResponce))
                
            }catch{
                print("error")
                print(error)
                complition(Result.failure(error))
            }
            
            
        }
        
        dataTask.resume()
    }

    
}
