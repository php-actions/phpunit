FROM ghcr.io/php-actions/php-build:latest

LABEL version="1.0.0"
LABEL repository="https://github.com/php-actions/phpunit"
LABEL homepage="https://github.com/php-actions/phpunit"
LABEL maintainer="Greg Bowler <greg.bowler@g105b.com>"

RUN curl https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer | php -- --quiet
RUN ./composer.phar global require --no-progress phpunit/phpunit 9.*
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
