//
//  NotesView.swift
//  Notepad
//
//  Created by Crazelu on 13/03/2022.
//

import SwiftUI

struct NotesView: View {
    @State private var notes: [Note] = []
    var body: some View {
        NavigationView{
            ZStack{
                List(self.notes){
                    (note) in
                    NoteCard(
                        note: note
                    )
                        .listRowSeparator(.hidden)
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
                self.notes = DBService().fetchNotes()
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
