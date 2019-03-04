## Expandling UITableView cell with UIStackView

*Written by: __Nguyen Minh Tam__*


__Lời khuyên:__ Recommend đối với những list ít item và cố định hoặc đối với yêu cầu expanding item đơn giản.

Sau đây là ví dụ expanding cell tự co giãn đơn giản:

![ExpandingCellWithUIStackView-3](https://github.com/nmint8m/daijobu/blob/master/Documents/Images/ExpandingCellWithUIStackView-3.gif)

Cách thức hoạt động: Trong cell chứa `stackView` có hai view con là `titleButton` và `descriptionLabel`. Khi nhấn vào `titleButton` thì expanding / collapse chính cell đó bằng cách ẩn / hiện `descriptionLabel` và reload cell.

Tham khảo thêm cell tự co giãn tại [UITableViewCell self-sizing]().



### Bước 1

Layout cho `UITableViewCell` `ExpandingTableViewCellWithStackViewVC`:

![ExpandingCellWithUIStackView-2](https://github.com/nmint8m/daijobu/blob/master/Documents/Images/ExpandingCellWithUIStackView-2.png)

Auto layout cho `UITableViewCell` `ExpandingTableViewCellWithStackViewVC` như sau:

![ExpandingCellWithUIStackView-1](https://github.com/nmint8m/daijobu/blob/master/Documents/Images/ExpandingCellWithUIStackView-1.png)



### Bước 2

Config cho `UITableView` `tableView` để cell có thể tự co giãn theo nội dung bên trong:

```swift
// ExpandingTableViewCellWithStackViewVC.swift
    private func configTableView() {
        let nib = UINib(nibName: ExpandingTableViewCellWithStackViewVC.cell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ExpandingTableViewCellWithStackViewVC.cell)
        tableView.estimatedRowHeight = 500 // Using estimatedRowHeight instead of rowHeight
        tableView.dataSource = self
    }
```

Config data source cho `tableView` như sau:

```swift
// ExpandingTableViewCellWithStackViewVC.swift
extension ExpandingTableViewCellWithStackViewVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {...}

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {...}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EnhundingTableViewCellWithStackViewVC.cell, for: indexPath) as? ExpandingWithStackViewCell,
            indexPath.row < isExpandingData.count,
            let infor = InformationType(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configCell(isExpanding: isExpandingData[indexPath.row],
                        title: infor.title,
                        description: infor.description)
        cell.delegate = self
        return cell
    }
}
```



### Bước 3

Config `ExpandingWithStackViewCell` như sau:

```swift
// ExpandingWithStackViewCell.swift
protocol ExpandingWithStackViewCellDelegate: class {
    func cell(_ cell: ExpandingWithStackViewCell,
              needsPerform action: ExpandingWithStackViewCell.Action)
}

final class ExpandingWithStackViewCell: UITableViewCell {

    // MARK: - Property
    weak var delegate: ExpandingWithStackViewCellDelegate?
    ...
    func configCell(isExpanding: Bool, title: String, description: String) {
        descriptionLabel.isHidden = !isExpanding
        titleButton.setTitle(title, for: .normal)
        descriptionLabel.text = description
    }

    // MARK: - IBAction
    @IBAction func titleButtonTouchUpInside(_ sender: Any) {
        delegate?.cell(self, needsPerform: .expandOrColapse)
    }

    enum Action {
        case expandOrColapse
    }
}
```



### Bước 4

Để view controller biết được khi nào người dùng bấm vào `titleButton`, thì `ExpandingTableViewCellWithStackViewVC` cần conform `protocol ExpandingWithStackViewCellDelegate`.

Khi người dùng bấm vào `titleButton`, cell sẽ delegate tác vụ lên view controller xử lý. Ở đây, view controller thay đổi và lưu lại trạng thái `isExpandingData`, bên cạnh đó, reload lại chính cell đó.

Implement function của `protocol ExpandingWithStackViewCellDelegate` như sau:

```swift
// ExpandingTableViewCellWithStackViewVC.swift
extension ExpandingTableViewCellWithStackViewVC: ExpandingWithStackViewCellDelegate {
    func cell(_ cell: ExpandingWithStackViewCell, needsPerform action: ExpandingWithStackViewCell.Action) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        isExpandingData[indexPath.row] = !isExpandingData[indexPath.row]
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
}
```



### Reference