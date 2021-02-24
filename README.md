Objective-C categories for task 1 are in the Palindrome folder.

App finished with room for improvement since the dedicated time for the tasks is 2-4 hours.

What would I have done I had more time:

Integrate Cocoapods or SPM depending on preference of the team so I can add the usual helpers when building the app.
Build protocol based classes (business logic) so that mock implementations are possible 

Since you mentioned that you judge Code styles:
    - add swiftlint
    - R.swift for handling resources
    
General:
    - Make nicer UI
    - Business and domain logic separation with frameworks
    - Used RxSwift for reactive programming (really like it now with SwiftUI)
    
Network manager:
    - reuse the functionality of the network manager and image loader since they both use URLSession.shared.dataTask
    - written it using RxSwift

Image loading:
    - better caching mechanism (saving on the disk)
    - using SDWebImage for caching
