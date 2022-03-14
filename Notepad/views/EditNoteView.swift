//
//  EditNoteView.swift
//  Notepad
//
//  Created by Crazelu on 14/03/2022.
//

import SwiftUI
import Combine

struct EditNoteView: View {
    
    var note: Note
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var title:String = ""
    @State private var noteBody:String = ""
    @State private var date: String = ""
    @State private var stream: AnyCancellable?
    
    @State private var titleCount = 0
    @State private var bodyCount = 0
    
    
    func saveNote(){
        if(note.title == self.title && note.content == self.noteBody){
            self.stream = nil
            presentationMode.wrappedValue.dismiss()
            return 
        }
        self.stream = nil
        self.date = DateUtil.formatDate(date: Date())
        DBService().updateNote(updatedNote: Note(id: note.id, title: self.title, content: self.noteBody, date: self.date))
        presentationMode.wrappedValue.dismiss()
    }
    
    func deleteNote(){
        self.stream = nil
        DBService().deleteNote(noteId: note.id)
        presentationMode.wrappedValue.dismiss()
    }
    
    func updateDate(){
        if(self.title.count != self.titleCount || self.noteBody.count != self.bodyCount){
            self.date = DateUtil.formatDate(date: Date())
            self.titleCount = self.title.count
            self.bodyCount = self.noteBody.count
        }
       
    }
    
    func listenForChanges(){
        self.stream = Timer.publish(every: 1,  on: .main, in: .common).autoconnect()
            .scan(0,{ (count, _)
                in
                updateDate()
                return count + 1
            })
            .sink(receiveValue: {(_) in })
    }
    
    
    var body: some View {
        VStack(alignment:.leading){
            Text(self.date)
                .padding(.bottom)
                .padding(.top, 100)
            
            MultilineTextField(self.title.isEmpty ? "Title" : "", text: $title)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 10)
            
            MultilineTextField(self.noteBody.isEmpty ? "Note something down" : "", text: $noteBody)
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color(uiColor: UIColor(named: "Grey")!))
            
            Spacer()
               
            
        }
        .onAppear(perform: {
            self.title = note.title
            self.noteBody = note.content
            self.date = note.date
            self.titleCount = note.title.count
            self.bodyCount = note.content.count
            listenForChanges()
        })
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                if(!self.title.isEmpty || !self.noteBody.isEmpty){
                    Button(action:saveNote){
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(uiColor: UIColor(named: "AccentColor")!))
                    }
                }
                
                Button(action:deleteNote){
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
              
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)
    }
}

struct EditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        EditNoteView(note: Note(id: "", title: "Some new note", content: "Dummy content", date: "March 14, 2022 04:08 PM"))
    }
}
