VERSIONS="7.3 7.4"
VARIATIONS="cli fpm"
TAGS="cli fpm cli-build"

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
