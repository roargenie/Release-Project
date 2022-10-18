

import UIKit


final class DetailImageViewController: UIViewController {
    
    private var mainView = DetailImageView()
    
    var styleTask = Style()
    var clothTask = ClothItem()
    
    var viewStatus: DetailImageViewStatus = .cloth
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .black
        mainView.scrollView.delegate = self
        if viewStatus == .cloth {
            mainView.detailImageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(clothTask.objectId).jpg")
        } else {
            mainView.detailImageView.image = FileManagerHelper.shared.loadImageFromDocument(fileName: "\(styleTask.objectId).jpg")
        }
        
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension DetailImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mainView.detailImageView
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.zoomScale <= 1.0 {
            scrollView.zoomScale = 1.0
        }
        if scrollView.zoomScale >= 2.0 {
            scrollView.zoomScale = 2.0
        }
    }
}
