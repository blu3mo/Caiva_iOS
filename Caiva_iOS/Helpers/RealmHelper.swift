//
//  RealmHelpers.swift
//  MakeSchoolCardsets
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//
import RealmSwift

class RealmHelper {
    
    static func addCardset(cardset: Cardset){
        let realm = try! Realm()
        try! realm.write(){
            realm.add(cardset)
        }
    }
    
    static func updateCardset(oldCardset: Cardset, newCardset: Cardset){
        let realm = try! Realm()
        try! realm.write(){
//            oldCardset.title = newCardset.title
//            oldCardset.content = newCardset.content
//            oldCardset.modificationTime = newCardset.modificationTime
        }
    }
    
    static func deleteCardset(cardset: Cardset){
        let realm = try! Realm()
        try! realm.write(){
            realm.delete(cardset)
        }
    }
    
    static func retrieveCardsets() -> Results<Cardset> {
        let realm = try! Realm()
        return realm.objects(Cardset.self).sorted(byKeyPath: "modificationTime", ascending: false)
    }
    
    static func addBlankCard(to cardset: Cardset) {
        let realm = try! Realm()
        try! realm.write {
            cardset.cards.append(Card())
        }
    }
    
    static func setCard(on cardset: Cardset, card: Card, front: String, back: String) {
        let realm = try! Realm()
        try! realm.write {
            card.front = front
            card.back = back
        }
    }
    
}
