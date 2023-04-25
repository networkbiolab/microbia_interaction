import sys
import pandas as pd
import numpy as np
from sklearn.cluster import KMeans


nClusters = 10;

# Read the data
#~ print("==Reading file==")
df = pd.read_csv("/home/clau/Escritorio/microbia_interaction-main/kmeans/4clustering.tsv", sep='\t')
y = np.array(df['target'])
feature_list = list(df.columns)
df = np.array(df.drop('target', axis=1));
#~ print(y)
kmeans = KMeans(n_clusters=nClusters, random_state=0).fit(df)
#~ print(kmeans.labels_)

res = kmeans.predict(df)

with open('clusters.tsv', 'w') as f:
	for i in range(y.size):
		print (y[i],res[i], sep="\t",file=f)


counts = np.bincount(res)
for i in range(nClusters):
	print(i,counts[i], sep="\t")


#clusters clustered into 4 clusters
#~ 1+4+7	660
#~ 0+2+9	667
#~ 8+5	660
#~ 3+6	637
