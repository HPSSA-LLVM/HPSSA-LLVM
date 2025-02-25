INPUTFILE=$1

mkdir -p dotfiles
mkdir -p pdfs

# Generate the .dot files using opt tool for a given .ll file
opt -passes=dot-cfg $1 -disable-output
mv .main.dot dotfiles/$1_full.dot

opt -passes=dot-cfg-only $1 -disable-output
mv .main.dot dotfiles/$1_cfg.dot

dot -Tpdf dotfiles/$1_full.dot -o pdfs/$1_full.pdf
dot -Tpdf dotfiles/$1_cfg.dot -o pdfs/$1_cfg.pdf
