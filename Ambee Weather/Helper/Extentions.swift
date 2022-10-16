//
//  Extentions.swift
//  Ambee Weather
//
//  Created by suryansh Bisen on 16/10/22.
//

import Foundation

extension Double {
    func toNoDesimal(tillPoint: Int) -> String {
        return String(format: "%.\(tillPoint)f", self)
    }
}

extension String {
    func dateFormate() -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM d"
        
        let date: Date? = dateFormatterGet.date(from: self )
        guard date != nil else { return "" }
        return dateFormatterPrint.string(from: date!);

    }
    
    func getTime() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        let date: Date? = dateFormatterGet.date(from: self )
        guard date != nil else { return "" }
        return dateFormatterPrint.string(from: date!);
    }
}
