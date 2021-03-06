# How to pass data in iOS Project
This repository has examples of how to pass data between ViewControllers in iOS Projects.

### Setup
- IDE: `Xcode 11.1` (Version of the Xcode where the project was builded)
- Swift Version: `5.1`
- iOS Target: `13.1`

1. Clone or download the project
```
git clone git@github.com:aureliomarco/ios-pass-data.git
```
2. Go to the directory where the project was cloned or downloaded.
3. Open the project file
```
open passData.xcodeproj
```

## Protocols and Delegates

<p align="left">
  <img width="700" height="441" src="assets/protocols.png">
</p>

### PizzaDelegate.swift
I create the protocol `PizzaDelegate`

```swift
protocol PizzaDelegate {
    func onPizzaReady(type: String) -> String
}
```

Through the `onPizzaReady` I want to send the status order to whenever viewcontroller I want.

In this Example:
From `MainViewController.swift`
to `WineView.swift`

### MainViewController.swift
so in the class `MainViewController`
I apply the protocol to the class, and send the delegate to the `WineViewController`.

```swift
class MainViewController: UIViewController, PizzaDelegate {
    func onPizzaReady(type: String) -> String {
        return "The Pizza of \(type) is coming"
    }

    @IBAction func goToWine(_ sender: Any) {
        let wineVC = WineViewController()
        wineVC.pizzaDelegate = self
        present(wineVC, animated: true, completion: nil)
    }

```

### WineViewController.swift
In the `WineViewController`, I declare the delegate and send to the WineView

```swift
var pizzaDelegate: PizzaDelegate?
```
```swift
private func setupUI() {
    wineView = WineView(frame: view.frame)
    view = wineView
    
    wineView?.pizzaDelegate = pizzaDelegate
}
```

### WineView.swift
In the `WineView` class, I declare the delegate and use the delegate

```swift
var pizzaDelegate: PizzaDelegate?
```

```swift
@objc func updateOrder() {
    let statusOrder = pizzaDelegate?.onPizzaReady(type: pizzaTextField.text ?? "") ?? ""
    statusOrderMessage.text = "Order Status: \(statusOrder)"
}
```