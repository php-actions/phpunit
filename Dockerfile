FROM ghcr.io/php-actions/php-build:latest

LABEL version="1.0.0"
LABEL repository="https://github.com/php-actions/phpunit"
LABEL homepage="https://github.com/php-actions/phpunit"
LABEL maintainer="Greg Bowler <greg.bowler@g105b.com>"

RUN curl https://phar.phpunit.de/phpunit-9.4.2.phar > phpunit-9.phar
RUN chmod +x *.phar
RUN ln -s $(pwd)/phpunit-9.phar /usr/local/bin/phpunit
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
