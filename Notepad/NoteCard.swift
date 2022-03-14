//
//  NoteCard.swift
//  Notepad
//
//  Created by Crazelu on 13/03/2022.
//

import SwiftUI

struct NoteCard: View {
    var note: Note
    
    var body: some View {
        NavigationLink(
            destination: EditNoteView(note: note)) {
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(width: .infinity, height: 110)
                    .foregroundColor(Color(uiColor: UIColor(named: "CardColor")!))
                    .cornerRadius(15)
                   
                
                VStack(alignment:.leading){
                    Text(note.title)
                        .bold()
                        .font(.system(size: 16))
                        .padding(.bottom, 0.8)
                    
                    Text(note.content)
                        .font(.system(size: 14, weight: .regular))
                        .lineLimit(1)
                        .padding(.bottom, 8)
                    
                    Text(note.date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(Color(uiColor: UIColor(named: "Grey")!))
                       
                    
                }
                .padding(15)
            } .padding(.bottom, 10)
        }
            .listRowBackground(Color.clear)
            .padding(.trailing, -32.0)
       
        
    }
}

struct NoteCard_Previews: PreviewProvider {
    static var previews: some View {
        NoteCard(
            note:  Note(
                id: "1",
                title:  "Last Supper",
                content: "There's a space with white washed walls and two cute", date: "April 3, 2022 01:20 AM"
            )
        )
    }
}
