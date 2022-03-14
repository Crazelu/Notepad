//
//  DateUtil.swift
//  Notepad
//
//  Created by Crazelu on 14/03/2022.
//
import Foundation

class DateUtil{
    
    static func formatDate(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy hh:mm a"
        return dateFormatter.string(from: date)
    }
}
