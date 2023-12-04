//
//  SoundManager.swift
//  AmbatukamTodoList
//
//  Created by Cipher Lunis on 12/4/23.
//

import CoreData
import Foundation
import AVFoundation
import SwiftUI

class SoundManager: NSObject, AVAudioPlayerDelegate, ObservableObject {
    
    var audioPlayers =  [URL:AVAudioPlayer]()
    
    var currentTodoListItemSoundBeingPlayed = AmbatukamTodoListItem()
    
    var viewModel: AmbatukamTodoListViewModel?
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let vm = self.viewModel {
            @FetchRequest(sortDescriptors: []) var ambatukamTodoListItems: FetchedResults<AmbatukamTodoListItem>
            
            // Fetch AmbatukamTodoListItem entity
            let fetchRequest: NSFetchRequest<AmbatukamTodoListItem> = AmbatukamTodoListItem.fetchRequest()
            
            do {
                let items = try viewModel!.container.viewContext.fetch(fetchRequest)
                
                // Update the entity as needed
                for item in items {
                    // Perform updates on the entity
                    // For example, update a boolean property
                    item.soundIsPlaying = false
                }
                
                // Save changes to the context
                try viewModel!.container.viewContext.save()
            } catch {
                print("Error updating Core Data entity: \(error.localizedDescription)")
            }
        } else {
            print("No instance of view model!")
        }
    }
    
    public func updateCurrentObjectBeingPlayed(item: AmbatukamTodoListItem) {
        print("current todo list item sound played is set to \(item)")
        currentTodoListItemSoundBeingPlayed = item
    }
    
    public func playSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            return
        }
        
        if let player = audioPlayers[url] { // player exists for sound
            if(player.isPlaying == false) {
                player.prepareToPlay()
                player.play()
            }
        } else { // player does not exist for sound
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                audioPlayers[url] = player
                player.delegate = self
                player.prepareToPlay()
                player.play()
            } catch {
                print("Could not play sound!")
            }
        }
    }
    
    public func stopSound(fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            return
        }
        
        if let player = audioPlayers[url] {
            if(player.isPlaying) {
                player.stop()
            }
        }
    }
}
