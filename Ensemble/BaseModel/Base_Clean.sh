rm -fr data

mkdir data

#reverse order of columns
echo "Arranging and labelling..."
awk -F '\t' '{print "__label__"$2"\t"$1}' ../rdc-catalog-train.tsv > data/rdc

echo "Splitting into train & test datasets..."
head -n 720000 data/rdc > data/base_rdc.train
tail -n 80000 data/rdc > data/base_rdc.test

echo "Removing temporary files..."
rm data/rdc

echo "Done!"