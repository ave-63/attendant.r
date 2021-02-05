## Overview

This is a small R program that compiles attendance reports from several Zoom meetings into one.

The basic usage is that for each class meeting, you download a csv report file from Zoom, save it in a folder with all the other csv files you download, naming it something like `935_att_2-8.csv`, where `935` is an identifier you choose for each class (in this case indicating a 9:35 class), `_att_` tells the program this is an attendance file, and `2-8` means February 8.

Then, you run the program, and it creates a file called `attendance_935.csv`, which has one row for each student, and now has a column labeled "Mo_2-8", with the total number of minutes each student was in the meeting.

You can do this for multiple classes and multiple dates, and each class will get it's own output file, eg `attendance_1110.csv` and `attendance_1245.csv`, each with one column for each meeting report you downloaded, in date order.

## Installation

1. Install R on your computer. Go to [https://cran.r-project.org/mirrors.html](https://cran.r-project.org/mirrors.html), choose a nearby mirror, choose `base`, and follow the instructions.

2. Download the following list of files, either using github (tricky), or [from my dropbox](https://www.dropbox.com/sh/jl7t98jy3c28cnn/AABPrtCmk8ZkhCvtKsfBzr8Ga?dl=0):

- `do_attendance_win.bat` (MS Windows) or `do_attendance_mac.sh` (Macintosh) -- This is a tiny executable script that you double-click on, and it runs `R` with the code in `ck_grader.r`. You can put it anywhere handy, like on your desktop, home directory, or wherever you keep your Statistics materials. 
- `attendant.r` -- This is the main file. Put it in the same folder as `do_attendance_win.bat` or `do_attendance_mac.sh`. Do not just use the version shared with others in dropbox, because you'll need to customize some things for your computer (step 3 below).
- `README.md` -- The instructions you're reading right now.

3. There are some options you **must** customize. Open `attendant.r` in any text editor, such as MS Notepad. Near the top, under `## USER OPTIONS`, change the values of:

- `INPUT_DIRECTORY` -- This is the path to where you put all csv reports you download from Canvas/Zoom. It can be your Downloads folder for convenience, if you don't mind it filling up with lots of files. The examples commented out with `##` show how the format should look on Windows/Mac.
- `OUTPUT_DIRECTORY` -- This is where the program will put the result files, eg `attendance_935.csv`. It can be the same as `INPUT_DIRECTORY`, or the place you keep your class grades, or whatever.
- `YEAR` -- Should be in quotes, as in `"2021"`. This is needed so that the program can figure out, for example, that 2-8 is a Monday.

## Usage Instructions

Start by downloading some csv reports from Canvas/Zoom. Click **Zoom** on the left, then the **Previous Meetings** button, and then **Report**:

![screenshot of Zoom within Canvas]
(https://i.imgur.com/65ZLq5y.png)

Then click **Export as CSV File**:

![screenshot of zoom report]
(https://i.imgur.com/Zn1el8Y.png)

Then, name the file `220_att_12-9.csv`. Instead of `220` you can use your own way of identifying this class, such as `MW`, `227`, or `MW227`, but this "class ID" should be the same for all reports you download for this class. The `_att_` is important and tells the program this is a report to input. The `12-9` means December 9, and you could also write it as `12-09`.

Here are some example report CSV names that will **not** work:

- `220 att 12-9.csv` -- Use `_`, not spaces.
- `220_att_12/9.csv` -- Use `-`, not `/`.
- `2:20_att_12-9.csv` -- Don't use special characters like `:` in the class ID.
- `MW 227_att_12-9.csv` -- Don't use spaces.

Then, when you have some of these csv reports in your `INPUT_DIRECTORY`, double-click the file `do_attendance_win.bat` or `do_attendance_mac.sh` to run the program. The first time you run it, it will need to install some R packages which will take some time, but after that it should finish in a few seconds.

*Voilà!* There is now a file, `attendance_220.csv`, in your `OUTPUT_DIRECTORY` that looks something like this:

![screenshot of output csv]
(https://i.imgur.com/reMBcyO.png)

Note: when students sign in with slightly different names, such as "Georg Cantor," "Georg," or "Cantor, Georg," it makes a row for each of them, which can be confusing. If you want, you can ask students to only use one account in the future, copy numbers from one row into the other, and delete the extra row. These edits will stick as long as they don't sign in with the name you deleted.

One more note: You probably shouldn't edit the output csv in any way other than what I described in the previous note. Weird things will happen.

## When things go wrong

If you get an error, or some unexpected results, first double-check that your files are named correctly (File Name Rules, above). Also make sure you correctly set `INPUT_DIRECTORY` and `OUTPUT_DIRECTORY` in `attendant.r`.

If file names weren't the problem, don't hesitate to reach out to me. It may be a bug in the program, or that your csv files are formatted in an unexpected way, or something unexpected about your computer, and either way, I want to fix it ASAP.