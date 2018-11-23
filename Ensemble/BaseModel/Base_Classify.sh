#improve model accuracy:
#changing the number of epochs (using the option -epoch, standard range [5 - 50])
#changing the learning rate (using the option -lr, standard range [0.1 - 1.0])
#using word n-grams (using the option -wordNgrams, standard range [1 - 5])

#improve scaling on larger datasets:
#use hierarchical softmax (-loss hs)
#reducing the dimensions (-dim 100) 
#reducing number of buckets (-bucket 2000000)

echo "Making Model..."
#../FastText.exe supervised -input data/base_rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 3 -bucket 2000000 -dim 100 -loss hs -thread 7
#../FastText.exe supervised -input data/base_rdc.train -output data/model_rdc -lr 1.0 -epoch 10 -wordNgrams 3 -dim 120 -loss hs -thread 7

#time ../FastText.exe supervised -input data/base_rdc.train -output data/model_rdc -lr 1.0 -epoch 20 -wordNgrams 3 -bucket 2000000 -dim 100 -loss softmax -thread 7
../FastText.exe supervised -input data/base_rdc.train -output data/model_rdc -lr 1.0 -epoch 10 -wordNgrams 3 -dim 120 -loss softmax -thread 7


#returns top 50 labels for each line from highest to lowest probability left to right (can show probabilities by changing "predict" to "predict-prob")
echo "Finding best labels..."
tail -n 80000 ../rdc-catalog-train.tsv > data/actual.tsv
awk -F '\t' '{print $1}' data/actual.tsv > data/tempTitles
#find top 50 labels; if none of the top labels are full paths then the python script will not work as all labels will be removed 
#(i.e. increase this if python complains)
../FastText.exe predict-prob data/model_rdc.bin data/base_rdc.test 50 > data/tempLabels1

#remove trailing spaces & take highest probability labels (left most label, this step also removes the probability)
#then remove the '~' symbols, then remove the "__label__" text used by fastText
cut -d' ' -f 1,2 data/tempLabels1 | tr -d '~' | tr -d '__label__' > data/base_predicted.tsv #tempLabels2

#echo "Merging titles with labels..."
#paste data/tempTitles data/tempLabels2 | awk -F '\t' '{print $1"\t"$2}' > data/base_predicted.tsv

echo "Removing temporary files..."
rm data/tempLabels1
#rm data/tempLabels2
rm data/tempTitles

echo "Done!"