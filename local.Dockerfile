# This dockerfile is for easily spinning up a local Hugo server to test out changes
# To get started:
# - `docker build -t jx-docs/dev -f local.Dockerfile .`
# - `docker run -v $PWD:/src -p 1313:1313 jx-docs/dev server -D --bind 0.0.0.0`

FROM linuxbrew/brew

RUN brew install hugo
RUN brew install node

WORKDIR /src
ENTRYPOINT [ "hugo" ]
EXPOSE 1313