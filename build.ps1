# list supported architectures
docker buildx ls

# Create and Initialize Multiarch Builder
docker buildx create --name multiarch-build
docker buildx use multiarch-build
docker buildx inspect --bootstrap

# Build Multiarch Image
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t brad07x/ubuntu:bionic --push .

# Cleanup Builder
docker buildx rm multiarch-build