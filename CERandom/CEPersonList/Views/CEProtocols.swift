//
//  CEProtocols.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

protocol CEListContextProtocol: class {
    func didSuccessFetching(with indexSet: [IndexPath]?)
    func didFailFetching(with reason: String)
    func didFindSearch(list indexSet: [IndexPath]?)
}

protocol CEPersonViewModelProtocol {
    var reachedMaximum: Bool { get }
    var currentList:Int { get }
    var total: Int { get }
    func startLiveLoading()
    func startStoredLoading()
    func startSearching(for searchText: String?)
    func getPerson(at index: Int) -> Random.Person
    func getImage(from link: String, completion: @escaping (UIImage?) -> Void)
}
protocol CEPersonDetailViewModelProtocol {
    func getLargeImage(from link: String, completion: @escaping (UIImage?) -> Void)
}

extension CEListContextProtocol where Self: UIViewController {
    func didFailFetching(with reason: String) {
        let alert = UIAlertController(title: "Attension", message: reason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .`default`, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

