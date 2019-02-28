## When do we know the animation of pushing new view controller ends?

*Written by: __Nguyen Minh Tam__*

Câu hỏi được đặt ra là khi nào thì chúng mình biết animation của push view controller kết thúc nhỉ?

Chúng mình có thể xài các cách dưới đây:

- Sử dụng `UINavigationControllerDelegate`
- Sử dụng `CATransaction`


#### Sử dụng `CATransaction`:

Viết `extension` cho `UINavigationControllerDelegate`:

```swift
extension UINavigationController {
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
```

Ví dụ:

```swift
final class NaviPushCompletionVC1: UIViewController {
    ...
    @IBAction private func pushBtnTouchInside() {
        navigationController?.pushViewControllerCompletion(NaviPushCompletionVC1(),
                                                           animated: true) { [weak self] in
            self?.view.backgroundColor = .orange
        }
    }
}
```


#### Sử dụng `UINavigationControllerDelegate`

Các bước implement:

- Bước 1: Gán `navigationController?.delegate = self`.
- Bước 2: Khai báo closure `var completion: (() -> Void)?` dùng để handle action khi push view controller mới.
- Bước 3: Set up task cần handle trong closure `completion` trước khi push view controller mới.
- Bước 4: Implement `func navigationController(_:didShow:animated:)` và gọi closure `completion`.

```swift
final class NaviPushCompletionVC2: UIViewController {

    // Step 2: Define a closure for handling the action pushing new view controller completion 
	/// Handle action pushing/popping view controller completion
    var completion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 1: Conform UINavigationControllerDelegate
        navigationController?.delegate = self
    }

    @IBAction private func pushBtnTouchInside() {
        let vc = ViewController()
        
        // Step 3: Config the completion block
        vc.completion = { [weak self] in
            guard let this = self else { return }
            this.view.backgroundColor = .green
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NaviPushCompletionVC2: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Step 4: Implement this function and call the comletion block when complete pushing/popping
        completion?()
    }
}
```



#### Bên cạnh đó

Nếu chúng mình muốn làm một số thứ màu mè trong suốt quá trình transition (push/pop view controller) thì giải pháp đây:

Sử dụng `transitionCoordinator`:

```swift
extension UINavigationController {
    func pushViewControllerAlongsideTransision(_ viewController: UIViewController,
                                      animated: Bool,
                                      alongsideTransition: (() -> Void)?,
                                      completion: @escaping (() -> Void)) {
        pushViewController(viewController, animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            alongsideTransition?()
        }, completion: { _ in
            completion()
        })
    }

    func popViewControllerAlongsideTransision(_ viewController: UIViewController,
                                              animated: Bool,
                                              alongsideTransition: (() -> Void)?,
                                              completion: @escaping (() -> Void)) {
        popViewController(animated: animated)
        guard animated, let coordinator = transitionCoordinator else {
            completion()
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            alongsideTransition?()
        }, completion: { _ in
            completion()
        })
    }
}
```

Ví dụ chúng mình có thế add thêm một label thông báo khi đang transition giữa hai màn hình như sau:

```swift
final class NaviPushAlongsideTransitionCompletionVC: UIViewController {
    ...
    @IBAction private func pushBtnTouchInside() {
        let transitionLabel = UILabel(frame: CGRect(x: 0, y: (screenWidth - labelHeight) / 2,
                                                    width: screenWidth, height: labelHeight))
        transitionLabel.text = "Transitioning..."
        transitionLabel.backgroundColor = .magenta

        let vc = NaviPushAlongsideTransitionCompletionVC()
        navigationController?
            .pushViewControllerAlongsideTransision(vc,
                                                   animated: true,
                                                   alongsideTransition: { [weak self] in
                    guard let this = self else { return }
                    this.navigationController?.view.addSubview(transitionLabel)
                }, completion: {
                    transitionLabel.removeFromSuperview()
            })
    }
}
```
