rm -rf ./docs

cd ./sourcedocs

poetry run mkdocs build

mv site ../docs