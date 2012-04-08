# TV Renamer

This will take a folder and recursively go down through all directories finding all valid video files (avi, mov, mpg, wmv, mkv, ogm, etc...), match them against common syntaxes, and rename them according to your preference

Defining syntax might look something like this.

    Renamer.syntax = "%S - %0sx%0e - %T"
    Renamer.run # current directory by default
    
Where %S = Series name, %s is the season number, %0e is zero-padded episode number, and %T is title.

This would mean something like `my.name.is.earl.s03x01.HDTV.VTV.avi` would be renamed as: `My Name Is Earl - 3x01 - My Name Is Inmate, Part 1`

***

I was originally going to write this months ago using Hpricot to scrape epguides.com (for example: http://epguides.com/MyNameIsEarl/). However I found out about TVDB the other day and am very excited now!

***

I also found this morning [this script](http://github.com/dbr/tvdb_api/tree/master/tvnamer.py), so as an initial version this will probably just be a ruby port of that.