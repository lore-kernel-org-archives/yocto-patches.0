Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13289D767D5
	for <webhook@archiver.kernel.org>; Thu, 31 Oct 2024 14:15:18 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.13517.1730384116275588437
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 31 Oct 2024 07:15:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EvhwgfLy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so8778155e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 31 Oct 2024 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730384114; x=1730988914; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDnjLsvMEW/+R5FRlozxBhBm55vKn2wVbN6PNF0uwv8=;
        b=EvhwgfLyr6i91t4IckSoc5woAQ3So+Tx3OVR3lKpVfm5pedHQrzzJ1XfCHSbgO0i4K
         R5gWo9puCH5byJiync1HoEy66pCY1uZ2C1XIhdaWxOXFf69o1xksqA3Nn8KW6w11ppVi
         tD5IJDX3LQ93bT0Llquts/KAIq+QucQibCJ/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384114; x=1730988914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDnjLsvMEW/+R5FRlozxBhBm55vKn2wVbN6PNF0uwv8=;
        b=MOrhyeRwajTvfquCZhgXZxmpsKcdTFsFrnrD2tw9XB9YuXoAMd/nlF8cDsaZmPie7e
         RZaE1FkPHMIYkJiNHGmxTbFUD8tq6ahzXlPRYtOVskMdul6kjo7AsVCpoMRUr96T0kmH
         8LUBBe3V/HyB2Vu/nDxqPNEn+IrvZqQ3fZcKUZP5iIaACV79fV8E4XdDVl/wBVIkTDBN
         E682ylCpNejk/tvb6nL4Yz83TpdIMwA4DxI3REYhfi6dnnJoS0DPP2AJW1I8T/jAo/4C
         OdSgiTkJFPaDi9tEE3xmEYJEwrlRwxJNo5qN9dN9sX4FLt/oxOK9KL5PD3yk8Wvi2C9d
         h1/A==
X-Gm-Message-State: AOJu0Yy18tcsK/1zm90F9tDV2479uFqsq5uf2wKffcZ2P2oKQTSat32b
	0UJo+bJQAjc5a8D023KCjSX5YKtov4WMe2huswWAeZC45buWad9Or3r1k19VvG45C/mJyqQ0Scj
	T1EY=
X-Google-Smtp-Source: AGHT+IE39NeWfdMGb0ux5zDImFAVcwMjbCZdi5WafGHKyLkIDn37qkFFom/KqbHcvhM8mS4IzkcetA==
X-Received: by 2002:a05:600c:4f04:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-4327b6f9574mr31547705e9.1.1730384114478;
        Thu, 31 Oct 2024 07:15:14 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3ee1:1135:b938:d59c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9180f2sm57248485e9.19.2024.10.31.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:15:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: docs@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 2/2] scripts/run-docs-build: Add support for multiple buildtools and add modified 5.1 option
Date: Thu, 31 Oct 2024 14:15:12 +0000
Message-ID: <20241031141512.544354-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031141512.544354-1-richard.purdie@linuxfoundation.org>
References: <20241031141512.544354-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 31 Oct 2024 14:15:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/780

Add a modified 5.1 buildtools tarball for docs builds which has support for svg -> png
conversion using rsvg-convert.

Older releases need older docs buildtools. Add support for this in the build
script for docs, installing both and choosing depending on how old the main
release branch is. For now I've put the changeover at scarthgap, it may be
possible to make it older. I know kirkstone fails with the new tools.

Bitbake doesn't need this since it's docs work fine with both versions.

The actual docs build is done in a subshell so we can choose the environment.
We may need to improve the selection logic in future since some branches may
start to build with the newer tools after backports.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-docs-build | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index bf1d261..9945d6b 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -25,22 +25,36 @@ outputdir=$builddir/output
 scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 PUBLISH=${PUBLISH:-1}
 sharedir=`jq -r '.["BASE_SHAREDDIR"]' < $HOME/config-local.json`
-buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
+# Modified 5.1 tools image to include rsvg, switch to next released version
+buildtools_url=${buildtools_url:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-5.1-modified.sh}
+buildtools_url_old=${buildtools_url_old:-https://downloads.yoctoproject.org/releases/yocto/yocto-4.1.2/buildtools/x86_64-buildtools-docs-nativesdk-standalone-4.1.2.sh}
 docbookarchive_url=${docbookarchive_url:-https://downloads.yoctoproject.org/mirror/docbook-mirror/docbook-archives-20201105.tar.xz}
 
+
 buildtools_name=`basename $buildtools_url`
 buildtools_localpath=${sharedir}/cluster-downloads-cache/${buildtools_name}
-
 if [ ! -e ${buildtools_localpath} ]; then
     mkdir -p `dirname ${buildtools_localpath}`
     wget ${buildtools_url} -O ${buildtools_localpath}
     chmod a+x ${buildtools_localpath}
 fi
-
 cd $builddir
 mkdir buildtools
 ${buildtools_localpath} -y -d $builddir/buildtools
-. $builddir/buildtools/environment-setup*
+
+
+buildtools_name_old=`basename $buildtools_url_old`
+buildtools_localpath_old=${sharedir}/cluster-downloads-cache/${buildtools_name_old}
+if [ ! -e ${buildtools_localpath_old} ]; then
+    mkdir -p `dirname ${buildtools_localpath_old}`
+    wget ${buildtools_url_old} -O ${buildtools_localpath_old}
+    chmod a+x ${buildtools_localpath_old}
+fi
+
+cd $builddir
+mkdir buildtools-old
+${buildtools_localpath_old} -y -d $builddir/buildtools-old
+
 
 # To build the latexpdf output we need Xetex (which can handle international characters)
 # Rather than require it on all autobuilder workers, along with dependencies, we install
@@ -99,8 +113,12 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
     git reset --hard
     git clean -ffdx
     git checkout origin/master releases.rst
-    make clean
-    SPHINXOPTS="-j auto" make publish
+
+    (
+        . $builddir/buildtools/environment-setup*
+        make clean
+        SPHINXOPTS="-j auto" make publish
+    )
 
     if [ "$branch" = "master-next" ]; then
         branch="next"
@@ -182,8 +200,16 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
         esac
     fi
 
-    make clean
-    SPHINXOPTS="-j auto" make publish
+    (
+        # Anything older than scarthgap needs the older buildtools
+        if git merge-base --is-ancestor 0cdc0afd3332459d30cfc8f4c2e62bdcc23f5ed5 HEAD; then
+            . $builddir/buildtools/environment-setup*
+        else
+            . $builddir/buildtools-old/environment-setup*
+        fi
+        make clean
+        SPHINXOPTS="-j auto" make publish
+    )
 
     # Strip yocto- from tag names
     branch=$(echo "$branch" | sed 's/yocto-//')

