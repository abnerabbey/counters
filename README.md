# Cornershop iOS Development Test

Congratulations 🥳 

You passed the technical interview and are now at the next step of our technical assessment. To get a better sense of your capabilities and skills we ask all our potential future teammates to build a simple app. 

### Before you begin

Please read this whole README file.

You will need to create a private GitHub repository using the information that we provided in this README. When you finish your test, share the project with [@Cornershop-HR](https://github.com/Cornershop-HR) and let your recruiter know.

If you have any questions (UI design, deadlines, etc), please reach out to the recruiter and we will be in touch to respond to any doubts. 

If you need additional time to properly finish the test, please don't hesitate to ask for more. There's no penalty in asking for more time; there's penalty for not delivering quality software. We're looking forward to reviewing your best code, not a rushed implementation. Seriously just ask!

## The Test
Here is a base project for an iOS app that allows us to count things. The project contains some components that are there to help you build quickly 🚀

To pass this test, the finished app should have at least the following features:
* Add a named counter to a list of counters.
* Increment any of the counters.
* Decrement any of the counters.
* Delete a counter.   
* Handle batch deletion.
   * You will note below that there is no batch delete handling in the API. While in the app the user can select several counters to delete at once, the operations will have to be processed in multiple requests.
* Show the number of counters and the sum of their values.
* Search counters.
* Persist data *locally* and back to the server.
   * The app should be able to show the last persisted counter list if the network is not available (i.e Airplane Mode).
   * You will notice that the Figma doesn't demonstrate an example for when the app is offline but we have counters. We would like to see your approach in showing the locally persisted counters while letting the user know that the app is offline.

We look at your deliverable in a _holistic_ way: delivering 60% of these features doesn't translate to a B or C grade: it's an F.

### User Interface
Build the app using **[this Figma spec](https://www.figma.com/file/imS6MbQeEdN68J4fXlRmNQ/Counters-for-iOS-2021).**

### What we expect
* **States are crucial**. You must handle each state transition properly.
* Unreliable networks are a common thing that we deal with at Cornershop. This app should handle disconnections gracefully. Error handling and data syncing between the local and server databases is important.
* The user experience should be something you are proud of. As an iOS developer at Cornershop we go beyond the code to make sure we achieve the highest ratings in the App Store. We expect the same from our future teammates. 
* Don't build anything that doesn't feel right for iOS (**no** Material Design, for example).
* As a member of the Cornershop iOS team, we expect your code to be approachable for collaboration. Applying the best coding and project organization practices is an important part of being a team player. 
* While we do not have a required architecture for this project, we do expect that for whichever architecture you use, that you apply the best practices for separating responsibility.
* If you're using a dependency manager (like `CocoaPods` or `Carthage`) or the project requires additional configurations before compiling the app, **please** add a proper `README`. You can also point out any cool features you added in this `README` file.
* You can use the latest Swift version and the latest beta of Xcode.
* `SwiftUI` is not welcomed yet, please avoid using it.
* Showing off the capabilities of `UIKit` and `Core` frameworks is **essential**.
* Finally, while we don't expect perfection, we do expect that there are no major bugs. If we do find a few minor bugs, we may request improvements or an explanation of their existence. Just like a PR review here at Cornershop!

### Bonus Points (not mandatory, but nice)

If you have a particular skill from this list you might want to show off we would really appreciate it. But if you feel confident with the main requirements we definitely suggest not to dedicate too much time to these. Some of us made the mistake of trying to do all the bonuses 😅

* Don't use any external dependencies.
* Don't use libraries such as `ReactiveCocoa`, `RxSwift` or `Combine` (really, any reactive programming library in general). Keep in mind we don't use these at Cornershop and do not plan on doing so in the near future. 
* Lightweight view controllers (view-code would be awesome 🚀).
* Showing off some `Core Animation` knowledge.
* `XCTest`s are good.
* Think that this project could be developed alongside multiple developers. `GitFlow` usage would be useful.
* This app could also be used on landscape and/or iPad devices (i.e 2/3 Split View).
* Multi-language support; maybe even RTL text?
* Accessibility support.
* Show off `UIKit` APIs supported in iOS 13 and above.
* Other cool stuff! We like to be surprised 🙂

## Blueprints

We gave you a starting project, with a few things that might help you get started. Feel free to use and modify them as you like.

The starting project contains:

- **Welcome Screen**: This is the initial implementation for the welcome screen.
- **Networking**: Be careful, it's built in Objective-C 👻, what you gonna do?
- **Color Assets**: The main colors of the app are already there.
- **Button**: The primary button used across the application.

## The Server

Setting up the server is easy! You will need to download and install [NodeJS](https://nodejs.org/en/download/) if you do not already have it. To run the mock server (included in this repo at `Server/`) execute the following commands in Terminal while in `Server/`:

```
$ npm install
$ npm start
```

To shutdown the server usually `CTRL + C` works. Keep in mind that when you restart the server, it will start from scratch with zero counters. 

## API Endpoints and Examples

Here are the endpoints with examples of the corresponding bodies which should be `Content-Type: application/json`. The examples show what the responses would be if the requests are done in sequence:

- `GET` `/api/v1/counters`

   Response Body:
   ```
   [
   ]
   ```

- `POST` `/api/v1/counter`

   Request Body:
   ```
   {
      "title": "Coffee"
   }
   ```
   Response Body:
   ```
   [
      {
         "id": "foo",
         "title": "Coffee",
         "count": 0
      }
   ]
   ```

- `POST` `/api/v1/counter`

   Request Body:
   ```
   {
      "title": "Tea"
   }
   ```
   Response Body:
   ```
   [
     { 
        "id": "asdf",
        "title": "Coffee",
        "count": 0
     },
     {
        "id": "qwer",
        "title": "Tea",
        "count": 0
     }
   ]
   ```

- `POST` `/api/v1/counter/inc`

   Request Body:
   ```
   {
      "id": "asdf"
   }
   ```

   Response Body:
   ```
   [
      {
         "id": "asdf",
         "title": "Coffee",
         "count": 1
      },
      {
         "id": "qwer",
         "title": "Tea",
         "count": 0
      }
   ]
   ```

- `POST` `/api/v1/counter/dec`

   Request Body:
   ```
   {
      "id": "qwer"
   }
   ```
   Response Body:
   ```
   [
      {
         "id": "asdf",
         "title": "Coffee",
         "count": 1
      },
      {
         "id": "qwer",
         "title": "Tea",
         "count": -1
      }
   ]
   ```

- `DELETE` `/api/v1/counter`

   Request Body:
   ```
   {
      "id": "qwer"
   }
   ```
   Response Body:
   ```
   [
      {
        "id": "asdf",
        "title": "Coffee",
        "count": 1
      }
   ]
   ```

- `GET` `/api/v1/counters`

   Response Body:
   ```
   [
      {
         "id": "asdf",
         "title": "Coffee",
         "count": 1
      }
   ]
   ```

---

_"You can focus on things that are barriers or you can focus on scaling the wall or redefining the problem." -Tim Cook_
