//
//  ModelTypes.swift
//  ai4edu
//
//  Created by Sam Jin on 3/25/25.
//

import Foundation

// MARK: - Message Types

struct Message: Identifiable {
    let id: String
    var content: String
    let align: String // "start" for bot, "end" for user
    var user_id: String?
    var MsgId: String?
    var sources: [Source]?
    var currentChatSession: Bool?
    var role: String? // Store the message role: "human" or "openai"
}

// MARK: - API Response Types

struct ChatResponse {
    let threadId: String
    let messageId: String
    let content: String
    let sources: [Source]?
}

struct MessageResponse: Codable {
    let response: String
    let source: [Source]?
    let ttsSessionId: String
    let ttsMaxChunkId: Int
    let msgId: String?
    
    enum CodingKeys: String, CodingKey {
        case response, source
        case ttsSessionId = "tts_session_id"
        case ttsMaxChunkId = "tts_max_chunk_id"
        case msgId = "msg_id"
    }
    
    var messageId: String {
        return msgId ?? UUID().uuidString
    }
    
    var content: String {
        return response
    }
    
    var sources: [Source]? {
        return source?.isEmpty == false ? source : nil
    }
}

struct Source: Codable, Identifiable {
    let id = UUID()
    let fileId: String
    let fileName: String
    let page: Int
    let index: Int = 1 // Default value
    
    enum CodingKeys: String, CodingKey {
        case fileId = "file_id"
        case fileName = "file_name"
        case page
    }
}


/// File type for document display
enum FileType {
    case pdf
    case word
    case excel
    case powerpoint
    case text
    case image
    case audio
    case video
    case other
} 