VERSIONS="8.2 8.3"
VARIATIONS="cli fpm"
TAGS="cli fpm cli-build"

for version in $VERSIONS; do
    for variation in $VARIATIONS; do
        docker pull "php:$version-$variation-bookworm"
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker build -t "eduzz/php:$version-$tag-beta" -f "$version-$tag" .
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker push "eduzz/php:$version-$tag-beta"
    done
done
