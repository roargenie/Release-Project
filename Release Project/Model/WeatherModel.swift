

import Foundation
import RealmSwift


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
    
    func getWeatherText(id: Int) -> String {
        switch id {
            
        case 200:
            return "가벼운 비를 동반한 천둥번개 ⛈"
        case 201:
            return "비를 동반한 천둥번개 ⛈"
        case 202:
            return "강한 비를 동반한 천둥번개 ⛈"
        case 210:
            return "가벼운 천둥번개 ⚡️"
        case 211:
            return "천둥번개 ⚡️"
        case 212:
            return "강한 천둥번개 ⚡️"
        case 221:
            return "간헐적 천둥번개 ⚡️"
        case 230:
            return "가벼운 이슬비와 천둥번개 🌩"
        case 231:
            return "이슬비와 천둥번개 🌩"
        case 232:
            return "강한 이슬비와 천둥번개 ⛈"
            
        case 300:
            return "가벼운 보슬비 🌦"
        case 301:
            return "보슬비 🌧"
        case 302:
            return "강하게 오는 이슬비 🌧"
        case 310:
            return "가벼운 강도의 이슬비 🌦"
        case 311:
            return "이슬비 🌧"
        case 312:
            return "강하게 오는 이슬비 🌧"
        case 313:
            return "소나기처럼 오는 비와 이슬비 ☔️"
        case 314:
            return "강한 소나기의 이슬비 ☔️"
        case 321:
            return "소나기 이슬비 ☔️"
            
        case 500:
            return "가벼운 비 🌦"
        case 501:
            return "적당한 비 🌧"
        case 502:
            return "강한 비 🌧"
        case 503:
            return "매우 강한 비 🌧"
        case 504:
            return "짱 강한 비 🌧"
        case 511:
            return "얼어붙는 비 ❄️🌧"
        case 520:
            return "가벼운 소나기 ☔️"
        case 521:
            return "소나기 ☔️"
        case 522:
            return "강한 소나기 ☔️☔️"
        case 531:
            return "듬성듬성 오는 소나기 ☔️"
            
        case 600:
            return "가벼운 눈 ❄️"
        case 601:
            return "눈 🌨"
        case 602:
            return "함박눈 ☃️"
        case 611:
            return "진눈깨비 🌨🌧"
        case 612:
            return "가벼운 진눈깨비 🌨☔️"
        case 613:
            return "소나기 진눈깨비 🌨☔️"
        case 615:
            return "얕은 비와 눈 🌨🌧"
        case 616:
            return "비와 눈 🌨🌧"
        case 620:
            return "가벼운 소낙눈 ❄️"
        case 621:
            return "소낙눈 ❄️"
        case 622:
            return "강한 소낙눈 ❄️🌨"
            
        case 701:
            return "미스트: 안개 🌫"
        case 711:
            return "스모크: 연기 😶‍🌫️"
        case 721:
            return "헤이즈: 안개 🌫"
        case 731:
            return "모래/먼지 소용돌이 🌪"
        case 741:
            return "포그: 안개 🌫"
        case 751:
            return "모래 🏜"
        case 761:
            return "먼지 💨"
        case 762:
            return "화산재 🌋"
        case 771:
            return "돌풍 🌀"
        case 781:
            return "토네이도 🌪"
            
        case 800:
            return "맑고 화창한 날씨 ☀️"
            
        case 801:
            return "11~25%의 적은 구름이 있는 흐린 날씨 🌤"
        case 802:
            return "25~50%가 구름으로 뒤덮인 날씨 ⛅️"
        case 803:
            return "51~84%의 구름이 있는 흐린 날씨 🌥"
        case 804:
            return "하늘에 85~100%가 구름으로 뒤덮인 날씨 ☁️"
            
        default:
            return "\(self.id)"
            
        }
    }
    
    func weatherClothItem(temp: Double) -> Results<ClothItem> {
        switch temp {
            // 겨울
        case ..<5:
            return repository.winterItemFilter()
            // 봄, 가을
        case 5..<20:
            return repository.spingAndAutumnItemFilter()
            // 여름
        case 20...:
            return repository.summerItemFilter()
        default:
            return repository.fetch(ClothItem.self)
        }
    }
    
    func weatherStyle(temp: Double) -> Results<Style> {
        switch temp {
            // 겨울
        case ..<5:
            return repository.winterStyleFilter()
            // 봄, 가을
        case 5..<20:
            return repository.springAndAutumnStyleFilter()
            // 여름
        case 20...:
            return repository.summerStyleFilter()
        default:
            return repository.fetch(Style.self)
        }
    }
    
}






