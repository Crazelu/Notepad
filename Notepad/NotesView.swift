//
//  NotesView.swift
//  Notepad
//
//  Created by Crazelu on 13/03/2022.
//

import SwiftUI

struct NotesView: View {
   @State private var notes = [
        Note(
            id: "1",
            title:  "Last Supper",
            content: "There's a space with white washed walls and two cute", date: "February 3, 2022 01:20 AM"
        ),
        Note(
            id: "2",
            title:  "Last Supper2",
            content: "There's a space with white washed walls and two cute", date: "February 9, 2022 11:20 PM"
        )
    ]
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(notes, id:\.self.id){
                        note in
                        NoteCard(
                            note: note
                        )
                            .listRowSeparator(.hidden)
                    }
                }
                VStack{
                    Spacer()
                    HStack{
                        NavigationLink(destination: NewNoteView()){
                            
                            Image(systemName: "plus")
                                .font(.system(size: 26, weight: .medium))
                            
                        }
                        .frame(width: 70, height:70)
                            .background(Color(uiColor: UIColor(named: "AccentColor")!))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        
                    }
                }
                
            }
            .onAppear(perform: {
                //fetch notes here
            })
            .navigationTitle("Notepad")
            .listStyle(PlainListStyle())
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
