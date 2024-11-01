# Company Earnings Tracker

This mobile application provides an interactive view of estimated versus actual earnings data for companies. Users can input a company ticker to retrieve earnings data, view a dual line graph comparing estimated and actual earnings, and access earnings call transcripts by tapping data points on the graph.

## Features

1. **Company Ticker Input**: Users can enter a ticker symbol (e.g., MSFT for Microsoft) to fetch company earnings data.
2. **Earnings Data Visualization**: Displays a dual line graph showing estimated and actual earnings, helping users compare the values over time.
3. **Interactive Graph**: Users can tap on specific data points to retrieve and view the earnings call transcript for that quarter.
4. **Earnings Transcript**: Each selected quarter's earnings transcript is displayed on a new screen.

## Project Structure

- **State Management**: Built using the Bloc architecture, ensuring smooth and organized state handling.
- **Networking**: Integrated with [API Ninjas’ Earnings Calendar](https://api-ninjas.com/api/earningscalendar) and [Earnings Call Transcript APIs](https://api-ninjas.com/api/earningscalltranscript) for data retrieval.
- **Screens**: 
  - **InputScreen**: Allows user to input a ticker symbol.
  - **GraphScreen**: Displays the earnings comparison graph and enables node interaction.
  - **TranscriptScreen**: Shows the earnings call transcript when a graph node is tapped.

## Technologies

- **Flutter**: Cross-platform development framework for building the app.
- **Bloc**: For managing state across screens and ensuring scalable code structure.
## Demo Video
[Click here to view the demo video](lib/utilities/AyushKumar(qualification_task).mp4)
