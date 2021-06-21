import Foundation

enum MultiSigner: Equatable {
    static let ed25519Field = "Ed25519"
    static let sr25519Field = "Sr25519"
    static let ecdsaField = "Ecdsa"

    case ed25519(_ data: Data)
    case sr25519(_ data: Data)
    case ecdsa(_ data: Data)
}

extension MultiSigner: Codable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let type = try container.decode(String.self)

        switch type {
        case Self.ed25519Field:
            let data = try container.decode(Data.self)
            self = .ed25519(data)
        case Self.sr25519Field:
            let data = try container.decode(Data.self)
            self = .sr25519(data)
        case Self.ecdsaField:
            let data = try container.decode(Data.self)
            self = .ecdsa(data)
        default:
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Unexpected type")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()

        switch self {
        case .ed25519(let value):
            try container.encode(Self.ed25519Field)
            try container.encode(value)
        case .sr25519(let value):
            try container.encode(Self.sr25519Field)
            try container.encode(value)
        case .ecdsa(let value):
            try container.encode(Self.ecdsaField)
            try container.encode(value)
        }
    }
}
