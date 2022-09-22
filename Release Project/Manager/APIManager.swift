

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
                
                var weather = WeatherModel()
                
                let weatherData = json["weather"].arrayValue[0]
                let weatherTempData = json["main"]
                
                weather.name = json["name"].stringValue
                weather.id = weatherData["id"].intValue
                weather.main = weatherData["main"].stringValue
                weather.description = weatherData["description"].stringValue
                weather.icon = weatherData["icon"].stringValue
                
                weather.temp = weatherTempData["temp"].doubleValue - 273
                weather.temp_min = weatherTempData["temp_min"].doubleValue - 273
                weather.temp_max = weatherTempData["temp_max"].doubleValue - 273
                
                completionHandler(weather)
                
            case  .failure(let error):
                print(error)
            }
        }
    }
}


