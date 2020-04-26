from alpine:3.7

# Update apk and add certificates to wget
RUN   echo "x86" > /etc/apk/arch\
    && apk update \
    && apk upgrade \
    && apk add --no-cache ca-certificates wget openssl build-base cmake \ 
    && update-ca-certificates

# Download Turtle library
RUN wget -P / https://downloads.sourceforge.net/project/turtle/turtle/1.3.1/turtle-1.3.1.tar.gz

# Extract download and remove turtle archive file
RUN mkdir /usr/lib/turtle/ \
    && tar -xzvf /turtle-1.3.1.tar.gz -C /usr/lib/turtle/ \
    && rm /turtle-1.3.1.tar.gz

# Download boost libraries
RUN wget -P / https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz

# Extract download and remove boost archive file
RUN tar -xzvf /boost_1_72_0.tar.gz -C / \
    && mv /boost_1_72_0 /boost \
    && rm /boost_1_72_0.tar.gz

# Build Boost Lib
RUN mkdir /usr/lib/boost/ \
    && cd /boost/tools/build/ \
    && ./bootstrap.sh \
    && ./b2 install --prefix=/usr/lib/boost/ 

RUN cd /boost \
    &&/usr/lib/boost/bin/b2 address-model=32 architecture=x86 toolset=gcc --with-test link=shared --with-test --build-dir=/usr/lib/boost --libdir=/usr/lib/boost/lib --includedir=/usr/lib/boost/include

# Set ENV Vars for turtle and boost
ENV BOOST_LIB_PATH="/usr/lib/boost"
ENV TURTLE_LIB_PATH="/usr/lib/turtle"
ENV EXE_NAME=""

# Add bash script to run tests easier
COPY ./run_boost_test.sh /app/run_boost_test.sh
RUN chmod +x /app/run_boost_test.sh

# Run tests 
#ENTRYPOINT ["/app/run_boost_test.sh", "/project", $EXE_NAME]
