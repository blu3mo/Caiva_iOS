# Caiva - A Flashcard App

Caiva is an app to memorize things for school's tests & exams by linking a memory with an audio and picture.

### Concept

When we use a paper flash card or an existing apps to memorize things (ex: Quizlet), we have to "work hard" to memorize them.

In Caiva, user can memorize things just by listening to a audio of words user have to memorize on their free time (ex: on transportaion, before sleep). User can take quick tests before the session, and the app will optimize the audio.

### Audience

Student (around 14~ 18) wants to use it for school's quizs and exams when they need to memorize.

People who want to take a easier method to memorise things can use this app.

### Experience

A user opens the app when they have a time to work on session (ex: when they ride bus/car). The quick session of testing memory will start, then the user can start listening on session.

User can select 2 types of the session based on their situations to work on them.

A: If the user can view smartphone screen: The app will show a picture related to the word with an audio. By this function, user can link the memory with an image, and we can memorize more easier.

B: If the user can't view screen, the app will just play the audio.

There will be difference of voice for each cards in flashcards, so the user can link the voice type with card's content.



## Technical

### Models

- Cardset - Array of Cards
- Card - Question, Answer, Degree of memory

### Views

- HomeView - List of Cardsets
- CardsetInfoView - View where user can select to start an audio session, or edit cards
- CardsetEditView - View where user can edit each cards
- SettingView - View where user can edit settings
- SessionView - View where user see when they work on sessions

### Controllers

- ViewController for each Views

### Other

- AudioService

- OptimizationService

- RealmHelper

- ImageHelper



## Weekly Milestone

### Week 4 - Usable Build

[List of tasks needed to be complete before you can start user testing]

- Paper prototype

- Make each views in Affinity Designer - Until Tuesday 12:00
- Create views in storyboard - Until Wednesday
- Create function to create & save cardsets - Until Friday
- Start working on function to do session if possible

### Week 5 - Finish Features

[List of tasks to complete the implementation of features]

- Finish function of audio session - Until Wednesday 12:00
- Finish function of optimizing audio - Until Thursday
- Anything not done

### Week 6 - Polish

[List of tasks needed to polish and ship to the app store]

- Anything not done

- Polish UI
- Fix bugs

### After MVP

- Optimization by deep learning
- Text Recognization to create cardsets
