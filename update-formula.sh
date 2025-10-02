TAG=$(git -C ../flank describe --tags --abbrev=0)
if [ -z "$TAG" ]; then
  echo "TAG is empty, exiting."
  exit 1
fi
echo "found TAG: $TAG"
curl -L https://github.com/btf-org/flank/archive/refs/tags/$TAG.tar.gz -o /tmp/flank-$TAG.tar.gz
SHA=$(shasum -a 256 /tmp/flank-$TAG.tar.gz | awk '{print $1}')
rm /tmp/flank-$TAG.tar.gz
TAG_NO_V=$(echo $TAG | sed "s/^v//")
sed -i '' "s/sha256 \".*\"/sha256 \""$SHA"\"/" Formula/flank.rb
sed -i '' "s#tags/.*\.tar#tags/""$TAG"".tar#" Formula/flank.rb
sed -i '' "s/version \".*/version \""$TAG_NO_V"\"/" Formula/flank.rb

grep "url" Formula/flank.rb
grep "version" Formula/flank.rb
grep "sha256" Formula/flank.rb
