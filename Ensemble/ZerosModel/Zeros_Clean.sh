rm -fr data

mkdir data

#remove all characters except alphanumerics, newlines ('\n' and '\r'), tabs, spaces and '>'
#then change all characters to lower case
echo "Removing punctuation and changing to lowercase..."
cat ../rdc-catalog-train.tsv | tr -dc '[:alnum:]\n\r\t\ \>' | tr [:upper:] [:lower:] > data/rdc1

#reverse order of columns
echo "Arranging and labelling..."
awk -F '\t' '{print "__label__"$2"\t"$1}' data/rdc1 > data/rdc2

#keep product names in separate file
awk -F '\t' '{print $1}' data/rdc2 > data/rdc3

echo "Replacing all digits with 0..."
awk -F '\t' '{print $2}' data/rdc2 | sed 's/[0-9]/0/g' > data/rdc4

paste data/rdc3 data/rdc4 | awk -F '\t' '{print $1"\t"$2}'> data/rdc.clean #tempFive

echo "Splitting into train & test datasets..."
head -n 720000 data/rdc.clean > data/zeros_rdc.train
tail -n 80000 data/rdc.clean > data/zeros_rdc.test

echo "Removing temporary files..."
rm data/rdc1
rm data/rdc2
rm data/rdc3
rm data/rdc4

rm data/rdc.clean

echo "Done!"