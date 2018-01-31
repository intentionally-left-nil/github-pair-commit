# Pair_with
Github has [added support](https://github.com/blog/2496-commit-together-with-co-authors) for pair programming via commit messages.

This repository makes it muuuch simpler to use this new functionality. Here's how you use it after installation:
1) Type `pair_with AnilRedshift` in the terminal (replace AnilRedshift with the person you're pairing with)
2) Work on your codebase with your pair (me in this case!)
3) Commit your code as normal.
4) Note that `Co-authored-by Anil Kulkarni <anilredshift@users.noreply.github.com>` Has been added to your git commit message!
5) Rejoice!


## Installation
1) Clone this repository `git clone https://github.com/AnilRedshift/github-pair-commit.git`
1) Open your terminal and cd into `github-pair-commit`
1) run `./setup.sh`
1) Open a new terminal (or source your environment)


## Usage
The commit script works by setting `$GIT_PAIR_NAME` and `GIT_PAIR_EMAIL` as environment variables.
  
You can automatically set these by typing `pair_with {github user name}`
When you're done pairing, simply type `work_solo`
