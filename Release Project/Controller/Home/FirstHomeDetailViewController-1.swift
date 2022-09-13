

import UIKit


final class FirstHomeDetailViewController1: BaseViewController {
    
    var mainView = FirstHomeDetailView1()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    override func configureUI() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        
    }
    
    override func setNavigationBar() {
         
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
}

extension FirstHomeDetailViewController1: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstHomeDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? FirstHomeDetailCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.backgroundColor = .green
        cell.itemLabel.text = "아이템이름"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ThirdHomeDetailViewController()
        
        transition(vc, transitionStyle: .presentFull)
        print(#function, "\(indexPath.item)")
    }
    
}
