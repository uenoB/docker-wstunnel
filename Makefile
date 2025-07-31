VERSION=10.4.4
SHA256=69a12b8bbc2888dcefc84a90fbdf9925c7292e3b2839108a8aa1caf4a6758ffb
NAME=ghcr.io/uenob/wstunnel:$(VERSION)
DOCKER=docker

wstunnel-$(VERSION).tar: Dockerfile v$(VERSION).tar.gz
	$(DOCKER) buildx build --build-arg VERSION=$(VERSION) --platform linux/amd64 -t $(NAME) .
	$(DOCKER) save -o $@ $(NAME)

v$(VERSION).tar.gz:
	curl -L -O https://github.com/erebe/wstunnel/archive/refs/tags/v$(VERSION).tar.gz
	test "$$(shasum -a256 $@)" = '$(SHA256)  $@'
