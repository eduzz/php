VERSIONS="8.0"
VARIATIONS="cli-buster fpm-buster"
TAGS="cli fpm"

for version in $VERSIONS; do
    for variation in $VARIATIONS; do
        docker pull "php:$version-$variation"
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker build -t "eduzz/php:$version-$tag" -f $version .
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker push "eduzz/php:$version-$tag"
    done
done
