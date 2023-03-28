

import UIKit
import RealmSwift

final class FirstHomeDetailViewController1: BaseViewController {
    
    private var mainView = FirstHomeDetailView1()
    
    private let repository = StyleRepository.shared
    
    var styleTasks: Results<Style>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var clothItemTasks: Results<ClothItem>!
    
//    var weatherData = WeatherModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchRealm()
    }
    
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
//    private func fetchRealm() {
//        styleTasks = weatherData.weatherStyle(temp: weatherData.temp)
//    }
    
}

extension FirstHomeDetailViewController1: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainView.emptyViewLabel.isHidden = styleTasks.count != 0 ? true : false
        return styleTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? FirstHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let task = styleTasks[indexPath.item]
        
        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ThirdHomeDetailViewController()
        vc.dataTasks = styleTasks[indexPath.item]
        vc.viewStatus = .read
        self.navigationItem.backButtonTitle = ""
        transition(vc, transitionStyle: .push)
        print(#function, "\(indexPath.item)")
    }
    
}
