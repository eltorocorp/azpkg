#!/bin/sh

# update the system
yum update -y

yum install -y git make autoconf automake openssl-devel libtool xz-devel bzip2-devel zlib-devel patch

git clone https://github.com/facebook/zstd.git
cd zstd
make
make install
cd ..

git clone https://anongit.freedesktop.org/git/libbsd.git
cd libbsd
./autogen
./configure --prefix=/usr
make
make install
cp /usr/lib/libbsd* /usr/lib64/
cd ..

# The libarchive-devel package is too old,
# missing zstd support.
git clone https://github.com/libarchive/libarchive.git
cd libarchive

# Not an expert, but this worked.
patch -l << 'EOF'
diff --git a/configure.ac b/configure.ac
index 84888e47..a2ec85a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -591,10 +591,13 @@ AC_CHECK_DECL([EILSEQ],
                [AC_DEFINE(HAVE_EILSEQ, 1, [A possible errno value for invalid file format errors])],
                [],
                [#include <errno.h>])
-AC_CHECK_TYPE([wchar_t],
-               [AC_DEFINE_UNQUOTED(AS_TR_CPP(HAVE_[]wchar_t), 1, [Define to 1 if the system has the type `wchar_t'.])dnl
-               AC_CHECK_SIZEOF([wchar_t])],
-               [])
+# AC_CHECK_TYPE([wchar_t],
+#              [AC_DEFINE_UNQUOTED(AS_TR_CPP(HAVE_[]wchar_t), 1, [Define to 1 if the system has the type `wchar_t'.])dnl
+#              AC_CHECK_SIZEOF([wchar_t])],
+#              [])
+
+AC_DEFINE_UNQUOTED(AS_TR_CPP(HAVE_[]wchar_t))
+AC_DEFINE([HAVE_WCHAR_T], [], [Description])
 
 AC_HEADER_TIME
 
EOF
build/autogen.sh
./configure
make
make install
cd ..

git clone https://github.com/jrmarino/pkg
cd pkg
./autogen.sh
./configure
make
make install
cd ..

# /usr/local/bin/pkg should now be installed.
# Don't leave the shell yet, otherwise you will lose your state. 
# 

