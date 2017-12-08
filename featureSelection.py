import pandas as pd
from skrebate import MultiSURF
from sklearn.model_selection import train_test_split

if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("-f",
                        "--file",
                        required=True,
                        help="matrix",
                        type=str)
    args = parser.parse_args()

    genetic_data = pd.read_csv(args.file, sep='\t')

    # Pick features and endpoint variables.
    features, labels = genetic_data.drop('class', axis=1).values, genetic_data['class'].values

    # Make sure to compute the feature importance scores from only your training set
    X_train, X_test, y_train, y_test = train_test_split(features, labels)

    fs = MultiSURF()
    fs.fit(X_train, y_train)

    f = dict()
    for feature_name, feature_score in zip(genetic_data.drop('class', axis=1).columns, fs.feature_importances_):
        if feature_name not in f:
            f[feature_name] = int(feature_score)
    s = pd.Series(f, name='score')
    s.index.name = 'Feature'
    s = s.reset_index()
    pd.DataFrame.to_csv(s, path_or_buf="features.tsv", sep="\t")
