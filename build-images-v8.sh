VERSIONS="8.0"
TAGS="cli fpm"

for version in $VERSIONS; do
    for tag in $TAGS; do
        IMAGE_TAG="$version-$tag-buster"
        docker pull "php:$IMAGE_TAG"
        docker build -t "eduzz/php:$version-$tag" -f $version --build-arg PHP_IMAGE_VERSION="$IMAGE_TAG" .
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker push "eduzz/php:$version-$tag"
    done
done
