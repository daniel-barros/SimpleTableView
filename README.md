# SimpleTableView
![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
![Platform](https://img.shields.io/badge/platforms-iOS%208.0+-333333.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

UITableView subclass with a one-line setup.

If you need a very basic table view but don't want to write all the data source boilerplate code for the n-th time this might help you.

It handles the registering of cell reuse identifiers and provides a basic implementation of data source methods for you.


## Installation

Drag the whole project into your workspace, build it, and add the framework to the Embedded Binaries of your project.

Or just copy the three .swift files into your project.

## Usage

1) Create a UITableViewCell subclass that conforms to Configurable and Reusable.

2) Call `set(cellType:data:)` passing your UITableViewCell type and the data you want to show.

## Example

```swift
import UIKit
import SimpleTableView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // You can also create your table view in a Storyboard (like a regular UITableView)
        let tableView = SimpleTableView(frame: view.frame)
        view.addSubview(tableView)
        // Setting up your table view is this simple
        tableView.set(cellType: ColorCell.self, data: [(.white, "white"), (.blue, "blue"), (.gray, "gray")])
    }
}

class ColorCell: UITableViewCell, Configurable, Reusable {
    // This function declared in Configurable lets the cell know how to show your data.
    func configure(with value: (UIColor, String)) {
        backgroundColor = value.0
        textLabel?.text = value.1
    }
}
```

