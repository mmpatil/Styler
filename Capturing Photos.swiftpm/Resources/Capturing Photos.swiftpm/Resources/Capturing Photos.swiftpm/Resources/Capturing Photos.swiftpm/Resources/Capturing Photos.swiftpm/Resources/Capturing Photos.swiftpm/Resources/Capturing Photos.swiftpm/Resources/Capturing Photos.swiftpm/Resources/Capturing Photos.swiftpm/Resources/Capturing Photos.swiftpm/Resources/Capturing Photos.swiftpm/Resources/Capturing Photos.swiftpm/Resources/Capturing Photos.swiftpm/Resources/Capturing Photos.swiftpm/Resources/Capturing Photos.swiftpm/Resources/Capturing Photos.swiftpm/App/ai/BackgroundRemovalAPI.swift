//
//  BackgroundRemovalAPI.swift
//  
//
//  Created by Manali Patil on 3/23/23.
//
import Foundation
import Alamofire
import UIKit
import Photos

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
    
func removeBackgroundData(from imageData: Data, completion: @escaping (Result<Data, Error>) -> Void){
    struct HTTPBinResponse: Decodable { let url: String }
    convertHEICtoPNG(imageData: imageData){
    result in
    switch result {
        case .success(let compressedImageData):
        // compress image
        
        compressPNGImage(imageData: compressedImageData){
            result in
            switch result{
            case .success(let pngData):
                AF.upload(
                    multipartFormData: { builder in
                        builder.append(
                            pngData,
                            withName: "image_file",
                            fileName: "file.jpg",
                            mimeType: "image/png"
                        )
                    },
                    to: URL(string: "https://api.remove.bg/v1.0/removebg")!,
                    headers: [
                        "X-Api-Key": ""
                    ]
                ).responseData { response in
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    
}

func convertHEICtoPNG(imageData: Data,completion: @escaping (Result<Data, Error>) -> Void) {
    guard let image = UIImage(data: imageData) else {
        let removalError = RemovalError(errorDescription: "")
        completion(.failure(removalError))
        return
    }
    guard let pngData = image.pngData() else {
        let removalError = RemovalError(errorDescription: "")
        completion(.failure(removalError))
        return
    }
    completion(.success(pngData))
}

func compressPNGImage(imageData: Data,completion: @escaping (Result<Data, Error>) -> Void) {
    guard let image = UIImage(data: imageData), let pngImageData = image.pngData() else{
        completion(.failure(RemovalError(errorDescription: "")))
        return
    }
    let imageSize = CGFloat(pngImageData.count)
    let maxFileSize: CGFloat = 0.5 * 1024.0 * 1024.0 // 0.5 MB
    
    if imageSize <= maxFileSize {
        let removalError = RemovalError(errorDescription: "compressPNGImage")
        completion(.failure(removalError)) // If image size is already within the limit, no need to compress
    }
    
    var compressionQuality: CGFloat = 0.5 // Initial compression quality
    var compressedImageData = pngImageData
    
    while imageSize > maxFileSize && compressionQuality > 0 {
        compressionQuality -= 0.1 // Decrease compression quality by 0.1 each time
        
        guard let newImage = UIImage(data: imageData), let newImageData = newImage.jpegData(compressionQuality: compressionQuality) else {
            // If compression fails, return the original PNG data
            let removalError = RemovalError(errorDescription: "compressPNGImage")
            completion(.failure(removalError))
            return
        }
        
        compressedImageData = newImageData
    }
    return completion(.success(compressedImageData))
}

struct RemovalError: LocalizedError {
    var errorDescription: String?
    
    init(errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
