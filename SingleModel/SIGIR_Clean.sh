rm -fr data

mkdir data

cp rdc-catalog-train.tsv data/rdc

#remove all characters except alphanumerics, newlines ('\n' and '\r'), tabs, spaces and '>'
#then change all characters to lower case
echo "Removing punctuation and changing to lowercase..."
#cat data/rdc | tr -dc '[:alnum:]\n\r\t\ \>' | tr [:upper:] [:lower:] > data/rdc.temp

#reverse order of columns
echo "Arranging and labelling..."
#awk -F '\t' '{print "__label__"$2"\t"$1}' data/rdc.temp > data/rdc.tempTwo
awk -F '\t' '{print "__label__"$2"\t"$1}' data/rdc > data/rdc.tempTwo

#keep product names in separate file
awk -F '\t' '{print $1}' data/rdc.tempTwo > data/rdc.tempFour #Three

#use sub-labels to train then remove for testing!
#comment out this line (and probably some stuff in the classify script in order to use fastText testing functions
#echo "Adding sub-labels..."
#the '~' symbol is added to the original label in order to keep track of it and simplify removing sub-labels later
#this does not impact results because the same operation is applied to the training and test sets and not removed until after the model is trained!
#awk -F '\t' '{print $1"~ "gensub(/>/, "__label__", "g")}' data/rdc.tempTwo> data/rdc.tempThree
#./SubLabel.exe data/rdc.tempThree data/rdc.tempThree
#remove \r newlines made by C# executable
#sed 's/ \r//g' data/rdc.tempThree | sed 's/\r//g' > data/rdc.tempFour

echo "Replacing all digits with 0..."
awk -F '\t' '{print $2}' data/rdc.tempTwo | sed 's/[0-9]/0/g' > data/rdc.tempFive

paste data/rdc.tempFour data/rdc.tempFive | awk -F '\t' '{print $1"\t"$2}'> data/rdc.clean #tempFive

#process words to their stem using external ANSI C application --> try turning off for increased in accuracy
#echo "Stemming..."
#./CPorterStemmer data/rdc.tempFive > data/rdc.clean

echo "Splitting into train & test datasets..."
head -n 720000 data/rdc.clean > data/rdc.train
tail -n 80000 data/rdc.clean > data/rdc.test

echo "Removing temporary files..."
rm data/rdc
rm data/rdc.temp
rm data/rdc.tempTwo
#rm data/rdc.tempThree
rm data/rdc.tempFour
rm data/rdc.tempFive

rm data/rdc.clean

echo "Done!"