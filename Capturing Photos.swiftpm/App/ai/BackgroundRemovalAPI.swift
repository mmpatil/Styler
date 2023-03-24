//
//  BackgroundRemovalAPI.swift
//  
//
//  Created by Manali Patil on 3/23/23.
//
import Foundation

func removeBackground(from imageData: Data, completion: @escaping (Result<Data, Error>) -> Void) {
    // Step 1: Encode the image data into a base64 string.
    let base64String = imageData.base64EncodedString()
    let apiKey = "<your-removal-ai-api-key>"
    // Step 2: Prepare the request payload.
    let endpoint = "https://api.removal.ai/3.0/remove"
    let parameters: [String: Any] = [
        "api_key": apiKey,
        "format": "png",
        "base64": base64String,
    ]
    let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])

    // Step 3: Create the URL request.
    var request = URLRequest(url: URL(string: endpoint)!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData

    // Step 4: Send the request.
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
            return
        }

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            completion(.failure(NSError(domain: "HTTP error", code: httpResponse.statusCode, userInfo: nil)))
            return
        }

        completion(.success(data))
    }

    task.resume()
}
