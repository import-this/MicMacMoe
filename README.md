#  README

The following were implemented:
* A single screen that includes:
    - The TicTacToe board.
    - Difficulty selection. Three difficulty settings (Easy, Medium, Impossible).
    - Player selection.
    - Scoreboard (non-persistent).
* The suggested design was followed.

Implementation Details
* The MVC architectural pattern was used (per assignment description).
* The AI was implemented from scratch (i.e. no GameplayKit) using Minimax with Alpha-Beta pruning.
* The UI was implemented using the native UI components (UIKit with a ViewController containing a UICollectionView).

TODO (were not implemented for lack of time)
* Unit testing.
* A more aesthetically pleasing UI with better adaptation to different screen aspect ratios.
* Persistent storage for scores.
* Move the AI to a separate module.
