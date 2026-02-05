# UIKit Common Types

@PageImage(purpose: card, source: "snippets-uikit-common-types-card.codex", alt: "Placeholder card")
@PageImage(purpose: icon, source: "snippets-uikit-common-types-icon.codex", alt: "Placeholder icon")

@Image(source: "snippets-uikit-common-types-hero.codex", alt: "UIKit common types hero")

Short snippets to drill UIKit basics.

```swift
import UIKit

final class HomeViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
  }
}
```

```swift
import UIKit

let label = UILabel()
label.text = "Hello UIKit"
label.font = .preferredFont(forTextStyle: .title2)
label.textColor = .label
```

```swift
import UIKit

let button = UIButton(type: .system)
button.setTitle("Tap", for: .normal)
button.addTarget(nil, action: #selector(tap), for: .touchUpInside)
```

```swift
import UIKit

let stack = UIStackView()
stack.axis = .vertical
stack.spacing = 12
stack.alignment = .fill
```

```swift
import UIKit

final class TableController: UITableViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
  }
}
```

```swift
import UIKit

let layout = UICollectionViewFlowLayout()
layout.itemSize = CGSize(width: 120, height: 80)
layout.minimumLineSpacing = 12
```

```swift
import UIKit

let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
imageView.contentMode = .scaleAspectFit
imageView.tintColor = .systemYellow
```

```swift
import UIKit

final class FieldViewController: UIViewController, UITextFieldDelegate {
  let textField = UITextField()

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
```

```swift
import UIKit

let scrollView = UIScrollView()
scrollView.alwaysBounceVertical = true
scrollView.showsVerticalScrollIndicator = true
```

```swift
import UIKit

UIView.animate(withDuration: 0.25) {
  view.alpha = 0.0
}
```
