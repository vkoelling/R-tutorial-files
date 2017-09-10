###Tips for a Happy R Life
-------------
####R Shortcuts

option + return = run the line of code

option + _ = <- = assignment

####Recommended Analysis Workflow
1. On your computer, create a folder for your project.
2. Enter your data into a spreadsheet (e.g., Excel), with observations in rows and variables in columns. Save it to your new folder.
3. Print a hard copy of the spreadsheet and check it against the original data sheets. Correct any erros in the spreadsheet.
4. Save the spreadsheet in comma-separated values (.csv) format.
5. Protect the spreadsheet and .csv file by making them read-only files.
6. Start up RStudio, open a new script file, and save it to the folder you created in step 1. Write your instructions for R in this script file, and save it regularly. Keep these files really safe!
7. **Always put comments in your script. Comment everything!**
8. Always wipe RStudio's brain of all previous data—rm(list=ls())—and get your libraries sorted.
9. Import your data into R. Check that the numbers of rows and variables are correct. Check that variable types are correct. Check that the number of levels of categorical variables is correct. Check that the range and distribution of numeric variables are sensible. Check for any missing values and make sure you know where they are. Check how many data points per treatment combination. **Check everything!**
10. Make a picture(s) that reflects your questions and that will help you specify your model to answer your question. Explore your data using the plotting functions. Use packages **dplyr** and **ggplot2**.
11. Specify a statistical model to capture the hypothesis you are testing. Guess the answer that your statistical tests should give you. Make some other graphs to further investigate your guesses.
12. Assess whether assumptions are important to the type of modelling you have decided to implement (use **autoplot()**).
13. Interpret the model with **anova()** and **summary()**.
14. Add fitted lines and CIs, when appropriate, to the plot; make the figure that is worth 1,000 words.
15. Keep your data file and script file very safe (and backed up in a separate location). With these, you can recreate all your graphs and analyses with a few keystrokes in a few minutes at most. Organize the files in your folder so that you can come back to it in six months' time and know exactly what you did.


This workflow is adapted from:

	Beckerman, A. P., Childs, D. Z., and Petchey, O. L. 2017. Getting Started with R: An Introduction for Biologists. 2nd edition. Oxford University Press, New York, NY.