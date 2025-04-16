VERSION=10.1.11
SHA256=a560268d5aa1f8dac9c158798828c495c4d266ce5953891494868d4647e36cac
NAME=ghcr.io/uenob/wstunnel:$(VERSION)
DOCKER=docker

wstunnel-$(VERSION).tar: Dockerfile v$(VERSION).tar.gz
	$(DOCKER) buildx build --build-arg VERSION=$(VERSION) --platform linux/amd64 -t $(NAME) .
	$(DOCKER) save -o $@ $(NAME)

v$(VERSION).tar.gz:
	curl -L -O https://github.com/erebe/wstunnel/archive/refs/tags/v$(VERSION).tar.gz
	test "$$(shasum -a256 $@)" = '$(SHA256)  $@'
