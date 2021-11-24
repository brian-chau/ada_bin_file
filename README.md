# Ada Binary file handling

This is part of my series of weekend projects, centering around mass data processing.

This week's project was using Ada to processing a large binary file that was converted from an even larger CSV file into a binary file using a GNU C++ application.

With this Ada application, using GNAT Studio on Windows 11, I was able to count the number of records that matched one of two combinations in just over 1 second.

It's considerably slower than extracting the data using GNU C++, but it's still faster than parsing the original CSV file even with a language like Go, which took ~3 seconds to parse.