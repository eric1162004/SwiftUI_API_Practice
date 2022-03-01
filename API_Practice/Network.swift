//
//  Network.swift
//  API_Practice
//
//  Created by eric on 2022-03-01.
//

import Foundation

struct item : Identifiable, Decodable{
    var id: Int
    var title: String
    var thumbnailUrl: String
}

class Network: ObservableObject {
    
    let urlString: String = "https://jsonplaceholder.typicode.com/photos"
    
    @Published var items: [item] = []
    
    func fetchItems(){
        guard let url = URL(string: urlString) else {
            fatalError("could not make URL")
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("\(error)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard response.statusCode == 200,
                    let data = data else {
                print("failed response")
                return
            }
            
            print(String(data: data, encoding: .utf8)!)
            
            DispatchQueue.main.async {
                do{
                    let decodedItems = try JSONDecoder().decode([item].self, from:data)
                    
                    if(decodedItems.count > 10){
                        self.items = Array(decodedItems[0 ..< 10])
                    }else {
                        self.items = decodedItems
                    }
                }
                catch let error {
                    print("[Error] \(error)")
                }
            }
            
        }
        
        dataTask.resume()
    }
    
}
