REPORTER = spec
TESTS = $(shell find test -name "*.test.coffee")

test-f:
	@NODE_ENV=test mocha \
		--reporter $(REPORTER) \
		--compilers coffee:coffee-script \
		--ui bdd \
		--watch \
		$(FILE)

test-all:	
	@NODE_ENV=test mocha \
		--reporter $(REPORTER) \
		--compilers coffee:coffee-script \
		--ui bdd \
		--timeout 3000 \
		$(TESTS)

test-all-w:	
	@NODE_ENV=test mocha \
		--reporter $(REPORTER) \
		--compilers coffee:coffee-script \
		--ui bdd \
		--watch \
		--timeout 3000 \
		$(TESTS)

.PHONY: test-all test-all-w test-f