

import UIKit
import RealmSwift


final class SecondHomeDetailViewController: BaseViewController {
    
    private var mainView = SecondHomeDetailView()
    
    private let repository = StyleRepository()
    
    var clothItemTasks: Results<ClothItem>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var styleTasks: Results<Style>! {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    
    var viewStatus: ItemViewStatus = .read
    
    var datatask = ClothItem()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setConstraints() {
        if viewStatus == .edit {
            let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteButtonTapped))
            navigationItem.rightBarButtonItems = [deleteButton]
        } else {
            
        }
    }
    
    override func setNavigationBar() {
        
    }
    
    private func fetchRealm() {
        clothItemTasks = repository.fetch(ClothItem.self)
        styleTasks = repository.styleContainsClothItemFilter(item: datatask)
    }
    
    @objc func deleteButtonTapped() {
        showAlertMessage(title: "삭제하시겠습니까?", button: "네, 삭제할게요!") { _ in
            self.repository.deleteClothItem(item: self.datatask)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func touchUpImageView() {
        let vc = DetailImageViewController()
        vc.clothTask = datatask
        vc.viewStatus = .cloth
        transition(vc, transitionStyle: .presentFull)
    }
}

extension SecondHomeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainView.emptyViewLabel.isHidden = styleTasks.count != 0 ? true : false
        return styleTasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        
        let task = styleTasks[indexPath.item]
        
        cell.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(task.objectId).jpg")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeDetailCollectionReusableView.identifier, for: indexPath) as! HomeDetailCollectionReusableView
            
            let task = datatask
            var seasonArr: [String] = []
            for i in task.season {
                seasonArr.append(i.title)
            }
            let seasonStr = seasonArr.joined(separator: ", ")
            
            headerView.categoryContentLabel.text = task.category.first?.title
            headerView.seasonContentLabel.text = seasonStr
            headerView.wornCountContentLabel.text = String(task.wornCount)
            headerView.imageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(datatask.objectId).jpg")
            setupTapGestures(imageView: headerView.imageView, selector: #selector(touchUpImageView))
            
            return headerView
        default:
        #if DEBUG
            assert(false)
        #else
            return UICollectionReusableView()
        #endif
        }
    }
}
