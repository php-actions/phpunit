FROM composer:1.9

LABEL version="1.0.0"
LABEL repository="https://github.com/php-actions/phpunit"
LABEL homepage="https://github.com/php-actions/phpunit"
LABEL maintainer="Greg Bowler <greg.bowler@g105b.com>"

RUN composer global require phpunit/phpunit ^8.0
RUN export PATH=/tmp/vendor/bin:$PATH
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]