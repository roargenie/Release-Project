

import Foundation
import Alamofire
import SwiftyJSON

final class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    typealias weatherCompletionHandler = (WeatherModel) -> Void
    
    func getWeather(lat: Double, lon: Double, completionHandler: @escaping weatherCompletionHandler) {
        
        let url = EndPoint.openWeatherURL
        
        let parameter: Parameters = [
            "lat": lat,
            "lon": lon,
            "appid": APIKey.OPENWEATHER
        ]
        
        AF.request(url, method: .get, parameters: parameter).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let weatherData = json["weather"].arrayValue[0]
                let weatherTempData = json["main"]
                
                let name = json["name"].stringValue
                let id = weatherData["id"].intValue
                let main = weatherData["main"].stringValue
                let description = weatherData["description"].stringValue
                let icon = weatherData["icon"].stringValue
                
                let temp = weatherTempData["temp"].doubleValue - 273
                let temp_min = weatherTempData["temp_min"].doubleValue - 273
                let temp_max = weatherTempData["temp_max"].doubleValue - 273
                let weather = WeatherModel(
                    name: name,
                    id: id,
                    main: main,
                    description: description,
                    icon: icon,
                    temp: temp,
                    temp_min: temp_min,
                    temp_max: temp_max)
                completionHandler(weather)
                
            case  .failure(let error):
                print(error)
            }
        }
    }
}


