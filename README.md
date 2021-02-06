## Overview

This is a small R program that compiles attendance reports from several Zoom meetings into one.

The basic usage is that for each class meeting, you download a csv report file from Zoom, save it in a folder with all the other csv files you download, naming it something like `935_att_2-8.csv`, where `935` is an identifier you choose for each class (in this case indicating a 9:35 class), `_att_` tells the program this is an attendance file, and `2-8` means February 8.

Then, you run the program, and it creates a file called `attendance_935.csv`, which has one row for each student, and now has a column labeled "Mo_2-8", with the total number of minutes each student was in the meeting.

You can do this for multiple classes and multiple dates, and each class will get it's own output file, eg `attendance_1110.csv` and `attendance_1245.csv`, each with one column for each meeting report you downloaded, in date order.

## Installation (MS Windows)

1. Install R on your computer. Go to [https://cran.r-project.org/mirrors.html](https://cran.r-project.org/mirrors.html), choose a nearby mirror, choose `base`, and follow the instructions.

2. Download the following list of files, either using github (tricky), or [from my dropbox](https://www.dropbox.com/sh/51v1t5fhvgk0h8u/AABWwMBwk_S7Zg9RBO9OoPzga?dl=0). If you get them from my dropbox, make sure to make your own copy on your own computer somewhere, and don't edit the one in my dropbox:
    - `do_attendance_win.bat` -- This is a tiny executable script that you double-click on, and it runs `R` with the code in `attendant.r`. You can put it anywhere handy, like on your desktop or home directory.
    - `attendant.r` -- This is the main file. Put it in the same folder as `do_attendance_win.bat`. 
    - `README.md` -- The instructions you're reading right now.

3. There are two options you **must** customize. Open `do_attendance_win.bat` in any text editor, such as MS Notepad, and change the following:
    - `INPUT_DIRECTORY` -- This is the path to where you put all csv's you download from CourseKata. It can be your Downloads folder for convenience, if you don't mind it filling up with lots of csv's. 
	- `OUTPUT_DIRECTORY` -- This is where `attendant` will put the result files, eg `attendance_935.csv`. It can be the same as `INPUT_DIRECTORY`, or the place you keep your class grades, or whatever.
    - `YEAR` --  This is needed so that the program can figure out, for example, that 2-8 is a Monday.

4. After you have some attendance report csv files downloaded in `INPUT_DIRECTORY`, go ahead and double-click `do_attendance_win.bat` to run the program. It should open a command prompt with some information and warning/error messages. The first time you run it, it will take a few minutes to install some R packages, but after they're installed it should only take a few seconds. However, you may get an error installing the packages, saying you don't have permission to write to `C:\Program Files\R-4.0.3\...`. If this happens to you, here are two ways to get around it:
   - Option A: Hold down Ctrl while right-clicking `do_attendance_win.bat`. One of the options should be "Run as administrator." Click it, enter your password, and R will install the packages in the `C:\Program Files\R-4.0.3\...` folder. After doing this once, you'll be able to double click `do_attendance_win.bat` in the future.
   - Option B: Follow these steps to create a personal library in your `C:\User\...` folder and install packages there:
      - Open a command prompt, by pressing the start button and typing `cmd` [Enter].
	  - Type `R` [Enter] to start a session where you can type R commands interactively.
	  - In the R session, type `install.packages("stringi")` [Enter]. You will get the same error message as before, but this time, it will ask if you would like to use a personal library instead? Type `yes` to the rest of the questions. This will download and install some R packages. 
	  - Repeat the previous step but
	  with `install.packages("dplyr")`. After doing this once, you'll be able to double click `do_attendance_win.bat` in the future.

## Installation (Apple Macintosh)

1. Install R on your computer. Go to [https://cran.r-project.org/mirrors.html](https://cran.r-project.org/mirrors.html), choose a nearby mirror, choose `base`, and follow the instructions.

2. Download the following list of files, either using github (tricky), or [from my dropbox](https://www.dropbox.com/sh/jl7t98jy3c28cnn/AABPrtCmk8ZkhCvtKsfBzr8Ga?dl=0). If you get them from my dropbox, make sure to make your own copy on your own computer somewhere, and don't edit the one in my dropbox:
    - `do_attendance_mac.command` -- This is a tiny executable script that you double-click on, and it runs `R` with the code in `attendant.r`. You can put it anywhere handy, like on your desktop, home directory, or wherever you keep your Statistics materials.
	- `attendant.r` -- This is the main file. Put it in the same folder as `do_attendance_mac.command`.
	- `README.md` -- The instructions you're reading right now.

3. There are two options you **must** customize. Open `do_attendance_mac.command` in any text editor, such as TextEdit, and change the following:
    - `INPUT_DIRECTORY` -- This is the path to where you put all csv reports you download from Canvas/Zoom. It can be your Downloads folder for convenience, if you don't mind it filling up with lots of files.
	- `OUTPUT_DIRECTORY` -- This is where the program will put the result files, eg `attendance_935.csv`. It can be the same as `INPUT_DIRECTORY`, or the place you keep your class grades, or whatever.
    - `YEAR` --  This is needed so that the program can figure out, for example, that 2-8 is a Monday.

4. Open a terminal window (under Applications -> Utilities). In the terminal, type the command: `chmod +x /Users/your-name/folder/where/you/put/do_attendance_mac.command` [Enter].

Now, after you have downloaded some assignment and page detail files in `INPUT_DIRECTORY`, you should be able to double-click `do_attendance_mac.command` to run the program. It should open a command prompt with some information and warning/error messages. The first time you run it, it will take a few minutes to install some R packages, but after they're installed it should only take a few seconds.

## Usage Instructions

Start by downloading some csv reports from Canvas/Zoom. Click **Zoom** on the left, then the **Previous Meetings** button, and then **Report**:

![screenshot of Zoom within Canvas](https://i.imgur.com/3nSTILc.png)

Then click **Export as CSV File**:

![screenshot of zoom report](https://i.imgur.com/IJZcHlO.png)

Then, name the file `220_att_12-9.csv`. Instead of `220` you can use your own way of identifying this class, such as `MW`, `227`, or `MW227`, but this "class ID" should be the same for all reports you download for this class. The `_att_` is important and tells the program this is a report to input. The `12-9` means December 9, and you could also write it as `12-09`.

Here are some example report CSV names that will **not** work:

- `220 att 12-9.csv` -- Use `_`, not spaces.
- `220_att_12/9.csv` -- Use `-`, not `/`.
- `2:20_att_12-9.csv` -- Don't use special characters like `:` in the class ID.
- `MW 227_att_12-9.csv` -- Don't use spaces.

Then, when you have some of these csv reports in your `INPUT_DIRECTORY`, double-click the file `do_attendance_win.bat` or `do_attendance_mac.command` to run the program. *Voilà!* There is now a file, `attendance_220.csv`, in your `OUTPUT_DIRECTORY` that looks something like this:

![screenshot of output csv](https://i.imgur.com/06LS4ib.png)

Note: when students sign in with slightly different names, such as "Georg Cantor," "Georg," or "Cantor, Georg," it makes a row for each of them, which can be confusing. If you want, you can ask students to only use one account in the future, copy numbers from one row into the other, and delete the extra row. These edits will stick as long as they don't sign in with the name you deleted.

One more note: You probably shouldn't edit the output csv in any way other than what I described in the previous note. Weird things will happen.

## When something goes wrong

If you get an error, or some unexpected results, first double-check that your files are named correctly. Also make sure you correctly set `INPUT_DIRECTORY` and `OUTPUT_DIRECTORY` in `do_attendance_win.bat` or `do_attendance_mac.command`.

If file names weren't the problem, don't hesitate to reach out to me. It may be a bug in the program, or that your csv files are formatted in an unexpected way, or something unexpected about your computer, and either way, I want to fix it ASAP.
