
<!-- HELLO Raven -->
<a id="readme-top">
<div align="center">
<h2>Raven mobile challanege - Jeremias Pellegrino</h3>
</div>
</a>

## About the project

This project aims to showcase the ability to create an iOS app that seamlessly connects with the New York Times' Most Popular Articles API, present the data correctly following mobile UI/UX standards, and assure the the app robustness.

### Design approach

- The UI/UX follows the guidelines adopted by the New York Times brand:
  - Consistent use of fonts and UI elements in line with NY Times branding that easily identifies the brand.
  - Structured flow and data presentation across various screens, including the home page, search, profile, and more.


- Architecture: I used SwiftUI with the MVVM pattern to ensure a clean separation of concerns and maximize view reusability.

- Support both **iPhone and iPad**

### Features


#### Home Tab to facilitate navigation
- Feed
	- Search view to easily find articles.
	- Filter with categories and periods combinations to adjust the feed preferences.
	- Article detail will display the full article of NYTimes embedded in a web view.
- Profile screen
	- Displays basic user data like name and image.
	- Displays bookmarked articles that always are available offline.


#### Articles Storage
- Cache the url request to prevent unnecesary network load, optimizing overall performance and UX.
- Persist
	- Feed configuration: helps to provide a consistent UX.
	- Articles images: faster load times and efficient memory usage.
	- Bookmarks: stored locally for offline access.

#### Network monitoring status
- Displays no connection banner if we have any offline data.
- Displays no connection fullscreen view if there isn't any offline data.

#### Errors handling

All the error cases are covered to ensure an reliable and robust app, including fields such as
- Network connectivity issues.
- API requests failures.
- Data loading and parsing erros.






