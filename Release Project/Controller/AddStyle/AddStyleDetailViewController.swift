

import UIKit


final class AddStyleDetailViewController: BaseViewController {
    
    var mainView = AddStyleDetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
        navigationItem.rightBarButtonItems = [doneButton]
    }
    
    @objc func doneButtonTapped() {
        
    }
    
    
}


extension AddStyleDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddStyleDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? AddStyleDetailCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .systemPink
        
        return cell
    }
    
    
}
