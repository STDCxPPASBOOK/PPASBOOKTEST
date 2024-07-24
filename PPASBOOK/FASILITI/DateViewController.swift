import UIKit
import FSCalendar

class DateViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet var warna1: UIView!
    @IBOutlet var warna2: UIView!
    @IBOutlet var warna3: UIView!
    @IBOutlet weak var calendar: FSCalendar!

    var data: YourDataModel? // Property to store received data
    var bookings: [Booking] = []
    let mockFacilityID = "Bilik Meeting"
    let operationStartHour = 8
    let operationEndHour = 18

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureButtonShadows()
        
        // Reload data if it's updated or reset
        if let data = data {
            label1.text = data.label1Text
        }
    }

    private func configureButtonShadows() {
        warna1.layer.cornerRadius = warna1.frame.height / 2
        warna2.layer.cornerRadius = warna2.frame.height / 2
        warna3.layer.cornerRadius = warna3.frame.height / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        
        // Configure FSCalendarAppearance
        let appearance = calendar.appearance
        appearance.titleDefaultColor = .black // Default color for the date titles
        
        mockFetchBookings() // Use mocked data for testing
        
        // Set a specific date to test
        if let testDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
            setFullyBooked(for: testDate) // Test fully booked scenario
            // setAlmostFull(for: testDate) // Test almost full scenario
        }
    }
    
    func mockFetchBookings() {
        // Mock data for testing
        let mockBookings = [
            Booking(id: "1", userID: "user1", date: Date().addingTimeInterval(-3600 * 3), facility: mockFacilityID, additionalInfo: ""),
            Booking(id: "2", userID: "user2", date: Date().addingTimeInterval(3600 * 2), facility: mockFacilityID, additionalInfo: ""),
            Booking(id: "3", userID: "user3", date: Date().addingTimeInterval(3600 * 4), facility: mockFacilityID, additionalInfo: "")
        ]
        self.bookings = mockBookings
        self.calendar.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return bookings.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }.count
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let today = Calendar.current.startOfDay(for: Date())
        let currentDate = Calendar.current.startOfDay(for: date)

        // Past dates
        if currentDate < today {
            return .red
        }
        
        // Weekends
        let weekday = Calendar.current.component(.weekday, from: date)
        if weekday == 7 || weekday == 1 { // 1 = Sunday, 7 = Saturday
            return .red
        }

        let slots = generateTimeSlots(for: date)
        let bookedSlots = bookings.filter { booking in
            slots.contains { slot in
                Calendar.current.isDate(booking.date, inSameDayAs: slot.startTime)
            }
        }
        
        let totalSlots = slots.count
        let bookedCount = bookedSlots.count
        let almostFullThreshold = Int(Double(totalSlots) * 0.75) // 75% of the slots
        
        if bookedCount == totalSlots {
            return .red // Fully booked
        } else if bookedCount >= almostFullThreshold {
            return .yellow // Almost full
        } else {
            return .green // Available
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // Check if the selected date is in the past
        if Calendar.current.startOfDay(for: date) < Calendar.current.startOfDay(for: Date()) {
            let alert = UIAlertController(title: "Unavailable", message: "Booking is not available for past dates.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let weekday = Calendar.current.component(.weekday, from: date)
        if weekday == 7 || weekday == 1 { // 1 = Sunday, 7 = Saturday
            let alert = UIAlertController(title: "Unavailable", message: "Booking is not available on weekends.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        let slots = generateTimeSlots(for: date)
        let bookedSlots = bookings.filter { booking in
            slots.contains { slot in
                Calendar.current.isDate(booking.date, inSameDayAs: slot.startTime)
            }
        }
        
        // Present the slots to the user
        presentTimeSlots(slots: slots, bookedSlots: bookedSlots, selectedDate: date)
    }
    
    func presentTimeSlots(slots: [TimeSlot], bookedSlots: [Booking], selectedDate: Date) {
        let alertController = UIAlertController(title: "Select Time Slot", message: nil, preferredStyle: .actionSheet)
        
        for slot in slots {
            let isBooked = bookedSlots.contains { Calendar.current.isDate($0.date, inSameDayAs: slot.startTime) }
            let title = "\(slot.startTime.hourString) - \(slot.endTime.hourString)"
            let action = UIAlertAction(title: title, style: .default) { _ in
                if isBooked {
                    // Show alert that the slot is already booked
                    let alert = UIAlertController(title: "Slot Unavailable", message: "This time slot is already booked.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.confirmBooking(for: slot)
                }
            }
            // Enable action if slot is not booked and if it's in the future
            action.isEnabled = !isBooked && (selectedDate > Calendar.current.startOfDay(for: Date()) || slot.startTime >= Date())
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func confirmBooking(for slot: TimeSlot) {
        let alertController = UIAlertController(title: "Confirm Booking", message: "Do you want to book this slot?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
            self.addBooking(for: slot)
        })
        present(alertController, animated: true, completion: nil)
    }
    
    func addBooking(for slot: TimeSlot) {
        // Add a new booking to the mock data
        let newBooking = Booking(id: UUID().uuidString, userID: "currentUser", date: slot.startTime, facility: mockFacilityID, additionalInfo: "")
        bookings.append(newBooking)
        self.calendar.reloadData() // Refresh calendar with new booking
    }
    
    func setFullyBooked(for date: Date) {
        let slots = generateTimeSlots(for: date)
        let newBookings = slots.map { TimeSlot in
            Booking(id: UUID().uuidString, userID: "testUser", date: TimeSlot.startTime, facility: mockFacilityID, additionalInfo: "")
        }
        bookings.append(contentsOf: newBookings)
        self.calendar.reloadData()
    }
    
    func setAlmostFull(for date: Date) {
        let slots = generateTimeSlots(for: date)
        let threshold = Int(Double(slots.count) * 0.75) // 75% of the slots
        let newBookings = slots.prefix(threshold).map { TimeSlot in
            Booking(id: UUID().uuidString, userID: "testUser", date: TimeSlot.startTime, facility: mockFacilityID, additionalInfo: "")
        }
        bookings.append(contentsOf: newBookings)
        self.calendar.reloadData()
    }
}

struct Booking {
    var id: String
    var userID: String
    var date: Date
    var facility: String
    var additionalInfo: String
}

struct TimeSlot {
    var startTime: Date
    var endTime: Date
    var isBooked: Bool
}

func generateTimeSlots(for date: Date) -> [TimeSlot] {
    var slots: [TimeSlot] = []
    let calendar = Calendar.current
    let startHour = 8
    let endHour = 18

    for hour in startHour..<endHour {
        if let startTime = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: date),
           let endTime = calendar.date(bySettingHour: hour + 1, minute: 0, second: 0, of: date) {
            let slot = TimeSlot(startTime: startTime, endTime: endTime, isBooked: false)
            slots.append(slot)
        }
    }

    return slots
}

extension Date {
    var hourString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        return formatter.string(from: self)
    }
}
