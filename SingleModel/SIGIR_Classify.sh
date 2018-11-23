#parameters which can be reduced to improve scaling with larger datasets
#-dim	size of word vectors [100]
#-epoch	number of epochs [5]
#-loss	loss function {ns, hs, softmax} [ns]

echo "Making Model..."
#make a new model using the preprocessed data
#0.735@1 0.226@5 0.168@10
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 2 -bucket 200000 -dim 50 -loss hs
#0.768@1 0.236@5 0.169@10																						*
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 2 -bucket 1000000 -dim 50 -loss hs
#0.774@1 0.238@5 0.170@10																						*
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 2 -bucket 2000000 -dim 50 -loss hs
#0.777@1 0.223@5 0.148@10																			*
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 3 -bucket 2000000 -dim 50 -loss hs
#0.780@1 0.226@5 0.150@10																									*
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 3 -bucket 2000000 -dim 100 -loss hs
#0.778@1 0.225@5 0.149@10 ~2m 25s														*
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 20 -wordNgrams 3 -bucket 2000000 -dim 100 -loss hs -thread 7

#P=0.7741, R=0.7782, F1=0.7719 ~2m43s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 20 -wordNgrams 3 -dim 100 -loss hs -thread 7
#P=0.7729, R=0.7775, F1=0.7709 ~3m13s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 3 -dim 100 -loss hs -thread 7
#P=0.7732, R=0.7785, F1=0.7716 ~4m24s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 40 -wordNgrams 3 -dim 100 -loss hs -thread 7
#P=0.7688, R=0.7771, F1=0.7686 ~8m58s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 100 -wordNgrams 3 -dim 100 -loss hs -thread 7
#P=0.7694, R=0.7777, F1=0.7691 ~11m44s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 100 -wordNgrams 3 -dim 150 -loss hs -thread 7

#P=0.7755, R=0.7782, F1=0.7724 ~2m20s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 10 -wordNgrams 3 -dim 100 -loss hs -thread 7
#P=0.7760, R=0.7798, F1=0.7734 ~2m37s
#P=0.7757, R=0.7786, F1=0.7726 ~2m21s
#P=0.7752, R=0.7789, F1=0.7728 ~2m53s
#P=0.7740, R=0.7773, F1=0.7712 ~2m34s
#P=0.7761, R=0.7790, F1=0.7730 ~2m35s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 10 -wordNgrams 3 -dim 120 -loss hs -thread 7
#P=0.7758, R=0.7790, F1=0.7730 ~3m30s
#P=0.7756, R=0.7785, F1=0.7727 ~4m28s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 10 -wordNgrams 3 -dim 200 -loss hs -thread 7
#P=0.8188, R=0.8134, F1=0.8117 ~82m1s
#P=0.8189, R=0.8141, F1=0.8122 ~90m17s
time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 10 -wordNgrams 3 -dim 200 -loss softmax -thread 7
#P=0.7757, R=0.7788, F1=0.7728 ~11m21s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 10 -wordNgrams 3 -dim 500 -loss hs -thread 7

#P=0.7793, R=0.7816, F1=0.7762 ~5m30s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 25 -wordNgrams 3 -dim 200 -loss hs -thread 7
#P=0.7799, R=0.7825, F1=0.7766 ~7m56s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 50 -wordNgrams 3 -dim 200 -loss hs -thread 7
#P=0.7769, R=0.7802, F1=0.7742
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 100 -wordNgrams 3 -dim 200 -loss hs -thread 7
#P=0.8151, R=0.8154, F1=0.8107 ~484m30s
#P=0.8146, R=0.8153, F1=0.8101 ~585m
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 1.0 -epoch 50 -wordNgrams 3 -dim 200 -loss softmax -thread 7



