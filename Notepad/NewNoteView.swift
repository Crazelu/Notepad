//
//  NewNoteView.swift
//  Notepad
//
//  Created by Crazelu on 13/03/2022.
//

import SwiftUI

struct NewNoteView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var title:String = ""
    @State private var noteBody:String = ""
    private let date = Date()
    
    func formatDate()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy hh:mm a"
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
            
            MultilineTextField("Title", text: $title)
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 10)
            
            MultilineTextField("Note something down", text: $noteBody)
                .multilineTextAlignment(.leading)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color(uiColor: UIColor(named: "Grey")!))
            
            Spacer()
               
            
        }
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

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
    }
}
