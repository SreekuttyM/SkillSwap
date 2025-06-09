import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    try app.register(collection: AuthServiceController())
    try app.register(collection: UserProfileController())

    for route in app.routes.all {
        print("[ROUTE] \(route.description)")
    }
}
