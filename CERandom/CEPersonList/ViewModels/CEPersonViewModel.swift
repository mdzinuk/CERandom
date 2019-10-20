//
//  CEPersonViewModel.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

final class CEPersonViewModel {
    weak var viewContext: CEListContextProtocol?
    private var service: CEServiceProtocol?
    
    // Note: Pagignation, will move to new class
    private var availablePersons: [Random.Person] = []
    private var currentPage = 1
    private var totalPersons = 0
    private var isFetchInProgress = false
    private var isFetchingAllowed = true
    
    //Mark: Searching
    private var isSearching = false
    private var filteredPersons : [Random.Person] = []
    
    private static let maximumPageToReload = 10
    private static let maximumListAllowed = 15
    
    init(context: CEListContextProtocol) {
        viewContext = context
    }
    private func modifiedIndeces(from newList: [Random.Person]) -> [IndexPath] {
        let startIndex = availablePersons.count - newList.count
        let endIndex = startIndex + newList.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

//Mark: CEPersonViewModelProtocol
extension CEPersonViewModel: CEPersonViewModelProtocol {
    var total: Int {
        return isSearching ? filteredPersons.count : totalPersons + 1
    }
    var currentList: Int {
        return isSearching ? filteredPersons.count : availablePersons.count
    }
    var reachedMaximum: Bool {
        return !isFetchingAllowed
    }
    func startLiveLoading() {
        if service == nil { service = CEService() }
        
        if currentPage > CEPersonViewModel.maximumPageToReload {
            isFetchingAllowed = false
        }
        
        guard !isFetchInProgress && isFetchingAllowed else { return }
        isFetchInProgress = true
        
        let params:CEStringDictionary = ["page": "\(currentPage)", "nat":"gb","results":"\(CEPersonViewModel.maximumListAllowed)"]
        service?.fetchPeople(for: params) { (result: CEServiceReply<Random, CEError>) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.isFetchInProgress = false
                    strongSelf.isFetchingAllowed = false
                    strongSelf.viewContext?.didFailFetching(with: error.localizedDescription)
                    strongSelf.startStoredLoading()
                }
            case .success(let list):
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.currentPage += 1
                    strongSelf.isFetchInProgress = false
                    strongSelf.availablePersons.append(contentsOf: list.persons)
                    strongSelf.totalPersons += list.persons.count
                    if list.page.number > 1 {
                        let indexPathsToReload = strongSelf.modifiedIndeces(from: list.persons)
                        strongSelf.viewContext?.didSuccessFetching(with: indexPathsToReload)
                    } else {
                        strongSelf.viewContext?.didSuccessFetching(with: .none)
                    }
                }
            }
        }
    }
    func startStoredLoading() {
        if service == nil { service = CEService() }
        
        service?.fetchPeopleFromCoreData(completion: { (result: CEServiceReply<[Random.Person], CEError>) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.viewContext?.didFailFetching(with: error.localizedDescription)
                }
            case .success(let list):
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.availablePersons.removeAll()
                    strongSelf.availablePersons.append(contentsOf: list)
                    strongSelf.totalPersons += list.count
                    
                    let indexPathsToReload = strongSelf.modifiedIndeces(from: list)
                    strongSelf.viewContext?.didSuccessFetching(with: indexPathsToReload)
                }
            }
        })
    }
    func startSearching(for searchText: String? = .none) {
        guard let text = searchText, text.count > 0 else {
            isSearching = false
            viewContext?.didFindSearch(list: .none)
            return
        }
        isSearching = true
        filteredPersons.removeAll()
        let search = availablePersons.filter { $0.fullName.contains(text) }
        filteredPersons.append(contentsOf: search)
        
        let indexSet = modifiedIndeces(from: search)
        viewContext?.didFindSearch(list: indexSet)
    }
    func getPerson(at index: Int) -> Random.Person {
        if isSearching {
            return filteredPersons[index]
        } else {
            return availablePersons[index]
        }
    }
    func getImage(from link: String, completion: @escaping (UIImage?) -> Void) {
        if service == nil { service = CEService() }
        service?.downloadImage(for: link, completion: { (result: CEServiceReply<UIImage, CEError>) in
            switch result {
            case .failure( _):
                completion(.none)
            case .success(let image):
                completion(image)
            }
        })
    }
}
