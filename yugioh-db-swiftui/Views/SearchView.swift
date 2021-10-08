//
//  ContentView.swift
//  yugioh-db-swiftui
//
//  Created by bhrs on 10/7/21.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        ScrollView {
            Button {
                viewModel.startFetch()
            } label: {
                Text("Start")
            }
            Text(viewModel.time)
            Text(viewModel.seconds).foregroundColor(Color(.gray))
            Text("\(viewModel.timeModel.seconds)s").foregroundColor(Color.orange)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
