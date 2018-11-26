#!/bin/bash -l
#PBS -N HPC_Combo
#PBS -l select=1:ncpus=36:mem=16gb
#PBS -l walltime=72:00:00

#remove results of previous run
rm -fr data/results.txt

for i in 00 01 02 03 04 05 06 07 08 09
do
echo "Making Model..."
#make each model
./fastText/fasttext supervised -input data/rdcTrain$i -output data/model_rdc$i -lr 1.0 -epoch 10 -wordNgrams 3 -dim 200 -loss softmax -thread 36

#extract titles from original dataset
awk -F '\t' '{print $1}' data/rdcActual$i > data/tempTitles$i

echo "Predicting Labels..."
#predict labels with probabilities
./fastText/fasttext predict data/model_rdc$i.bin data/rdcTest$i > data/tempLabels1$i

echo "Removing Label Tags..."
#take the best label and trim away the __label__ identfiers
cat data/tempLabels1$i | tr -d '__label__' > data/tempLabels2$i

echo "Joining Labels with Titles..."
paste data/tempTitles$i data/tempLabels2$i | awk -F '\t' '{print $1"\t"$2}' > data/rdcPredicted$i

echo "Removing Files..."
#remove used files
rm data/tempTitles$i
rm data/tempLabels1$i
rm data/tempLabels2$i
rm data/rdcTrain$i
rm data/rdcTest$i

echo "Evaluating Model..."
echo $i >> data/results.txt
./eval.py -pred data/rdcPredicted$i -gold data/rdcActual$i >> data/results.txt

done
echo "Done!"
