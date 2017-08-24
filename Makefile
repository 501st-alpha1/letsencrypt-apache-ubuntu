.PHONY: all push

USER="501stalpha1"
ifeq ($(shell uname -m), i686)
  PLATFORM="386"
else
  PLATFORM="amd64"
endif

all: .last-docker-build

.last-docker-build: Dockerfile
	docker build -t "$(USER)/letsencrypt-apache-ubuntu:$(PLATFORM)" .
	@touch $@

push: .last-docker-push

.last-docker-push: .last-docker-build
	docker push "$(USER)/letsencrypt-apache-ubuntu:$(PLATFORM)"
	manifest-tool push from-spec ./manifest.yml --ignore-missing
	@touch $@
