Movie App

Summary

Movie App is a Swift-based iOS application designed to provide users with a comprehensive movie browsing experience.
Users can explore movies by category, search for specific titles, view detailed information about each movie, and watch trailers.
The app offers an interactive interface with features like smooth pagination, local caching data, and the ability to share movie details with other apps.

Features

1. Browse Suggested Movies
   The app presents users with 5 suggested movies for quick browsing.
   
2. Browse Movies by Type
   Users can browse movies by the following categories:
   Top Rated
   Popular
   Trending
   Now Playing
   Upcoming
   Smooth pagination is implemented to enhance the scrolling experience through movies in each category.

3. Search for Movies
   Users can search for specific movies by entering text in the search bar.

4. Movie Details
   Clicking on a movie takes the user to the Movie Detail screen. Detailed information includes:

5. Overview description
   Rating
   Language
   Release date
   Thumbnail image

6. Share Movie Details
   Users can share movie details with various apps on their phone, such as WhatsApp, email, social media, and more.

7. Watch Trailers
   Users can watch movie trailers by clicking the "Show Trailer" button. The trailer opens in a sheet that can be moved up for full-screen view or dismissed down for smooth interaction.

8. Local Data Caching
   The app saves and caches data locally from URL requests for 1 day. This ensures that users can access movie data offline if they have accessed it within the last 24 hours.

9. MVVM Architecture
   The app is designed with the Model-View-ViewModel (MVVM) architecture. It uses async/await network calls for efficient data binding.

10. Device Support
    The app supports iPhone devices, ensuring a versatile user experience across different screen sizes.



Technical Details

Language: Swift
Framework: SwiftUI
Architecture: MVVM
Data Storage: Cache Data from URL
Networking: async/await for asynchronous network calls
