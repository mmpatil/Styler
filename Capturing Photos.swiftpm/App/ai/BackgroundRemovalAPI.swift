//
//  BackgroundRemovalAPI.swift
//  
//
//  Created by Manali Patil on 3/23/23.
//
import Foundation
import Alamofire

func removeBackground(from imageData: Data, completion: @escaping (Result<Data, Error>) -> Void) {
    AF.request(
      URL(string: "https://api.remove.bg/v1.0/removebg")!,
      method: .post,
      parameters: ["image_url": "https://www.remove.bg/example.jpg"],
      encoding: URLEncoding(),
      headers: [
        "X-Api-Key": ""
      ]
    )
    .responseData { imageResponse in
        switch imageResponse.result {
            case .success(let data):
                completion(.success(imageResponse.data ?? Data()))
            case .failure(let error):
                completion(.failure(error))
            }
    }
}
