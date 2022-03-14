//
//  Note.swift
//  Notepad
//
//  Created by Crazelu on 14/03/2022.
//

struct Note: Hashable, Identifiable{
    var id: String
    var title: String
    var content: String
    var date: String
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(id)
           hasher.combine(title)
        hasher.combine(content)
        hasher.combine(date)
       }
}
