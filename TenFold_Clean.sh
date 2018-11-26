rm -fr data

mkdir data

#reverse order of columns
echo "Arranging and labelling..."
awk -F '\t' '{print "__label__"$2"\t"$1}' ./rdc-catalog-train.tsv > data/rdc

cd data/

echo "Splitting into train & test datasets..."
#split the dataset into equal part files each 10% of the original file's length
split -l 80000 -d rdc rdcTest
split -l 80000 -d ../rdc-catalog-train.tsv rdcActual

#Replace digits with 0 in product name
awk -F '\t' '{print $1}' rdc > rdc.labels
awk -F '\t' '{print $2}' rdc | sed 's/[0-9]/0/g' > rdc.names
paste rdc.labels rdc.names | awk -F '\t' '{print $1"\t"$2}'> rdc.clean

sed '1, 80000d' rdc.clean > rdcTrain00
sed '80001, 160000d' rdc.clean > rdcTrain01
sed '160001, 240000d' rdc.clean > rdcTrain02
sed '240001, 320000d' rdc.clean > rdcTrain03
sed '320001, 400000d' rdc.clean > rdcTrain04
sed '400001, 480000d' rdc.clean > rdcTrain05
sed '480001, 560000d' rdc.clean > rdcTrain06
sed '560001, 640000d' rdc.clean > rdcTrain07
sed '640001, 720000d' rdc.clean > rdcTrain08
sed '720001, 800000d' rdc.clean > rdcTrain09

echo "Removing temporary files..."
rm rdc
rm rdc.labels
rm rdc.names
rm rdc.clean

cd ..

echo "Done!"