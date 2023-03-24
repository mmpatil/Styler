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
    
    let supabaseUrl = "https://dynwuzbasunmfxqhadub.supabase.co"
    guard let url = URL(string: supabaseUrl) else {
        fatalError("Invalid Supabase URL")
    }
     let supaKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR5bnd1emJhc3VubWZ4cWhhZHViIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Nzk0NTQ1NjUsImV4cCI6MTk5NTAzMDU2NX0.pYTITVTsKBevKQBL01ZXYMJC-FI2yU1KyYNfIVDm3gg"

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
