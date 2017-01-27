//
//  SimpleTableView.swift
//  SimpleTableView
//
//  Created by Daniel Barros López on 1/27/17.
//
//  Copyright (c) 2017 Daniel Barros López
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

/// UITableView subclass with a one-line setup. No need to implement data source functions nor register cell reuse identifiers.
///
/// **Instructions**:
///
/// 1 - Create a UITableViewCell subclass that conforms to Configurable and Reusable.
///
/// 2 - Call `set(cellType:data:)` passing your UITableViewCell type and the data you want to show.
public class SimpleTableView: UITableView {
    
    private var simpleDataSource: UITableViewDataSource?
    
    public func set<CellType>(cellType: CellType.Type, data: [CellType.T]) where CellType: UITableViewCell, CellType: Reusable & Configurable {
        let ds: SimpleTableViewDataSource<CellType>
        if let dataSource = dataSource as? SimpleTableViewDataSource<CellType> {
            ds = dataSource
        } else {
            register(CellType.self, forCellReuseIdentifier: CellType.reuseIdentifier)
            ds = SimpleTableViewDataSource<CellType>()
            simpleDataSource = ds   // need to retain it
            dataSource = ds
        }
        ds.data = data
        reloadData()
    }
}


class SimpleTableViewDataSource<CellType>: NSObject, UITableViewDataSource where CellType: UITableViewCell, CellType: Reusable & Configurable {
    
    var data: [CellType.T] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseIdentifier, for: indexPath) as! CellType
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
