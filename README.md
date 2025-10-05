# PostSearchMVVM
iOS MVVM Demo App - Fetches posts from JSONPlaceholder API using Swift, SwiftUI, and async/await.

## iOS & Xcode Version
- iOS 15.5+
- Xcode 13.4+
- 
## Architecture
- **MVVM (Model-View-ViewModel):
- **Model:** Data structures (e.g., Post)
- **View:** SwiftUI views
- **ViewModel:** Handles fetching and transforming data
- **Service Layer:** Handles network calls and API endpoints

  ## Assumptions & Improvements
- Currently using JSONPlaceholder API for demo posts.
- With more time:
- Add environment-based URLs (dev, staging, production)
- Add caching & offline support
- Implement unit tests for ViewModel and Service
