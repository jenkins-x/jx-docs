module github.com/jenkins-x/jx-docs

go 1.17

require (
	github.com/FortAwesome/Font-Awesome v0.0.0-20210804190922-7d3d774145ac // indirect
	github.com/google/docsy v0.3.0 // indirect
	github.com/google/docsy/dependencies v0.3.0 // indirect
	github.com/twbs/bootstrap v5.1.3+incompatible // indirect
)

// Docsy not compatible with bootstrap 5 yet: https://github.com/google/docsy/issues/470
replace (
	github.com/twbs/bootstrap => github.com/twbs/bootstrap v4.6.1+incompatible
)
