//
//  AddTodoListItemView.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/2/23.
//

import SwiftUI

struct AddTodoListItemView: View {
    
    @State private var todoListItemText = ""
    @State private var imageSelected = -1
    @State private var soundSelected = -1
    @State private var notificationDate = Date()
    private let soundList: [String] = ["AMBASSING", "AMBATUKAM", "AMBATUKAM2", "AMBATUNAT", "OMAYGOT", "THANKYOUSOMUCH"]
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        GeometryReader { geo in
                VStack(spacing: 37) {
                    Text("Add Item")
                        .fontWeight(.bold)
                        .font(.system(size: isIPad ? 100 : 40))
                    HStack {
                        Spacer()
                        HStack {
                            Spacer()
                            TextField("Add item here", text: $todoListItemText)
                                .font(.system(size: isIPad ? 40 : 20))
                        }
                        .frame(width: geo.size.width/1.1, height: isIPad ? geo.size.height/15 : geo.size.height/25)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        Spacer()
                    }
                    VStack {
                        Divider()
                        HStack {
                            Text("AMBATUKAM IMAGE:")
                                .fontWeight(.semibold)
                                .font(.system(size: isIPad ? 40 : 20))
                            Spacer()
                        }
                        .padding(.leading, 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(1..<6) { imageIndex in
                                    if(imageSelected == imageIndex) {
                                        Image("Ambatukam\(imageIndex)")
                                            .resizable()
                                            .border(.green, width: 3)
                                            .frame(width: geo.size.width/4, height: geo.size.width/4)
                                            .onTapGesture {
                                                imageSelected = imageIndex
                                            }
                                    } else {
                                        Image("Ambatukam\(imageIndex)")
                                            .resizable()
                                            .frame(width: geo.size.width/4, height: geo.size.width/4)
                                            .onTapGesture {
                                                imageSelected = imageIndex
                                            }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    Divider()
                    VStack {
                        HStack {
                            Text("AMBATUKAM SOUNDS:")
                                .fontWeight(.semibold)
                                .font(.system(size: isIPad ? 40 : 20))
                            Spacer()
                        }
                        .padding(.top, -20)
                        .padding(.leading, 20)
                        .padding(.bottom, 5)
                        HStack {
                            VStack(alignment: .leading) {
                                ForEach(0..<6) { soundListIndex in
                                    Button {
                                        soundSelected = soundListIndex
                                    } label: {
                                        HStack {
                                            if(soundSelected == soundListIndex) {
                                                Image(systemName: "smallcircle.filled.circle.fill")
                                                    .font(.system(size: isIPad ? 35 : 20))
                                            } else {
                                                Image(systemName: "smallcircle.filled.circle")
                                            }
                                            Text(soundList[soundListIndex])
                                                .foregroundColor(.black)
                                                .font(.system(size: isIPad ? 35 : 20))
                                        }
                                    }
                                }
                            }
                            .padding(.leading, geo.size.width/20)
                            Spacer()
                        }
                        .padding(.bottom, -10)
                    }
                    VStack {
                        Divider()
                        HStack() {
                            Text("Schedule For: ")
                                .font(.system(size: isIPad ? 40 : 20))
                                .fontWeight(.semibold)
                            DatePicker("",
                                       selection: $notificationDate,
                                       in: Date.now...,
                                       displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .pickerStyle(.wheel)
                            Spacer()
                        }
                        .padding(.leading, 20)
                        Divider()
                    }
                    
                    Button {
                        let ambatukamTodoListItem = AmbatukamTodoListItem(context: moc)
                        ambatukamTodoListItem.id = UUID()
                        ambatukamTodoListItem.content = todoListItemText
                        ambatukamTodoListItem.imageURL = "Ambatukam\(imageSelected)"
                        ambatukamTodoListItem.soundURL = soundList[soundSelected]
                        ambatukamTodoListItem.notificationDate = notificationDate
                        ambatukamTodoListItem.soundIsPlaying = false
                        try? moc.save()
                        
                        // schedule notification
                        let notificationCenter = UNUserNotificationCenter.current()
                        let content = UNMutableNotificationContent()
                        content.title = soundList[soundSelected]
                        content.body = todoListItemText
                        content.sound = .default
                        
                        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: notificationDate)
                        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
                        
                        notificationCenter.add(UNNotificationRequest(identifier: ambatukamTodoListItem.id!.uuidString, content: content, trigger: trigger))
                        dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .fill(.green)
                                .frame(width: geo.size.width/1.3, height: geo.size.height/15)
                            Text("Add")
                                .foregroundColor(.black)
                                .font(.system(size: isIPad ? 40 : 20))
                        }
                    }
                    .disabled(todoListItemText.isEmpty || imageSelected == -1 || soundSelected == -1)
                    .opacity((todoListItemText.isEmpty || imageSelected == -1 || soundSelected == -1) ? 0.5 : 1.0)
                }
                .navigationBarTitle(Text(""), displayMode: .inline)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct AddTodoListItemView_Previews: PreviewProvider {

    static var previews: some View {
        AddTodoListItemView()
        AddTodoListItemView()
            .previewDevice("iPod touch (7th generation)")
        AddTodoListItemView()
            .previewDevice("iPhone 12 Pro")
        AddTodoListItemView()
            .previewDevice("iPhone SE (2nd generation)")
        AddTodoListItemView()
            .previewDevice("iPad Air (4th generation)")
        AddTodoListItemView()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
