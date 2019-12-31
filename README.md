Project-Euler
=============

iPhone/iPad app that shows the questions and solutions to the Project Euler questions. All files are well commented, and thoroughly explained.

The iPhone version of the app is a simple push navigation application. The app is iOS 8.0 or later in order to take advantage of Auto Layout in the UIStoryBoard.

The iPad version of the app is a simple UISplitView. The code is mostly reused from the iPhone app, with slight changes based on the device.

The Questions are all solved in their own individual .h and .m files. They all are a subclass of a QuestionAndAnswer object which holds the default variables and methods that each Question conform to.

The computation is all done on a separate thread so that the main thread does not lock if the computation takes too long. This allows for the user to still interact with the app even if the computation is still running (Note: the answers are all precomputed and stored in the initialize method of the Question object).

Each question has 2 different solutions. The first is the brute force way, which is usually slow. The second (and more interesting method) is an optimized solution, which runs much faster!

While all the question data can be found in each of the Question .m files, as well as in the DetailViewController when the app is built in the simulator or on a device, the full information can be found on the Project Euler website: http://projecteuler.net.