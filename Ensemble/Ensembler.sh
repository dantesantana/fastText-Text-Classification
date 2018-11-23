rm -fr data

mkdir data

#each model needs to be run from their own directory
#as they use relative locations to keep track of folders for data etc...
cd BaseModel/

echo "Running model 1..."
./Base_Clean.sh
./Base_Classify.sh

cd ..
cd ZerosModel/

echo "Running model 2..."
./Zeros_Clean.sh
./Zeros_Classify.sh

cd ..

echo "Producing ensemble model..."
#Version 1: 25 epochs with 100 dimensions
#Hierarchical Softmax
#P=0.7859, R=0.7914, F1=0.7835 ~5.5 minutes (didn't time it)
#Softmax
#P=0.8168, R=0.8178, F1=0.8130 ~193m12.782s (3.216 hours)

#Version 2: 10 epochs with 120 dimensions
#Hierarchical Softmax
#P=0.7882, R=0.7926, F1=0.7849
#Softmax
#P=0.8191, R=0.8175, F1=0.8139
#Ensemble.exe: first parameter is the output file followed by however many input files you would like to compare
./Ensemble.exe data/tempLabels ./BaseModel/data/base_predicted.tsv ./ZerosModel/data/zeros_predicted.tsv

tail -n 80000 rdc-catalog-train.tsv > data/ensemble_actual.tsv
awk -F '\t' '{print $1}' data/ensemble_actual.tsv > data/tempTitles
paste data/tempTitles data/tempLabels | awk -F '\t' '{print $1"\t"$2}' > data/ensemble_predicted.tsv

echo "Removing temporary files..."
rm data/tempTitles
#rm data/tempLabels

echo "Testing ensemble model..."
./eval.py -pred data/ensemble_predicted.tsv -gold data/ensemble_actual.tsv