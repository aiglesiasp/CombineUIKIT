//
//  BootCampsViewModel.swift
//  CombineUIKit
//
//  Created by Aitor Iglesias Pubill on 6/12/22.
//

import Foundation
import Combine

//MODELO
struct BootCamps: Codable {
    let id: UUID
    let name: String
}

//Extension para devolver el codigo de error
extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

//VIEW MODEL
final class viewModelBootcamps: ObservableObject {
    
    @Published var bootCamps: [BootCamps] = Array<BootCamps>()
    
    var suscriptors = Set<AnyCancellable>()
    
    func loadBootcamps() {
        
        let url = URL(string: "https://dragonball.keepcoding.education/api/data/bootcamps")
        var request: URLRequest = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.getStatusCode() == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: [BootCamps].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("OK")
                case .failure(let error):
                    print("error: \(error)")
                    
                
                }
            } receiveValue: { data in
                self.bootCamps = data
            }
            .store(in: &suscriptors)
    }
}
