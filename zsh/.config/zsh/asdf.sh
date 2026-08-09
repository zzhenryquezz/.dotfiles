# configure asdf 

if [ -d "$HOME/.asdf" ]; then
    export ASDF_DATA_DIR="$HOME/.asdf"
    export PATH="$ASDF_DATA_DIR/shims:$PATH"
fi
