FROM docker.pkg.github.com/php-actions/php-build/php-build:latest

LABEL version="1.0.0"
LABEL repository="https://github.com/php-actions/phpunit"
LABEL homepage="https://github.com/php-actions/phpunit"
LABEL maintainer="Greg Bowler <greg.bowler@g105b.com>"

RUN apt-get update && apt-get install -y composer
RUN composer global require --no-progress phpunit/phpunit 9.*
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
