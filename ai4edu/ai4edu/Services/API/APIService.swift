//
//  APIService.swift
//  ai4edu
//
//  Created by Sam Jin on 3/24/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://ai4edu-api.jerryang.org/v1/prod"
    
    private init() {}
    
    // MARK: - SSO Methods
    
    func getSSOURL(returnURL: String) -> URL? {
        let baseSSO = "https://login.case.edu/cas/login"
        let ssoVerifyURL = "\(APIEnvironment.onlineBaseURL)\(APIEnvironment.prodPath)/user/sso"
        
        let urlString = "\(baseSSO)?service=\(ssoVerifyURL)?came_from=\(returnURL)"
        return URL(string: urlString)
    }
    
    func handleSSOCallback(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            return false
        }
        
        let refreshToken = queryItems.first(where: { $0.name == "refresh" })?.value
        let accessToken = queryItems.first(where: { $0.name == "access" })?.value
        
        if let refresh = refreshToken, let access = accessToken {
            TokenManager.shared.saveTokens(refresh: refresh, access: access)
            
            return true
        }
        
        return false
    }
    
    // MARK: - Fetch Agents
    
    func fetchAgents(page: Int, pageSize: Int, workspaceId: String, completion: @escaping (Result<AgentsListResponse, Error>) -> Void) {
        let endpoint = "/admin/agents/agents"
        
        var urlComponents = URLComponents(string: baseURL + endpoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "page_size", value: "\(pageSize)"),
            URLQueryItem(name: "workspace_id", value: workspaceId)
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let accessToken = TokenManager.shared.getAccessToken() {
            request.addValue("Bearer access=\(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(AgentsListResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Fetch User List
    
    func fetchUserList(page: Int, pageSize: Int, workspaceId: String, completion: @escaping (Result<UserListResponse, Error>) -> Void) {
        let endpoint = "/admin/access/get_user_list"
        
        var urlComponents = URLComponents(string: baseURL + endpoint)
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "page_size", value: "\(pageSize)"),
            URLQueryItem(name: "workspace_id", value: workspaceId)
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let accessToken = TokenManager.shared.getAccessToken() {
            request.addValue("Bearer access=\(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(UserListResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// API Environment configuration
enum APIEnvironment {
    static let onlineBaseURL = "https://ai4edu-api.jerryang.org"
    static let prodPath = "/v1/prod"
}

// MARK: - API Errors

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received from server"
        case .decodingError:
            return "Error decoding response"
        case .networkError:
            return "Network error"
        }
    }
}
