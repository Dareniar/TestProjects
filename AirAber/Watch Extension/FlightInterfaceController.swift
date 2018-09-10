//
//  FlightInterfaceController.swift
//  Watch Extension
//
//  Created by Данил on 9/7/18.
//  Copyright © 2018 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation

class FlightInterfaceController: WKInterfaceController {

  @IBOutlet var flightLabel: WKInterfaceLabel!
  @IBOutlet var routeLabel: WKInterfaceLabel!
  @IBOutlet var boardingLabel: WKInterfaceLabel!
  @IBOutlet var boardTimeLabel: WKInterfaceLabel!
  @IBOutlet var statusLabel: WKInterfaceLabel!
  @IBOutlet var gateLabel: WKInterfaceLabel!
  @IBOutlet var seatLabel: WKInterfaceLabel!
  
  var flight: Flight? {
    
    didSet {
      
      guard let flight = flight else { return }
      
      flightLabel.setText("Flight \(flight.shortNumber)")
      routeLabel.setText(flight.route)
      boardingLabel.setText("\(flight.number) Boards")
      boardTimeLabel.setText(flight.boardsAt)
      
      if flight.onSchedule {
        statusLabel.setText("On Time")
        statusLabel.setTextColor(.green)
      } else {
        statusLabel.setText("Delayed")
        statusLabel.setTextColor(.red)
      }
      
      gateLabel.setText("Gate \(flight.gate)")
      seatLabel.setText("Seat \(flight.seat)")
    }
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    if let flight = context as? Flight {
      self.flight = flight
    }
  }
  

}