

import Foundation
import RealmSwift
import UIKit


struct WeatherModel {
    var name = String()
    var id = Int()
    var main = String()
    var description = String()
    var icon = String()
    
    var temp = Double()
    var temp_min = Double()
    var temp_max = Double()
    
    fileprivate let repository = StyleRepository()
    
    func getWeatherImage(id: Int) -> UIImage {
        switch id {
            
        case 200:
            return UIImage(named: "200.png")!
        case 201:
            return UIImage(named: "200.png")!
        case 202:
            return UIImage(named: "202.png")!
        case 210:
            return UIImage(named: "210.png")!
        case 211:
            return UIImage(named: "210.png")!
        case 212:
            return UIImage(named: "210.png")!
        case 221:
            return UIImage(named: "210.png")!
        case 230:
            return UIImage(named: "200.png")!
        case 231:
            return UIImage(named: "200.png")!
        case 232:
            return UIImage(named: "202.png")!
            
        case 300:
            return UIImage(named: "300.png")!
        case 301:
            return UIImage(named: "301.png")!
        case 302:
            return UIImage(named: "301.png")!
        case 310:
            return UIImage(named: "300.png")!
        case 311:
            return UIImage(named: "301.png")!
        case 312:
            return UIImage(named: "300.png")!
        case 313:
            return UIImage(named: "301.png")!
        case 314:
            return UIImage(named: "301.png")!
        case 321:
            return UIImage(named: "301.png")!
            
        case 500:
            return UIImage(named: "301.png")!
        case 501:
            return UIImage(named: "301.png")!
        case 502:
            return UIImage(named: "301.png")!
        case 503:
            return UIImage(named: "301.png")!
        case 504:
            return UIImage(named: "301.png")!
        case 511:
            return UIImage(named: "601.png")!
        case 520:
            return UIImage(named: "301.png")!
        case 521:
            return UIImage(named: "301.png")!
        case 522:
            return UIImage(named: "301.png")!
        case 531:
            return UIImage(named: "301.png")!
            
        case 600:
            return UIImage(named: "602.png")!
        case 601:
            return UIImage(named: "602.png")!
        case 602:
            return UIImage(named: "602.png")!
        case 611:
            return UIImage(named: "602.png")!
        case 612:
            return UIImage(named: "611.png")!
        case 613:
            return UIImage(named: "611.png")!
        case 615:
            return UIImage(named: "611.png")!
        case 616:
            return UIImage(named: "611.png")!
        case 620:
            return UIImage(named: "611.png")!
        case 621:
            return UIImage(named: "611.png")!
        case 622:
            return UIImage(named: "611.png")!
            
        case 701:
            return UIImage(named: "721.png")!
        case 711:
            return UIImage(named: "721.png")!
        case 721:
            return UIImage(named: "721.png")!
        case 731:
            return UIImage(named: "781.png")!
        case 741:
            return UIImage(named: "721.png")!
        case 751:
            return UIImage(named: "751.png")!
        case 761:
            return UIImage(named: "761.png")!
        case 762:
            return UIImage(named: "762.png")!
        case 771:
            return UIImage(named: "771.png")!
        case 781:
            return UIImage(named: "781.png")!
            
        case 800:
            return UIImage(named: "800.png")!
            
        case 801:
            return UIImage(named: "801.png")!
        case 802:
            return UIImage(named: "802.jpg")!
        case 803:
            return UIImage(named: "803.png")!
        case 804:
            return UIImage(named: "804.png")!
            
        default:
            return UIImage()
            
        }
    }
    
    func weatherClothItem(temp: Double) -> Results<ClothItem> {
        switch temp {
            // 겨울
        case ..<5:
            return repository.winterItemFilter().sorted(byKeyPath: "regDate", ascending: false)
            // 봄, 가을
        case 5..<20:
            return repository.spingAndAutumnItemFilter().sorted(byKeyPath: "regDate", ascending: false)
            // 여름
        case 20...:
            return repository.summerItemFilter().sorted(byKeyPath: "regDate", ascending: false)
        default:
            return repository.fetch(ClothItem.self).sorted(byKeyPath: "regDate", ascending: false)
        }
    }
    
    func weatherStyle(temp: Double) -> Results<Style> {
        switch temp {
            // 겨울
        case ..<5:
            return repository.winterStyleFilter().sorted(byKeyPath: "regDate", ascending: false)
            // 봄, 가을
        case 5..<20:
            return repository.springAndAutumnStyleFilter().sorted(byKeyPath: "regDate", ascending: false)
            // 여름
        case 20...:
            return repository.summerStyleFilter().sorted(byKeyPath: "regDate", ascending: false)
        default:
            return repository.fetch(Style.self).sorted(byKeyPath: "regDate", ascending: false)
        }
    }
    
}






