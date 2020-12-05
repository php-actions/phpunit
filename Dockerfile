FROM ghcr.io/php-actions/php-build:v1

LABEL version="1.0.0"
LABEL repository="https://github.com/php-actions/phpunit"
LABEL homepage="https://github.com/php-actions/phpunit"
LABEL maintainer="Greg Bowler <greg.bowler@g105b.com>"

RUN curl https://phar.phpunit.de/phpunit-9.5.0.phar > phpunit-9.phar
RUN curl https://phar.phpunit.de/phpunit-8.5.8.phar > phpunit-8.phar
RUN curl https://phar.phpunit.de/phpunit-7.5.9.phar > phpunit-7.phar
RUN curl https://phar.phpunit.de/phpunit-6.5.9.phar > phpunit-6.phar
RUN chmod +x *.phar
RUN ln -s $(pwd)/phpunit-9.phar /usr/local/bin/phpunit-9
RUN ln -s $(pwd)/phpunit-8.phar /usr/local/bin/phpunit-8
RUN ln -s $(pwd)/phpunit-7.phar /usr/local/bin/phpunit-7
RUN ln -s $(pwd)/phpunit-6.phar /usr/local/bin/phpunit-6
RUN ln -s /usr/local/bin/phpunit-9 /usr/local/bin/phpunit
COPY switch-phpunit-version /usr/local/bin/.
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
