//
//  AddTodoListItemView.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/2/23.
//

import SwiftUI

struct AddTodoListItemView: View {
    
    @ObservedObject var viewModel: AmbatukamTodoListViewModel
    @State private var todoListItemText = ""
    @State private var imageSelected = -1
    @State private var soundSelected = -1
    private let soundList: [String] = ["AMBASSING", "AMBATUKAM", "AMBATUKAM2", "AMBATUNAT", "OMAYGOT", "THANKYOUSOMUCH"]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geo in
                VStack(spacing: 40) {
                    Text("Add Item")
                        .fontWeight(.bold)
                        .font(.system(.largeTitle))
                    HStack {
                        Spacer()
                        HStack {
                            Spacer()
                            TextField("Add item here", text: $todoListItemText)
                        }
                        .frame(width: geo.size.width/1.1, height: geo.size.height/25)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        Spacer()
                    }
                    VStack {
                        Divider()
                        HStack {
                            Text("AMBATUKAM IMAGE:")
                                .fontWeight(.semibold)
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
                                            } else {
                                                Image(systemName: "smallcircle.filled.circle")
                                            }
                                            Text(soundList[soundListIndex])
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                            }
                            .padding(.leading, geo.size.width/20)
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        Divider()
                    }
                    Spacer()
                    Button {
//                        AmbatukamTodoListItem(context: moc)
//                        viewModel.appendTodoListItem(item: AmbatukamTodoListItem(context: moc))
                        viewModel.appendTodoListItem(item: AmbatukamTodoListItem(
                            imageURL: "Ambatukam\(imageSelected)",
                            soundURL: soundList[soundSelected],
                            content: todoListItemText))
                        /*
                         AmbatukamTodoListItem(
                             imageURL: "Ambatukam\(imageSelected)",
                             soundURL: soundList[soundSelected],
                             content: todoListItemText)
                         */
                        dismiss()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .fill(.green)
                                .frame(width: geo.size.width/1.3, height: geo.size.height/15)
                            Text("Add")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                    .disabled(todoListItemText.isEmpty || imageSelected == -1 || soundSelected == -1)
                    .opacity((todoListItemText.isEmpty || imageSelected == -1 || soundSelected == -1) ? 0.5 : 1.0)
                }
                .navigationBarTitle(Text(""), displayMode: .inline)
        }
    }
}

struct AddTodoListItemView_Previews: PreviewProvider {

    static var previews: some View {
        AddTodoListItemView(viewModel: AmbatukamTodoListViewModel())
        AddTodoListItemView(viewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPod touch (7th generation)")
        AddTodoListItemView(viewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPhone 12 Pro")
        AddTodoListItemView(viewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPhone SE (2nd generation)")
        AddTodoListItemView(viewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPad Air (4th generation)")
        AddTodoListItemView(viewModel: AmbatukamTodoListViewModel())
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
    }
}
