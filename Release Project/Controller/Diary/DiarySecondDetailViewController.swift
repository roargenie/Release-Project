

import UIKit


final class DiarySecondDetailViewController: BasePopUpViewController {
    
    var mainView = SecondDiaryDetailView()
    
    var datatask = Style()
    
    let repository = StyleRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        mainView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        mainView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        mainView.textView.text = datatask.contents
        mainView.regDateLabel.text = datatask.regDate.formatted()
    }
    
    override func setConstraints() {
        
    }
    
    @objc func saveButtonTapped() {
        guard let text = mainView.textView.text else { return }
        repository.updateStyle(item: datatask, contents: text)
        self.dismiss(animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}
