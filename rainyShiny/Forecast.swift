//
//  Forecast.swift
//  rainyShiny
//
//  Created by ricardo silva on 21/02/2017.
//  Copyright © 2017 ricardo silva. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {

    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!


    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }

    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }

    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }

    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }

    init(weatherDict: Dictionary<String,AnyObject>) {

        if let temp = weatherDict["temp"] as? Dictionary<String,AnyObject> {

            if let min = temp["min"] as? Double {
                self._lowTemp = "\(kelvinToCelcius(kelvin: min))"
            }

            if let max = temp["max"] as? Double {
                self._highTemp = "\(kelvinToCelcius(kelvin: max))"
            }
        }

        if let weather = weatherDict["weather"] as? [Dictionary<String,AnyObject>] {

            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }

        }

        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }


    }

    func kelvinToCelcius(kelvin: Double) -> Double{

        let kelvinToCelcius = (kelvin - 273.15)

        return round(kelvinToCelcius)
    }

}


extension Date{
    func dayOfTheWeek() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEE"

        return dateFormater.string(from: self)
    }
}


