//
//  NetworkManager.swift
//  ProHerald
//
//  Created by erric alfajri on 07/08/20.
//  Copyright © 2020 proherald. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class NetworkManager {
    static var shared: NetworkManager = NetworkManager()
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func fetchAllHeroes(onSuccess: @escaping ([HeroDetailObject]) -> Void, onError: @escaping (String) -> Void) {
        let url: String = "https://api.opendota.com/api/herostats"
        
        let request: DataRequest = Alamofire.request(url)
        request.responseArray { (response: DataResponse<[HeroDetailObject]>) in
            guard let values: [HeroDetailObject] = response.result.value, !values.isEmpty else {
                onError("Failed to load data")
                return
            }
            
            onSuccess(values)
        }
    }
}
