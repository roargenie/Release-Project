

import UIKit
import RealmSwift


final class FirstHomeDetailViewController2: BaseViewController {
    
    private let mainView = FirstHomeDetailView1()
    
    private let repository = StyleRepository()
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var weatherData = WeatherModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func fetchRealm() {
        clothItemTasks = weatherData.weatherClothItem(temp: weatherData.temp)
    }
    
}

extension FirstHomeDetailViewController2: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainView.emptyViewLabel.isHidden = clothItemTasks.count != 0 ? true : false
        return clothItemTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? FirstHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let task = clothItemTasks[indexPath.item]
        
        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        //cell.itemLabel.text = task.itemName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SecondHomeDetailViewController()
        vc.datatask = clothItemTasks[indexPath.item]
        vc.viewStatus = .read
        self.navigationItem.backButtonTitle = ""
        transition(vc, transitionStyle: .push)
        print(#function, "\(indexPath.item)")
    }
    
}

