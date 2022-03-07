VERSIONS="8.1"
VARIATIONS="fpm cli"
TAGS="fpm cli"

for version in $VERSIONS; do
    for variation in $VARIATIONS; do
        docker pull "php:$version-$variation"
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker build -t "eduzz/php:$version-$tag" -f "$version-$tag" .
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker push "eduzz/php:$version-$tag"
    done
done
