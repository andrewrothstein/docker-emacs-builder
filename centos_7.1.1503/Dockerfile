FROM centos:7.1.1503
MAINTAINER Andrew Rothstein <andrew.rothstein@gmail.com>

ENV BUILD_DEP_PKGS "git wget tar gzip gcc make autoconf automake libtool ncurses-devel ruby ruby-devel rpm-build"
ENV BUILD_DEP_GEMS "fpm"

ENV APP_NAME emacs
ENV APP_VER 24.5
ENV APP_PKG_TYPE rpm

ENV BUILD_SRC_DIR /tmp/$APP_NAME
ENV BUILD_SRC_SUBDIR $APP_NAME-$APP_VER
ENV BUILD_SRC_FQDIR $BUILD_SRC_DIR/$BUILD_SRC_SUBDIR
ENV BUILD_TARGET_DIR /tmp/installdir

RUN yum update -y && yum install -y $BUILD_DEP_PKGS
RUN mkdir -p $BUILD_SRC_DIR

ENV CURL_TRANSPORT http
ENV CURL_FILE emacs-$APP_VER.tar.xz
ENV CURL_MIRROR gnu.mirror.vexxhost.com
ENV CURL_SRC_URL $CURL_TRANSPORT://$CURL_MIRROR/emacs/$CURL_FILE
RUN wget $CURL_SRC_URL
RUN tar xvf $CURL_FILE -C $BUILD_SRC_DIR

WORKDIR $BUILD_SRC_FQDIR
RUN ./autogen.sh
RUN ./configure --prefix=/usr
RUN make -j 4
RUN mkdir -p $BUILD_TARGET_DIR && make install DESTDIR=$BUILD_TARGET_DIR

VOLUME ['pkgdir']
RUN gem install --no-ri --no-rdoc $BUILD_DEP_GEMS

CMD fpm \
 -t $APP_PKG_TYPE \
 -s dir \
 -n $APP_NAME \
 -v $APP_VER \
 -C $BUILD_TARGET_DIR \
 -p /pkgdir/${APP_NAME}-VERSION-ARCH.${APP_PKG_TYPE} \
 usr

