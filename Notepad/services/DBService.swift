//
//  DBService.swift
//  Notepad
//
//  Created by Crazelu on 14/03/2022.
//

import Foundation
import SQLite
import UIKit


class DBService{
    
    private var db: Connection!
    
    private var notes: Table!
    
    private var id: Expression<String>!
    private var title: Expression<String>!
    private var content: Expression<String>!
    private var date: Expression<String>!
    
    init(){
        
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            db = try Connection("\(path)/notes.sqlite3")
            
            notes = Table("notes")
            id =  Expression<String>("id")
            title =  Expression<String>("title")
            content =  Expression<String>("content")
            date =  Expression<String>("date")
            
            if(!UserDefaults.standard.bool(forKey: "is_db_created")){
                try db.run(notes.create{
                    (t) in
                    t.column(id, primaryKey: true)
                    t.column(title)
                    t.column(content)
                    t.column(date)
                })
                
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
            
            
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    public func addNote(note: Note){
        do{
            try db.run(notes.insert(id <- note.id, title <- note.title, content <- note.content, date <- note.date))
        }catch{
            print(error.localizedDescription)
        }
    }
    
    public func fetchNotes()->[Note]{

        var fetchedNotes:[Note] = []
        
        notes = notes.order(id.desc)
        do{
           
            
            for note in try db.prepare(notes){
                let newNote = Note(
                    id: note[id],
                    title: note[title],
                    content: note[content],
                    date: note[date]
                )
                
                fetchedNotes.append(newNote)
                
            }

        }catch{
            print(error.localizedDescription)
        }
        
        return fetchedNotes
    }
    
    public func updateNote(updatedNote: Note){
        
        do{
           
            let note: Table = notes.filter(id == updatedNote.id)
            
            try db.run(note.update(title <- updatedNote.title,
                content <-  updatedNote.content, date <-  updatedNote.date
                                  ))
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    public func deleteNote(noteId: String){
        do{
            
            let note: Table = notes.filter(id == noteId)
            
            try db.run(note.delete())
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