#P=0.7714, R=0.7707, F1=0.7667
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -epoch 50 -wordNgrams 3 -dim 300 -loss hs -thread 7
#P=0.7732, R=0.7712, F1=0.7681
#./FastText.exe supervised -input data/rdc.train -output data/model_rdc -epoch 100 -wordNgrams 3 -dim 300 -loss hs -thread 7
#P=0.7751, R=0.7722, F1=0.7697 ~36m41s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -epoch 200 -wordNgrams 3 -dim 300 -loss hs -thread 7
#P=0.7760, R=0.7723, F1=0.7704 ~87m48s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -epoch 500 -wordNgrams 3 -dim 300 -loss hs -thread 7
#P=0.7773, R=0.7733, F1=0.7715 ~175m3s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -epoch 1000 -wordNgrams 3 -dim 300 -loss hs -thread 7
#P=0.7779, R=0.7740, F1=0.7722 ~869m21s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -epoch 2000 -wordNgrams 3 -dim 300 -loss hs -thread 7


#~P=0.765
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -dim 150 -epoch 100 -wordNgrams 3 -minn 4 -maxn 10 -ws 7 -loss hs -thread 7
#P=0.7666, R=0.7680, F1=0.7640 ~90m
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -dim 200 -epoch 150 -wordNgrams 3 -minn 4 -maxn 10 -ws 7 -loss hs -thread 7
#P=0.8052, R=0.7909, F1=0.7940 ~297m59.095s
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -dim 200 -minn 4 -maxn 10 -wordNgrams 3 -neg 10 -loss ns -epoch 500 -thread 7

#performance increases due to dim are strongly associated with increased epochs i.e. increase one when increasing the other

#P=0.8112, R=0.8092, F1=0.8061 ~256m57s --> without sublabels (time possibly due to laptop being on standby part way through)
#P=0.7925, R=0.8010, F1=0.7894 ~107m57s --> with sublabels
#time ./FastText.exe supervised -input data/rdc.train -output data/model_rdc -lr 0.7 -epoch 20 -wordNgrams 3 -bucket 2000000 -dim 100 -loss softmax -thread 7

#returns top 50 labels for each line from highest to lowest probability left to right (can show probabilities by changing "predict" to "predict-prob")
echo "Finding best labels..."
tail -n 80000 rdc-catalog-train.tsv > data/actual.tsv
awk -F '\t' '{print $1}' data/actual.tsv > data/tempTitles
#find top 50 labels; if none of the top labels are full paths then the python script will not work as all labels will be removed 
#(i.e. increase this if python complains)
./FastText.exe predict data/model_rdc.bin data/rdc.test 50 > data/tempLabels1


#remove sub-labels --> if column doesn't contain a '~' then remove it
#awk -F ' ' '{for(i = 1; i <= NF; i++) if($i !~ /~/) $i = ""; print}' data/tempLabels1 > data/tempLabels2
#remove spaces at start of each line
#sed 's/^ *//g' data/tempLabels1 > data/tempLabels3


#remove trailing spaces & take highest probability labels (left most label), then remove the '~' symbols, then remove the "__label__" text used by fastText
cut -d' ' -f 1 data/tempLabels1 | tr -d '~' | tr -d '__label__' > data/tempLabels4

echo "Merging titles with labels..."
paste data/tempTitles data/tempLabels4 | awk -F '\t' '{print $1"\t"$2}' > data/predicted.tsv

echo "Removing temporary files..."
rm data/tempLabels1
rm data/tempLabels2
rm data/tempLabels3
rm data/tempLabels4
rm data/tempTitles

echo "Testing Model..."
#return precision & recall data
#./FastText.exe test data/model_rdc.bin data/rdc.test
#./FastText.exe test data/model_rdc.bin data/rdc.test 5
#./FastText.exe test data/model_rdc.bin data/rdc.test 10

./eval.py -pred data/predicted.tsv -gold data/actual.tsv

echo "Done!"

#Observations
#decreasing lr any lower than 1.0 usually decreases precision
#increase in precision based on epochs plateus between 20 and 25 epochs (stick to 20 in order to keep runtimes lower
#while my laptop has 8 logical processors and can therefore utilize 8 threads, 
#	7 threads allows the use of the laptop while performing a run without losing control of the mouse.