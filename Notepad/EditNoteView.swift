//
//  EditNoteView.swift
//  Notepad
//
//  Created by Crazelu on 14/03/2022.
//

import SwiftUI

struct EditNoteView: View {
    
    var note: Note
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var title:String = ""
    @State private var noteBody:String = ""
    
    func formatDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy hh:mm a"
        guard let date = dateFormatter.date(from: note.date)else {
            return ""
        }
        return dateFormatter.string(from: date)
    }
    
    func saveNote(){
        presentationMode.wrappedValue.dismiss()
    }
    
    
    var body: some View {
        VStack(alignment:.leading){
            Text(formatDate())
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
        })
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                if(!self.title.isEmpty || !self.noteBody.isEmpty){
                    Button(action:saveNote){
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(uiColor: UIColor(named: "AccentColor")!))
                    }
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
