//
//  AudioService.swift
//  Caiva_iOS
//
//  Created by Shutaro Aoyama on 2018/08/05.
//  Copyright © 2018年 Bluemountain. All rights reserved.
//

import Foundation
typealias UUIDString = String

struct SessionService {
    
    static func createAudioResource(from cardset: Cardset) -> [(String, Double, UUIDString)] {
        var audioResource: [(String, Double, UUIDString)] = []
        let cards = cardset.cards
        cards.forEach { (card) in
            audioResource.append((card.front, 1.5, card.uuid))
            audioResource.append((card.back, 3, card.uuid))
        }
        
        return audioResource
    }
    
    static func setDegree(of card: Card) {
        
    }
    
}

enum SessionType {
    case audioOnly
    case audioAndScreen
}
