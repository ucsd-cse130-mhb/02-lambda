test:
	stack test

bin:
	stack build

clean:
	stack clean

upstream:
	git remote add upstream https://github.com/ucsd-cse130-mhb/02-lambda.git

update:
	git pull upstream main

turnin:
	git commit -a -m "turnin"
	git push origin main
