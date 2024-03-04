

import UIKit
import SnapKit
import RealmSwift
import CoreLocation
import RxCocoa
import RxSwift
import RxDataSources

final class HomeViewController: BaseViewController {
    
    private var mainView: HomeView
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    private let locationManager = CLLocationManager()
    
//    var clothItemTasks: Results<ClothItem>! {
//        didSet {
//            viewModel.items.accept(viewModel.sections)
////            mainView.collectionView.reloadData()
//        }
//    }
//    var styleTasks: Results<Style>! {
//        didSet {
//            viewModel.items.accept(viewModel.sections)
////            mainView.collectionView.reloadData()
//        }
//    }
//
//    let repository = StyleRepository()
    
//    var weatherData = WeatherModel()
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<HomeSectionModel>(configureCell: { dataSource, collectionView, indexPath, item in
        switch item {
        case .weather(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier, for: indexPath) as! WeatherCollectionViewCell
            cell.setupCell(item)
            return cell
        case .itemRecommend(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemRecommendCollectionViewCell.reuseIdentifier, for: indexPath) as! ItemRecommendCollectionViewCell
            cell.recommendTitleLabel.text = item.title
            return cell
        case .monthOfWeek(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthOfWeekCollectionViewCell.reuseIdentifier, for: indexPath) as! MonthOfWeekCollectionViewCell
            
            return cell
        case .categoryPercent(let item):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryPercentCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryPercentCollectionViewCell
            cell.setupCell(model: item)
            //            print(item)
            return cell
        }
        
    }) { dataSource, collectionView, kind, indexPath in
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReusableHeaderView.identifier, for: indexPath) as! ReusableHeaderView
        headerView.setupView(text: HomeSection(index: indexPath.section).headerTitle)
        return headerView
    }
    
    
    init(mainView: HomeView, viewModel: HomeViewModel) {
        self.mainView = mainView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserDeviceLocationServiceAuthorization()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchRealm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func configureUI() {
        locationManager.delegate = self
    }
    
    private func bind() {
        print(#function)
        let input = HomeViewModel.Input(
            viewDidLoadEvent: Observable.just(()),
            viewWillAppearEvent: self.rx.viewWillAppear.asSignal())
        let output = viewModel.transform(input: input)
        
        output.items
            .drive(mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
//    func fetchRealm() {
//        clothItemTasks = repository.fetch(ClothItem.self)
//        styleTasks = repository.fetchDateBeforeWeekFilter(Style.self)
////        items.accept(sections)
//    }
}

extension HomeViewController {
    
    private func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치서비스가 꺼져 있어 위치권한 요청을 할 수 없습니다.")
        }
    }
    
    private func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT DETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            print("DENIED, 아이폰 설정 유도")
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("WHEN IN USE, 앱을 사용하는 동안 허용")
            locationManager.startUpdatingLocation()
        default:
            print("DEFAULT")
        }
    }
    
    private func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 활성화 해주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let center = locations.last?.coordinate as? CLLocationCoordinate2D {
            viewModel.requestWeatherData(center.latitude, center.longitude)
            // bind가 먼저 돼서 호출시점이 안맞음. RxCoreLocation 써야하나?
//            self.viewModel.coordinate.accept([
//                center.latitude,
//                center.longitude])
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
    
//    @objc private func weatherStyleButtonTapped() {
//        let vc = FirstHomeDetailViewController1()
//        vc.weatherData = weatherData
//        self.tabBarController?.tabBar.isHidden = true
//        self.navigationItem.backButtonTitle = ""
//        transition(vc, transitionStyle: .push)
//    }
//
//    @objc private func weatherItemButtonTapped() {
//        let vc = FirstHomeDetailViewController2()
//        vc.weatherData = weatherData
//        self.tabBarController?.tabBar.isHidden = true
//        self.navigationItem.backButtonTitle = ""
//        transition(vc, transitionStyle: .push)
//    }
    
//    private func fetchRealm() {
//        clothItemTasks = repository.fetch(ClothItem.self)
//        styleTasks = repository.fetchDateBeforeWeekFilter(Style.self)
//    }
//
//    private func checkPercent(query: String) -> Double {
//        let totalCount = repository.fetch(ClothItem.self).count
//        let itemCount = repository.clothItemCategoryFilter(query: query).count
//        let results = Double(itemCount) / Double(totalCount)
//        return results
//    }
//
//    private func checkCategoryCount(query: String) -> Double {
//        let count = repository.clothItemCategoryFilter(query: query).count
//        return Double(count)
//    }
    

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        switch indexPath.section {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewFirstTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewFirstTableViewCell else { return UITableViewCell() }
//            cell.tempLabel.text = "\(String(format: "%.0f", weatherData.temp))°"
//            cell.weatherLabel.text = "최고:\(String(format: "%.0f", weatherData.temp_max))° / 최저:\(String(format: "%.0f", weatherData.temp_min))°"
//            cell.weatherImageView.image = weatherData.getWeatherImage(id: weatherData.id)
//            cell.selectionStyle = .none
//
//            return cell
//        case 1:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewSecondTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewSecondTableViewCell else { return UITableViewCell() }
//            cell.weatherStyleButton.addTarget(self, action: #selector(weatherStyleButtonTapped), for: .touchUpInside)
//            cell.weatherItemButton.addTarget(self, action: #selector(weatherItemButtonTapped), for: .touchUpInside)
//            cell.selectionStyle = .none
//            return cell
//        case 2:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewThirdTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewThirdTableViewCell else { return UITableViewCell() }
//            cell.emptyViewLabel.isHidden = styleTasks.count != 0 ? true : false
//            cell.collectionView.delegate = self
//            cell.collectionView.dataSource = self
//            cell.collectionView.reloadData()
//            cell.selectionStyle = .none
//            return cell
//        case 3:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewFourthTableViewCell.reuseIdentifier, for: indexPath) as? HomeViewFourthTableViewCell else { return UITableViewCell() }
//
//            DispatchQueue.main.async {
//                cell.outerPercent.progressBarDrawing(color: .systemPink, value: self.checkPercent(query: "아우터"))
//                cell.topPercent.progressBarDrawing(color: .systemPink, value: self.checkPercent(query: "상의"))
//                cell.bottomPercent.progressBarDrawing(color: .systemPink, value: self.checkPercent(query: "하의"))
//                cell.shoesPercent.progressBarDrawing(color: .systemPink, value: self.checkPercent(query: "신발"))
//                cell.accPercent.progressBarDrawing(color: .systemPink, value: self.checkPercent(query: "악세"))
//                cell.otherPercent.progressBarDrawing(color: .systemPink, value: self.checkPercent(query: "기타"))
//            }
//            cell.selectionStyle = .none
//            return cell
//        default:
//            break
//        }
//        return UITableViewCell()
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.section {
//        case 0:
//            return 150
//        case 1:
//            return 160
//        case 2:
//            return 190
//        case 3:
//            return 260
//        default:
//            break
//        }
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReusableHeaderView.identifier) as? ReusableHeaderView else { return UIView() }
//
//        switch section {
//        case 0:
//            view.headerLabel.text = "오늘의 날씨에요"
//        case 1:
//            view.headerLabel.text = "오늘 날씨에 이건 어때요?"
//        case 2:
//            view.headerLabel.text = "최근 일주일 모아보기"
//        case 3:
//            view.headerLabel.text = "내 옷장은 이렇답니다"
//        default:
//            break
//        }
//        return view
//    }
//}

//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return styleTasks.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewThirdCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeViewThirdCollectionViewCell else { return UICollectionViewCell() }
//
//        let task = styleTasks[indexPath.item]
//        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
//        return cell
//    }
//
//}
