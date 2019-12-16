# Introduction

This software is designed to convert a journal file into something that can be imported into [Day One][day_one]. The original file format is just markdown, but Day One needs to have it with the date at the top of the file name with a tab character before that date. The original files are named with the date themselves.

For example, the journal entry for July 1st of 2017 would have a file name of `2017.07.01.md.txt`. Within the file there would be a header that looks like `# 2017 July 01` Using these bits of information we can construct a file which can be imported by Day One.

[day_one]: http://dayoneapp.com/

# Requirements

# How to Run this

1. Install the dependencies:
   1. Elixir
   2. mix
   3. Run `mix deps.get` from the command-line
2. Copy the `.env.sample` to `.env` and update the JOURNAL_DIRECTORY variable to the directory with your markdown files in it
3. From a command line type: `make`
