Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD86CAC59D
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:51 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.31669.1757938909079643180
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 05:21:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0s87eklD;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 85837C8F1FE
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF9B76063F
	for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F858102F2AB8;
	Mon, 15 Sep 2025 14:21:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757938907; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ERAPWwtL2me5oGjbHLTIM/x5VLkHYo+qPQZzppygLW8=;
	b=0s87eklDCsZohXgSfgXqb16147PO7K8IHI8LeRQiOgjWTnODlGqm57S70Zt1rFexqXedtF
	EzOgxc6WpDBXyokfMqrNQ5Hy/ALy0zQbmzwMdHW3ZYoL99NcIF9AqK31kzm2BJZDh/Tij8
	NEZyTJchIWgSJe/AMk0ynv5PuUNPFP3gTG664T82Cw1N1E/WqOXsCDVSvBqy4W+cWfleoa
	UGwMeVbSvN6tSubHL+37IqqxKPFDeLhQAj0+0deA0i90RYFF+Yu/DJvh5XR3+TqqA97nTI
	+6jVi5eJI8epL2svqW/EIs1BbzmqUvcPjKfMB97ky1/souRKVfewVoeeFhxXAw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 15 Sep 2025 14:19:47 +0200
Subject: [yocto-autobuilder-helper][PATCH 1/3] scripts/run-docs-build:
 cleanups and improvements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pass-bitbake-active-releases-v1-1-a5530a97b9ef@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
In-Reply-To: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7747;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Xd1iJzM4fmHJe7bV+d2PaJYHqCFdTc7afgzo4yPU33g=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyATaIdIOa1Ct4mdN42vI6UUGhsjx/nlRCxWou
 S4EvSVUwgWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgE2gAKCRDRgEFAKaOo
 Nr/6D/9GLiaS9QbnaF2qOeIpCOfido3NP974ebvb0gmVRtJMkb89dnKTRYiAKtx9n+0xRRpSfJX
 yyxHqcv/WZcaLy76esNQseTm41ZS1O8jn2sRvfTNvvpnR8WbDKTZtViVqFub690Yj0/eI9EX7D1
 pzB21/X6zOSbsyVqucGh8LOUJJO+CWVrqJmXs9DXrPGH2M+OLsaBBtIy7sbZhTpCFv5hISCEcxr
 8sOUAHER47sWtF3Zg7qBpDiKYsMvwB7hMpj9iHvWmeuGZ1NifW1WEwxlUUk5jG3xnGa8rcLma8i
 QhvbFKOi8zFL8Ng3LvrYelx567v2i1ua2oaIKYxnAcwjMdk2xJzylv4jgL3myOR8zm2Fi26pMbN
 hBqrzk40ljkFM6S2pJlyi08f7SMouikMx9y5T0A4PB87KlcrwX4hDkt/thFcK95GAm8y4RXCkXi
 z2NbHmb5lk/h028D/fbyFAlh4NJeXl07OmYVm4Dz31P6H8Wza4Xnp9f8mQGg5hvWmvD5oy7BDcz
 dHvTjmPUlteRbnZY2doAYDfUeNcVKOh8yfBV4VBt7VsZtmJCP75sJH2yrlzpwNNULWskGZu1BLf
 9+qeoldcrmjY74nj6ySSyhzAZ2KLZHzvtfEvkQmS7FCWqSLUfji8L8pyxp8VUeVTvGu7A93Qieb
 KxNPuNPzLGdBL5Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 12:21:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2188

- Make it possible to override the shared directory to a local directory
  from environment
- Make variables that can be overridden from environment variables
  uppercase, for clarity
- Convert mkdir to mkdir -p when creating output directories
- Minor indent fixes and overall cleanups

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 78 +++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index a001fb2..aa1847d 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -7,53 +7,67 @@
 #             $3 as the path to bitbake
 #
 # Environment variables:
-#   - buildtools_url as the path to buildtools script for the docs.
-#                     Can be found here: https://autobuilder.yocto.io/pub/buildtools/
-#   - docbookarchive_url as the path to old (pre 3.1.5 and Sphinx migration) docs tarball
-#                     Can be found here: https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz
-#   - PUBLISH (0/1) for whether the files should be rsync'ed to docs.yoctoproject.org
+#   - BUILDTOOLS_URL: path to buildtools script for the docs. Can be found here:
+#     https://autobuilder.yocto.io/pub/buildtools/
+#   - BUILDTOOLS_URL_OLD: path to the old buildtools script for docs releases
+#     older than scarthgap.
+#   - DOCBOOKARCHIVE_URL: path to old (pre 3.1.5 and Sphinx migration) docs
+#     tarball Can be found here: https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz
+#   - SHAREDIR as the path to a shared directory that caches downloads. Default
+#     to $BASE_SHAREDDIR/cluster-downloads-cache, where BASE_SHAREDDIR is
+#     extracted from $HOME/config-local.json
+#   - PUBLISH (0/1) (default: 1): whether the files should be rsync'ed to docs.yoctoproject.org
 
 set -e
 set -u
 set -o pipefail
 set -x
 
