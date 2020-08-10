.PHONY = all clean build_cmd build_docker release

PLATFORM_LINUX = GOARCH=amd64 GOOS=linux
INGRESS_VERSION = 0.0.1
REGISTRY = fupas-main

all: clean build_cmd build_docker

clean:
	rm build/ingress

build_cmd: cmd/ingress/main.go
	cd cmd/ingress && ${PLATFORM_LINUX} go build -o ../../build/ingress main.go

build_docker:
	docker build -t fupas/ingress:${INGRESS_VERSION} .

release:
	docker tag fupas/ingress:${INGRESS_VERSION} eu.gcr.io/${REGISTRY}/ingress:${INGRESS_VERSION}
	docker push eu.gcr.io/${REGISTRY}/ingress:${INGRESS_VERSION}