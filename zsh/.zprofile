eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH=$HOME/go/bin:$PATH

# Setting PATH for Python 3.13
# The original version is saved in .zprofile.pysave
PATH="$HOME/.local/bin:/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH
