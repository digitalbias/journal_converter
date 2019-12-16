include .env

default: run

run:
	mix run -e 'JournalConverter.CLI.run(["-f", "${JOURNAL_DIRECTORY}"])'

compile:
	mix compile

clean:
	find ${JOURNAL_DIRECTORY} -name "*.json" -type f -delete
	