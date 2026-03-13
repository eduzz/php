VERSIONS="8.3"
VARIATIONS="cli fpm"
TAGS="cli fpm cli-build"

for version in $VERSIONS; do
    for variation in $VARIATIONS; do
        docker pull "php:$version-$variation-bookworm"
    done
done

for version in $VERSIONS; do
    for tag in $TAGS; do
        docker build --build-arg PHP_VERSION=$version --progress plain -t "eduzz/php:$version-$tag-tmp" -f "$tag.Dockerfile" .
    done
done

# for version in $VERSIONS; do
#     for tag in $TAGS; do
#         docker push "eduzz/php:$version-$tag"
#     done
# done
