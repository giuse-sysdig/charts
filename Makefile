
docs: deps
	find -name "doc.yaml" | \
		xargs -L1 dirname | \
		xargs -I% sh -c \
			"cd %; chart-doc-gen -v values.yaml -d doc.yaml -t README.tpl > README.md"

lint: clean
	docker run --pull always --rm -e CT_VALIDATE_MAINTAINERS=false -u $(shell id -u) -v $(PWD):/charts quay.io/helmpack/chart-testing:latest sh -c "cd /charts; ct lint --all"

deps:
	go install kubepack.dev/chart-doc-gen@latest

clean:
	find -name "Chart.lock" -type f | xargs rm -f