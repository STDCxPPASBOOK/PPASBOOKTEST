//
//  Booking.swift
//  PPASBOOK
//
//  Created by STDC_14 on 22/07/2024.
//

import Foundation
import FirebaseFirestore

struct Booking {
    var id: String
    var userID: String
    var date: Date
    var facility: String
    var additionalInfo: String
}

struct User {
    var id: String
    var name: String
    var email: String
}

func addBooking(booking: Booking) {
    let db = Firestore.firestore()
    db.collection("bookings").addDocument(data: [
        "userID": booking.userID,
        "date": booking.date,
        "facility": booking.facility,
        "additionalInfo": booking.additionalInfo
    ]) { error in
        if let error = error {
            print("Error adding booking: \(error.localizedDescription)")
        } else {
            print("Booking added successfully")
        }
    }
}
