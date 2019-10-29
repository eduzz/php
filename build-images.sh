VERSIONS="7.1 7.2 7.3"
VARIATIONS="cli fpm apache"
TAGS="cli fpm apache cli-build"

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
