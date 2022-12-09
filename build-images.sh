VERSIONS="8.1"
VARIATIONS="cli fpm"
TAGS="cli fpm cli-build"

for version in $VERSIONS; do
    for variation in $VARIATIONS; do
        docker pull "php:$version-$variation-buster"
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
