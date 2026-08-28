Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63AC61DB9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 11:39:12 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4382.1787917146219804457
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Aug 2026 04:39:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=R3C+q9sM;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8816D4E413D5
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E00160537
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93E5E11C78212;
	Fri, 28 Aug 2026 13:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787917140; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oGYS7JED7xiAhT9gqbd1XZIo/qR2q1UC8KbuH6Dz3ek=;
	b=R3C+q9sM4/Q4lbWNjGnFlHC5Z4JP3BDF8M+IayP1hBo6nJptNk01ei+tgzshmpZtw0iqDX
	SxiLAGlpsmCLmp/124iy3i4kMw4BczQsXGtIiICrO0P8gMXKKR2XlzSLdUrPSSoyRDvEyQ
	hMxTKISPVQIW40LnZV9WD2JiJdvq4gy2ZmsHW4xGsiDBfi/FXZBc6JSn7g2vOHhyojEPUI
	sZNDgyX04z2OLPdTsjUvSNqKxgfFmjpBHMhGBH3t012i7QqDLVkvYcThgPHe8EKYtu5+96
	oXRNr4odfiy8HjzdI8RQ88WL34omac3JH8dL5Kyhgk3DtwYUG1WZt8PQMC996Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 28 Aug 2026 13:38:36 +0200
Subject: [yocto-autobuilder-helper][PATCH 3/4] scripts/run-docs-build: fix
 shellcheck issues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-run-docs-build-tweaks-v1-3-24a7c832e352@bootlin.com>
References: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
In-Reply-To: <20260828-run-docs-build-tweaks-v1-0-24a7c832e352@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9683;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=bxBHFShyweEEbB5hjSGhHsIfICZEHK9IX3mWo/kbexY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqkXNEOvoOd2yZzAtyxE+Un8Zix2I98+pFrLe6R
 12dmG3i2R+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCapFzRAAKCRDRgEFAKaOo
 NtDID/9GebncWWA/9Le9b6UztC6LEj52CDJl3h7v6xSKbnEBivJM4/LoQBHrgp/U1U08cndL9IL
 Bie3r2vLi32HlmDcOZtV+4+lpCXziHRysqf5eorlojmrLgSI3FyefwcrnuqImZJM7dmaKIMuwFs
 ylcjZ8697w0w2D/PhZTHFllrOtqZWpKfHXKDa3jugV4XDne6JG7S5BRKlNhXg0L1KuVaunKqWJF
 et0tfHstd70dzrDUSbRDCWNvhCt4Zl/OebfjPnUihAkhqEXatwWSI6olCKhOktgyaQGAQ12zx2n
 uUYvxvpabRRm36tQoKdCLmzyKDHF0JcBG6as0wfkKH7z1xOUz/lS5RYdS8Mzm0FOJFfOYN+aF8F
 XM4cFGBd28EePbV3qFm++DR/Cib/zOrG/jzSYOwu/MLwqZJMz6Fuoj3hj02zfUAYQSWdfTegQMJ
 6hDUwAQdX/wAjdJkyUhhxZj8MmM3XFnpogjXwHSAAqc1mpq+UEjJkQ6G/KkrjF2PzDW+uO57YAw
 WhfF5R9fuslyIExT/trakWASCbBlE+w2NY+njMk05goakY80rw2bh4M7O85DpkcfBMmsQOKJ09P
 6sNEICHUIGPMI8i+vIokNxnoL4iBl/jRHi2By6aoA4GacmUa4OVXLiLPZUBRiyY4/JIYsoFl0Ow
 T2v6iSi+6hhISDw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Aug 2026 11:39:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4717

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 107 +++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 344acbf..274ad20 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -12,6 +12,9 @@
 #   - docbookarchive_url as the path to old (pre 3.1.5 and Sphinx migration) docs tarball
 #                     Can be found here: https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz
 #   - PUBLISH (0/1) for whether the files should be rsync'ed to docs.yoctoproject.org
+#
+# We source multiple external files here, ignore this warning.
+# shellcheck disable=SC1090
 
 set -e
 set -u
@@ -24,36 +27,36 @@ bbdocs=$(realpath "$3/doc/")
 outputdir=$builddir/output
 scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 PUBLISH=${PUBLISH:-1}
