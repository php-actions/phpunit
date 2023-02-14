#!/bin/bash
set -e
github_action_path=$(dirname "$0")
docker_tag=$(cat ./docker_tag)

echo "Docker tag: $docker_tag" >> output.log 2>&1

if [ -z "$ACTION_PHPUNIT_PATH" ]
then
	phar_url="https://phar.phpunit.de/phpunit"
	if [ "$ACTION_VERSION" != "latest" ]
	then
		phar_url="${phar_url}-${ACTION_VERSION}"
	fi
	phar_url="${phar_url}.phar"
	echo "Using phar url $phar_url" >> output.log 2>&1

	phar_path="${github_action_path}/phpunit.phar"
	curl --silent -H "User-agent: cURL (https://github.com/php-actions)" -L "$phar_url" > "$phar_path"
else
	echo "Using vendored phpunit" >> output.log 2>&1
	phar_path="${GITHUB_WORKSPACE}/$ACTION_PHPUNIT_PATH"
fi

echo "phar_path=$phar_path" >> output.log 2>&1
chmod +x $phar_path
command_string=("phpunit")

if [ -n "$ACTION_CONFIGURATION" ]
then
	command_string+=(--configuration "$ACTION_CONFIGURATION")
fi

if [ -n "$ACTION_LOG_JUNIT" ]
then
	command_string+=(--log-junit "$ACTION_LOG_JUNIT")
fi

if [ -n "$ACTION_TESTDOX_HTML" ]
then
	command_string+=(--testdox-html "$ACTION_TESTDOX_HTML")
fi

if [ -n "$ACTION_TESTDOX_TEXT" ]
then
	command_string+=(--testdox-text "$ACTION_TESTDOX_TEXT")
fi

if [ -n "$ACTION_BOOTSTRAP" ]
then
	command_string+=(--bootstrap "$ACTION_BOOTSTRAP")
fi

if [ -n "$ACTION_FILTER" ]
then
	command_string+=(--filter "$ACTION_FILTER")
fi

if [ -n "$ACTION_TESTSUITE" ]
then
	command_string+=(--testsuite "$ACTION_TESTSUITE")
fi

if [ -n "$ACTION_GROUP" ]
then
	command_string+=(--group "$ACTION_GROUP")
fi

if [ -n "$ACTION_EXCLUDE_GROUP" ]
then
	command_string+=(--exclude-group "$ACTION_EXCLUDE_GROUP")
fi

if [ -n "$ACTION_TEST_SUFFIX" ]
then
	command_string+=(--test-suffix "$ACTION_TEST_SUFFIX")
fi

if [ -n "$ACTION_WHITELIST" ]
then
	command_string+=(--whitelist "$ACTION_WHITELIST")
fi

if [ -n "$ACTION_MEMORY_LIMIT" ]
then
	command_string+=(-d memory_limit="$ACTION_MEMORY_LIMIT")
fi

if [ -n "$ACTION_COVERAGE_CLOVER" ]
then
	command_string+=(--coverage--clover "$ACTION_COVERAGE_CLOVER")
fi

if [ -n "$ACTION_COVERAGE_COBERTURA" ]
then
	command_string+=(--coverage-cobertura "$ACTION_COVERAGE_COBERTURA")
fi

if [ -n "$ACTION_COVERAGE_CRAP4J" ]
then
	command_string+=(--coverage-crap4j "$ACTION_COVERAGE_CRAP4J")
fi

if [ -n "$ACTION_COVERAGE_HTML" ]
then
	command_string+=(--coverage-html "$ACTION_COVERAGE_HTML")
fi

if [ -n "$ACTION_COVERAGE_PHP" ]
then
	command_string+=(--coverage-php "$ACTION_COVERAGE_PHP")
fi

if [ -n "$ACTION_COVERAGE_TEXT" ]
then
	if [ "${ACTION_COVERAGE_TEXT,,}" = "true" ]
	then
		command_string+=(--coverage-text)
	else
		command_string+=(--coverage-text "$ACTION_COVERAGE_TEXT")
	fi
fi

if [ -n "$ACTION_COVERAGE_XML" ]
then
	command_string+=(--coverage-xml "$ACTION_COVERAGE_XML")
fi

command_string+=(--colors=always)

if [ -n "$ACTION_ARGS" ]
then
	command_string+=($ACTION_ARGS)
fi

echo "Command: ${command_string[@]}" >> output.log 2>&1

docker run --rm \
	--volume "${phar_path}":/usr/local/bin/phpunit \
	--volume "${GITHUB_WORKSPACE}":/app \
	--workdir /app \
	--network host \
	--env-file <( env| cut -f1 -d= ) \
	${docker_tag} "${command_string[@]}"
