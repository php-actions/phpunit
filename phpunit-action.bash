#!/bin/bash
set -e
github_action_path=$(dirname "$0")
docker_tag=$(cat ./docker_tag)
echo "Docker tag: $docker_tag"

command_string="phpunit"

if [ -n "$ACTION_CONFIGURATION" ]
then
	command_string="$command_string --configuration $ACTION_CONFIGURATION"
fi

if [ -n "$ACTION_LOG_JUNIT" ]
then
	command_string="$command_string --log-junit $ACTION_LOG_JUNIT"
fi

if [ -n "$ACTION_TESTDOX_HTML" ]
then
	command_string="$command_string --testdox-html $ACTION_TESTDOX_HTML"
fi

if [ -n "$ACTION_TESTDOX_TEXT" ]
then
	command_string="$command_string --testdox-text $ACTION_TESTDOX_TEXT"
fi

if [ -n "$ACTION_TESTDOX_XML" ]
then
	command_string="$command_string --testdox-xml $ACTION_TESTDOX_XML"
fi

if [ -n "$ACTION_BOOTSTRAP" ]
then
	command_string="$command_string --bootstrap $ACTION_BOOTSTRAP"
fi

if [ -n "$ACTION_FILTER" ]
then
	command_string="$command_string --filter $ACTION_FILTER"
fi

if [ -n "$ACTION_TESTSUITE" ]
then
	command_string="$command_string --testsuite $ACTION_TESTSUITE"
fi

if [ -n "$ACTION_GROUP" ]
then
	command_string="$command_string --group $ACTION_GROUP"
fi

if [ -n "$ACTION_EXCLUDE_GROUP" ]
then
	command_string="$command_string --exclude-group $ACTION_EXCLUDE_GROUP"
fi

if [ -n "$ACTION_TEST_SUFFIX" ]
then
	command_string="$command_string --test-suffix $ACTION_TEST_SUFFIX"
fi

if [ -n "$ACTION_WHITELIST" ]
then
	command_string="$command_string --whitelist $ACTION_WHITELIST"
fi

if [ -n "$ACTION_MEMORY_LIMIT" ]
then
	command_string="$command_string -d memory_limit=$ACTION_MEMORY_LIMIT"
fi

if [ -n "$ACTION_ARGS" ]
then
	command_string="$command_string $ACTION_ARGS"
fi

echo "Command: $command_string"

docker run --rm \
	--volume ${github_action_path}/phpunit.phar:/usr/local/bin/phpunit \
	--volume ${GITHUB_WORKSPACE}:/app \
	--workdir /app \
	${docker_tag} ${command_string}