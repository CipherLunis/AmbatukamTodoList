//
//  ContentView.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/1/23.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var ambatukamViewModel = AmbatukamTodoListViewModel()
    @State var isActive = false
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                List {
                    ForEach(ambatukamViewModel.todoListData) { item in
                        HStack {
                            Image(item.imageURL)
                                .resizable()
                                .frame(width: geo.size.width/8, height: geo.size.width/8)
                            Spacer()
                            Text(item.content)
                            Spacer()
                            //                        Button {
                            //                            // play sound
                            //                        } label: {
                            //                            Image(systemName: "play.fill")
                            //                                .foregroundColor(.black)
                            //                                .frame(width: geo.size.width/16, height: geo.size.width/16)
                            //                        }
                        }
                    }
                    
                }
                
                .toolbar {
                    NavigationLink(destination: AddTodoListItemView(viewModel: ambatukamViewModel), isActive: $isActive) {
                        Image(systemName: "plus")
                    }
                }
                .navigationTitle(!isActive ? "Ambatukam Todo List" : "Back")
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
        ListView()
            .previewDevice("iPod touch (7th generation)")
        ListView()
            .previewDevice("iPhone 12 Pro")
        ListView()
            .previewDevice("iPhone SE (2nd generation)")
        ListView()
            .previewDevice("iPad Air (4th generation)")
        ListView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
