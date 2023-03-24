//
//  SupaDB.swift
//  
//
//  Created by Manali Patil on 3/22/23.
//

import Supabase
import Foundation

struct MyPhoto: Encodable, Decodable {
    var filename: String?
    var image: String?
    var type: String?
}

 func connection() async{
    let supabaseUrl = "url"
    guard let url = URL(string: supabaseUrl) else {
        fatalError("Invalid Supabase URL")
    }
     let supaKey = "key"

    let supabaseClient = SupabaseClient(supabaseURL: url, supabaseKey: supaKey)
     let newPhoto = MyPhoto(filename: "my-image.jpg")
     
     let query = supabaseClient.database
                 .from("pictures")
                 .insert(values:  [newPhoto]) // you will need to add this to return the added data

    do{
        let result = try await query.execute()
        print(result)
    }catch let error{
        print("Error: \(error)")
    }
}

func uploadImage(_ image: Data) async {
    // Step 1: Encode the image data into a base64 string.
    let base64String = image.base64EncodedString()
    
    let supabaseUrl = "url"
    guard let url = URL(string: supabaseUrl) else {
        fatalError("Invalid Supabase URL")
    }
     let supaKey = "key"

    let supabaseClient = SupabaseClient(supabaseURL: url, supabaseKey: supaKey)
    let newPhoto = MyPhoto(filename: "my-image.jpg", image: base64String, type: "top")
    let query = supabaseClient.database
                .from("pictures")
                .insert(values:  [newPhoto]) // you will need to add this to return the added data

    do{
        let result = try await query.execute()
        print(result)
    }catch let error{
        print("Error: \(error)")
    }
}
