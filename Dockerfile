from alpine:3.7

# Update apk and add certificates to wget
RUN   apk update \
    && apk upgrade \
    && apk add --no-cache ca-certificates wget openssl build-base boost boost-dev cmake\
    && update-ca-certificates

# Download Turtle libraries
RUN wget -P / https://downloads.sourceforge.net/project/turtle/turtle/1.3.1/turtle-1.3.1.tar.gz

# Extract download and remove turtle archive file
RUN mkdir /usr/lib/turtle/ \
    && tar -xzvf /turtle-1.3.1.tar.gz -C /usr/lib/turtle/ \
    && rm /turtle-1.3.1.tar.gz

# Set ENV Vars for turtle and boost
ENV BOOST_LIB_PATH="/usr/include/boost"
ENV TURTLE_LIB_PATH="/usr/lib/turtle"
ENV PROJECT_DIR=""
ENV EXE_NAME=""

# Add bash script to run tests easier
COPY ./run_boost_test.sh /app/run_boost_test.sh
RUN chmod +x /app/run_boost_test.sh

# Run tests 
#ENTRYPOINT ["/app/run_boost_test.sh", "$PROJECT_DIR", "$EXE_NAME"]
