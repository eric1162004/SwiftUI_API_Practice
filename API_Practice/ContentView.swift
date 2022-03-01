//
//  ContentView.swift
//  API_Practice
//
//  Created by eric on 2022-03-01.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var network: Network
    
    var body: some View {
        VStack {
            List(network.items){ item in
                HStack{
                    if let url = URL(string: item.thumbnailUrl){
                        AsyncImage(
                            url: url,
                            content: { image in
                                image.resizable()
                                     .aspectRatio(contentMode: .fit)
                                     .frame(maxWidth: 100, maxHeight: 100)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        Text(item.title)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            network.fetchItems()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
