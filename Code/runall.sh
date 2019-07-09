#!/bin/sh

Final_deadline=(20 25 30 35 40)
variance=(1 2 3 4 5)
#variance=(5 6 7 8 9)
num_episodes=100

plot_deadline=20,25,30,35,40
plot_variance=1,2,3,4,5

export num_episodes
export Final_deadline
export variance
export plot_deadline
export plot_variance

rm -rf Results/*

. Scripts/NoVariance.sh
. Scripts/Dynamic.sh
. Scripts/Uniform-WC.sh
. Scripts/Var-Normal.sh
. Scripts/Var-Uniform.sh

mkdir pdfs
pdflatex -output-directory pdfs Plots/NoVariance.tex
pdflatex -output-directory pdfs Plots/Dynamic.tex
pdflatex -output-directory pdfs Plots/Uniform-WC.tex
pdflatex -output-directory pdfs Plots/Var-Normal.tex
pdflatex -output-directory pdfs Plots/Var-Uniform.tex

python3 Scripts/Process-res.py
pdflatex -output-directory pdfs Plots/Var-Normal-paths.tex
pdflatex -output-directory pdfs Plots/Var-Uniform-paths.tex

## Clean up
rm -r pdfs/*.aux
rm -r pdfs/*.log
