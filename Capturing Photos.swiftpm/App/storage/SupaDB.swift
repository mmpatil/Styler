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
