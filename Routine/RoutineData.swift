//
//  Routine.swift
//  Routine
//
//  Created by Hamilton, Jack on 10/13/21.
//
import CoreData
import SwiftUI

struct Routine: Identifiable {
    let name: String
    let timeStart: String
    let timeEnd: String
    
    let id = UUID()
}

//Reads HH:MM*TM format
extension Routine: Comparable {
    static func < (lhs: Routine, rhs: Routine) -> Bool {
        if let lhrDivider = lhs.timeStart.firstIndex(of: ":"),
           let rhrDivider = rhs.timeStart.firstIndex(of: ":"),
           let lhrSymbolIndex = lhs.timeStart.firstIndex(of: "M"),
           let rhrSymbolIndex = rhs.timeStart.firstIndex(of: "M") {
            
            let lhrSymbolIndexAdjusted = lhs.timeStart.index(lhrSymbolIndex, offsetBy: -1)
            let rhrSymbolIndexAdjusted = rhs.timeStart.index(rhrSymbolIndex, offsetBy: -1)
            
            guard var lhr = Int(String(lhs.timeStart.prefix(upTo: lhrDivider))),
                  let lmin = Int(String(lhs.timeStart[lhs.timeStart.index(lhrDivider, offsetBy: 1)..<lhrSymbolIndexAdjusted]).trimmingCharacters(in: .whitespacesAndNewlines)),
                  var rhr = Int(String(rhs.timeStart.prefix(upTo: rhrDivider))),
                  let rmin = Int(String(rhs.timeStart[rhs.timeStart.index(rhrDivider, offsetBy: 1)..<rhrSymbolIndexAdjusted]).trimmingCharacters(in: .whitespacesAndNewlines))
                else {
                    return false
                }
            
            let lSym = String(lhs.timeStart.suffix(from: lhrSymbolIndexAdjusted))
            let rSym = String(rhs.timeStart.suffix(from: rhrSymbolIndexAdjusted))
            if lSym == "PM" {
                lhr += 12
            }
            if rSym == "PM" {
                rhr += 12
            }
            
            if lhr < rhr {
                return true
            } else if lhr == rhr {
                return lmin < rmin
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
