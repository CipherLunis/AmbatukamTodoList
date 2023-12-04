//
//  ContentView.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/1/23.
//

import CoreData
import SwiftUI

struct ListView: View {
    
    @ObservedObject var ambatukamViewModel: AmbatukamTodoListViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var ambatukamTodoListItems: FetchedResults<AmbatukamTodoListItem>
    @StateObject private var soundManager = SoundManager()
    @State var isActive = false
    
    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                List {
                    ForEach(ambatukamTodoListItems) { item in
                        HStack {
                            Image(item.imageURL ?? "")
                                .resizable()
                                .frame(width: geo.size.width/8, height: geo.size.width/8)
                            Spacer()
                            VStack {
                                Text(item.content ?? "")
                                    .padding(.bottom, 20)
                                Text(ambatukamViewModel.formatDate(date: item.notificationDate!))
                                    .font(.footnote)
                                    .fontWeight(.thin)
                            }
                            Spacer()
                            Button {
                                soundManager.playSound(fileName: item.soundURL!)
                                soundManager.updateCurrentObjectBeingPlayed(item: item)
                                item.soundIsPlaying = true
                                try? moc.save()
                            } label: {
                                if(item.soundIsPlaying) {
                                    Image(systemName: "pause.fill")
                                        .foregroundColor(.black)
                                        .frame(width: geo.size.width/16, height: geo.size.width/16)
                                } else {
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.black)
                                        .frame(width: geo.size.width/16, height: geo.size.width/16)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let todoListItem = ambatukamTodoListItems[index]
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [ambatukamTodoListItems[index].id!.uuidString])
                            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [ambatukamTodoListItems[index].id!.uuidString])
                            moc.delete(todoListItem)
                        }
                        try? moc.save()
                    }
                }
                .toolbar {
                    NavigationLink(destination: AddTodoListItemView(), isActive: $isActive) {
                        Image(systemName: "plus")
                            .font(.system(size: isIPad ? 60 : 20))
                    }
                }
                .navigationTitle(!isActive ? "Ambatukam Todo List" : "Back")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.systemFont(ofSize: isIPad ? 60 : 35, weight: .bold)]
            soundManager.viewModel = ambatukamViewModel
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(ambatukamViewModel: AmbatukamTodoListViewModel())
        ListView(ambatukamViewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPod touch (7th generation)")
        ListView(ambatukamViewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPhone 12 Pro")
        ListView(ambatukamViewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPhone SE (2nd generation)")
        ListView(ambatukamViewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPad Air (4th generation)")
        ListView(ambatukamViewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