+# Environment variables
+PUBLISH=${PUBLISH:-1}
+# Modified 5.1 tools image to include rsvg, switch to next released version
+BUILDTOOLS_URL=${BUILDTOOLS_URL:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.1-modified.sh}
+BUILDTOOLS_URL_OLD=${BUILDTOOLS_URL_OLD:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
+DOCBOOKARCHIVE_URL=${DOCBOOKARCHIVE_URL:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
+SHAREDIR=${SHAREDIR:-"$(jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json)/cluster-downloads-cache"}
+
 builddir=$(realpath "$1")
 ypdocs=$(realpath "$2/documentation/")
 bbdocs=$(realpath "$3/doc/")
 outputdir=$builddir/output
 scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
-PUBLISH=${PUBLISH:-1}
-sharedir=`jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json`
-# Modified 5.1 tools image to include rsvg, switch to next released version
-buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.1-modified.sh}
-buildtools_url_old=${buildtools_url_old:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
-docbookarchive_url=${docbookarchive_url:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
+# make sure SHAREDIR is absolute
+SHAREDIR=$(readlink -f "$SHAREDIR")
 
 
-buildtools_name=`basename $buildtools_url`
-buildtools_localpath=${sharedir}/cluster-downloads-cache/${buildtools_name}
+buildtools_name=`basename $BUILDTOOLS_URL`
+buildtools_localpath=${SHAREDIR}/${buildtools_name}
 if [ ! -e ${buildtools_localpath} ]; then
     mkdir -p `dirname ${buildtools_localpath}`
-    wget ${buildtools_url} -O ${buildtools_localpath}
+    wget ${BUILDTOOLS_URL} -O ${buildtools_localpath}
     chmod a+x ${buildtools_localpath}
 fi
+mkdir -p $builddir
 cd $builddir
-mkdir buildtools
-${buildtools_localpath} -y -d $builddir/buildtools
+mkdir -p buildtools
+if [ ! -d "$builddir/buildtools/sysroots" ]; then
+    ${buildtools_localpath} -y -d $builddir/buildtools
+fi
 
 
-buildtools_name_old=`basename $buildtools_url_old`
-buildtools_localpath_old=${sharedir}/cluster-downloads-cache/${buildtools_name_old}
+buildtools_name_old=`basename $BUILDTOOLS_URL_OLD`
+buildtools_localpath_old=${SHAREDIR}/${buildtools_name_old}
 if [ ! -e ${buildtools_localpath_old} ]; then
     mkdir -p `dirname ${buildtools_localpath_old}`
-    wget ${buildtools_url_old} -O ${buildtools_localpath_old}
+    wget ${BUILDTOOLS_URL_OLD} -O ${buildtools_localpath_old}
     chmod a+x ${buildtools_localpath_old}
 fi
 
 cd $builddir
-mkdir buildtools-old
-${buildtools_localpath_old} -y -d $builddir/buildtools-old
+mkdir -p buildtools-old
+if [ ! -d "$builddir/buildtools-old/sysroots" ]; then
+    ${buildtools_localpath_old} -y -d $builddir/buildtools-old
+fi
 
 
 # To build the latexpdf output we need Xetex (which can handle international characters)
@@ -84,21 +98,21 @@ fi
 export FONTCONFIG_PATH="$scriptdir/docsfontconfig"
 
 # Getting the old docbook built docs from an archive. Not rebuilding them.
-docbookarchive_localpath=${sharedir}/cluster-downloads-cache/`basename ${docbookarchive_url}`
+docbookarchive_localpath=${SHAREDIR}/`basename ${DOCBOOKARCHIVE_URL}`
 if [ ! -e ${docbookarchive_localpath} ]; then
     mkdir -p `dirname ${docbookarchive_localpath}`
-    wget ${docbookarchive_url} -O ${docbookarchive_localpath}
+    wget ${DOCBOOKARCHIVE_URL} -O ${docbookarchive_localpath}
 fi
 
-mkdir $outputdir
+mkdir -p $outputdir
 cd $outputdir
-echo Extracing old content from archive
+echo Extracting old content from archive
 tar --exclude=eclipse -xJf ${docbookarchive_localpath}
 
 $scriptdir/docs_add_banner.py
 
 cd $bbdocs
-mkdir $outputdir/bitbake
+mkdir -p $outputdir/bitbake
 
 # A decision was made to keep updating all the Sphinx generated docs for the moment,
 # even the ones corresponding to no longer supported releases
@@ -128,16 +142,16 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
 
     if [ "$branch" = "master-next" ]; then
         branch="next"
-	mkdir $outputdir/bitbake/$branch
+        mkdir -p $outputdir/bitbake/$branch
     elif [ "$branch" = "master" ]; then
         branch="dev"
-        mkdir $outputdir/bitbake/$branch
+        mkdir -p $outputdir/bitbake/$branch
     elif [ "$branch" = "$latest_branch" ]; then
         branch=""
-        mkdir $outputdir/bitbake/$latest_branch
+        mkdir -p $outputdir/bitbake/$latest_branch
         cp -r ./_build/final/* $outputdir/bitbake/$latest_branch
     else
-	mkdir $outputdir/bitbake/$branch
+        mkdir -p $outputdir/bitbake/$branch
     fi
 
     cp -r ./_build/final/* $outputdir/bitbake/$branch
@@ -222,7 +236,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
 
     if [ "$branch" = "master-next" ]; then
         branch="next"
-	mkdir -p $outputdir/$branch
+        mkdir -p $outputdir/$branch
     elif [ "$branch" = "master" ]; then
         branch="dev"
         mkdir -p $outputdir/$branch
@@ -235,7 +249,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     elif [ "$branch" = "transition" ]; then
         branch=""
     else
-	mkdir -p $outputdir/$branch
+        mkdir -p $outputdir/$branch
     fi
 
     cp -r ./_build/final/* $outputdir/$branch

-- 
2.51.0