-sharedir=`jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json`
+sharedir="$(jq -r '.["BASE_SHAREDDIR"]' < "$HOME"/config-local.json)"
 # Modified 5.1 tools image to include rsvg, switch to next released version
 buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-6.0_M2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.3.99%2Bsnapshot-be8cdcf13a658e9e81ff2f7b71d1c8c37a920ce7.sh}
 buildtools_url_old=${buildtools_url_old:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
 docbookarchive_url=${docbookarchive_url:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
 
 
-buildtools_name=`basename $buildtools_url`
+buildtools_name="$(basename "$buildtools_url")"
 buildtools_localpath=${sharedir}/cluster-downloads-cache/${buildtools_name}
-if [ ! -e ${buildtools_localpath} ]; then
-    mkdir -p `dirname ${buildtools_localpath}`
-    wget ${buildtools_url} -O ${buildtools_localpath}
-    chmod a+x ${buildtools_localpath}
+if [ ! -e "${buildtools_localpath}" ]; then
+    mkdir -p "$(dirname "${buildtools_localpath}")"
+    wget "${buildtools_url}" -O "${buildtools_localpath}"
+    chmod a+x "${buildtools_localpath}"
 fi
-cd $builddir
+cd "$builddir"
 mkdir buildtools
-${buildtools_localpath} -y -d $builddir/buildtools
+${buildtools_localpath} -y -d "$builddir"/buildtools
 
 
-buildtools_name_old=`basename $buildtools_url_old`
+buildtools_name_old="$(basename "$buildtools_url_old")"
 buildtools_localpath_old=${sharedir}/cluster-downloads-cache/${buildtools_name_old}
-if [ ! -e ${buildtools_localpath_old} ]; then
-    mkdir -p `dirname ${buildtools_localpath_old}`
-    wget ${buildtools_url_old} -O ${buildtools_localpath_old}
-    chmod a+x ${buildtools_localpath_old}
+if [ ! -e "${buildtools_localpath_old}" ]; then
+    mkdir -p "$(dirname "${buildtools_localpath_old}")"
+    wget "${buildtools_url_old}" -O "${buildtools_localpath_old}"
+    chmod a+x "${buildtools_localpath_old}"
 fi
 
-cd $builddir
+cd "$builddir"
 mkdir buildtools-old
-${buildtools_localpath_old} -y -d $builddir/buildtools-old
+${buildtools_localpath_old} -y -d "$builddir"/buildtools-old
 
 
 # To build the latexpdf output we need Xetex (which can handle international characters)
@@ -84,25 +87,25 @@ fi
 export FONTCONFIG_PATH="$scriptdir/docsfontconfig"
 
 # Getting the old docbook built docs from an archive. Not rebuilding them.
-docbookarchive_localpath=${sharedir}/cluster-downloads-cache/`basename ${docbookarchive_url}`
-if [ ! -e ${docbookarchive_localpath} ]; then
-    mkdir -p `dirname ${docbookarchive_localpath}`
-    wget ${docbookarchive_url} -O ${docbookarchive_localpath}
+docbookarchive_localpath="${sharedir}/cluster-downloads-cache/$(basename "${docbookarchive_url}")"
+if [ ! -e "${docbookarchive_localpath}" ]; then
+    mkdir -p "$(dirname "${docbookarchive_localpath}")"
+    wget "${docbookarchive_url}" -O "${docbookarchive_localpath}"
 fi
 
-mkdir $outputdir
-cd $outputdir
+mkdir "$outputdir"
+cd "$outputdir"
 echo Extracting old content from archive
-tar --exclude=eclipse -xJf ${docbookarchive_localpath}
+tar --exclude=eclipse -xJf "${docbookarchive_localpath}"
 
-$scriptdir/docs_add_banner.py
+"$scriptdir"/docs_add_banner.py
 
 # generate the releases.json in PWD
-$scriptdir/release-parser.py "$ypdocs/.." "$bbdocs/.."
+"$scriptdir"/release-parser.py "$ypdocs/.." "$bbdocs/.."
 cp releases.json "$builddir"
 
-cd $bbdocs
-mkdir $outputdir/bitbake
+cd "$bbdocs"
+mkdir "$outputdir"/bitbake
 
 # A decision was made to keep updating all the Sphinx generated docs for the moment,
 # even the ones corresponding to no longer supported releases
@@ -123,20 +126,20 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
         continue
     fi
 
-    echo Building bitbake $branch branch
-    git checkout $branch
+    echo "Building bitbake $branch branch"
+    git checkout "$branch"
     git reset --hard
     git clean -ffdx
 
     if [ -e "${scriptdir}/docs-build-patches/bitbake/${branch}" ]; then
-        echo Adding patch for $branch
+        echo "Adding patch for $branch"
         git am -3 "${scriptdir}/docs-build-patches/bitbake/${branch}/"000*
     fi
 
     git checkout origin/master sphinx-static/switchers.js.in setversions.py
 
     (
-        . $builddir/buildtools/environment-setup*
+        . "$builddir"/buildtools/environment-setup*
         make clean
         cp "$builddir"/releases.json "$bbdocs"/
         SPHINXOPTS="-j auto" make publish
@@ -144,19 +147,19 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
 
     if [ "$branch" = "master-next" ]; then
         branch="next"
-        mkdir $outputdir/bitbake/$branch
+        mkdir "$outputdir/bitbake/$branch"
     elif [ "$branch" = "master" ]; then
         branch="dev"
-        mkdir $outputdir/bitbake/$branch
+        mkdir "$outputdir/bitbake/$branch"
     elif [ "$branch" = "$latest_branch" ]; then
         branch=""
-        mkdir $outputdir/bitbake/$latest_branch
-        cp -r ./_build/final/* $outputdir/bitbake/$latest_branch
+        mkdir "$outputdir/bitbake/$latest_branch"
+        cp -r ./_build/final/* "$outputdir/bitbake/$latest_branch"
     else
-        mkdir $outputdir/bitbake/$branch
+        mkdir "$outputdir/bitbake/$branch"
     fi
 
-    cp -r ./_build/final/* $outputdir/bitbake/$branch
+    cp -r ./_build/final/* "$outputdir/bitbake/$branch"
     git reset --hard
     git clean -ffdx
 done
@@ -164,11 +167,11 @@ done
 if [ "$PUBLISH" -ne 0 ]; then
     # only sync bitbake folder for now. We need bitbake to be published first
     # since the bitbake intersphinx index will be downloaded to build yocto-docs
-    cd $outputdir
+    cd "$outputdir"
     rsync -irlp --checksum --ignore-times --delete bitbake docs@docs.yoctoproject.org:docs/
 fi
 
-cd $ypdocs
+cd "$ypdocs"
 
 # transition must build after master for the switchers.js file
 # Again, keeping even the no longer supported releases (see above comment)
@@ -206,13 +209,13 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
         continue
     fi
 
-    echo Building $branch
-    git checkout $branch
+    echo "Building $branch"
+    git checkout "$branch"
     git reset --hard
     git clean -ffdx
 
     if [ -e "${scriptdir}/docs-build-patches/${branch}/" ]; then
-        echo Adding patch for $branch
+        echo "Adding patch for $branch"
         git apply -3 "${scriptdir}/docs-build-patches/${branch}/"000*
     fi
 
@@ -227,9 +230,9 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
     (
         # Anything older than scarthgap needs the older buildtools
         if git merge-base --is-ancestor 0cdc0afd3332459d30cfc8f4c2e62bdcc23f5ed5 HEAD; then
-            . $builddir/buildtools/environment-setup*
+            . "$builddir"/buildtools/environment-setup*
         else
-            . $builddir/buildtools-old/environment-setup*
+            . "$builddir"/buildtools-old/environment-setup*
         fi
         make clean
 
@@ -244,28 +247,28 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
 
     if [ "$branch" = "master-next" ]; then
         branch="next"
-        mkdir -p $outputdir/$branch
+        mkdir -p "$outputdir/$branch"
     elif [ "$branch" = "master" ]; then
         branch="dev"
-        mkdir -p $outputdir/$branch
+        mkdir -p "$outputdir/$branch"
     elif [ "$branch" = "$latest_tag" ]; then
         branch=""
-        mkdir -p $outputdir/$latest_tag
-        cp -r ./_build/final/* $outputdir/$latest_tag
-        echo Linking to $latest_tag as current
-        ln -s $latest_tag $outputdir/current
+        mkdir -p "$outputdir/$latest_tag"
+        cp -r ./_build/final/* "$outputdir/$latest_tag"
+        echo "Linking to $latest_tag as current"
+        ln -s "$latest_tag" "$outputdir"/current
     elif [ "$branch" = "transition" ]; then
         branch=""
     else
-        mkdir -p $outputdir/$branch
+        mkdir -p "$outputdir/$branch"
     fi
 
-    cp -r ./_build/final/* $outputdir/$branch
+    cp -r ./_build/final/* "$outputdir/$branch"
     git reset --hard
     git clean -ffdx
 done
 
 if [ "$PUBLISH" -ne 0 ]; then
-    cd $outputdir
+    cd "$outputdir"
     rsync -irlp --checksum --ignore-times --delete . docs@docs.yoctoproject.org:docs/
 fi

-- 
2.55.0


