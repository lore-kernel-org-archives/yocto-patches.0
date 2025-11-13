Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89193CD6E73
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23130.1763038637349137306
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=fdOtDEhP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-2025111312571417741533aa0002071e-7ggf8i@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025111312571417741533aa0002071e
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=L1QMOXlA4qywhtBkp0BH/ThU2AK2noqA9TnN9iEN+PU=;
 b=fdOtDEhPfVZZv5ybK1SgBwzGR10v/UT/Jb5CsMf/y69Ts+g/KAmJ0ehLfHdcKJjzt38UfD
 TlTmvBCfAMJCqoHg7jHhHbFAkWkmAhDK/RQLkkEMrHhKIJsoaKGg6bZU9OCvHBEY/fThWz9D
 MYcgXbreX90gmWf9LvH65yHtNwyY+Jw9xsiL3eu0lHdQ3EoBEyQJNWal/7l/dEciU1AXpFHW
 8dVXe8EoSMts7AfaFLgWyE8ODodw8DQWZYhdtB+qjzwUFFrkqpjhLIskck9ScmRHjfgwUxlo
 4XDVn3qWPz9rXLhyCoEooWgdmtKeOHXO+RGXeapgMKr0XhTOgVShGu0g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 01/34] Initial commit: add license, readme and layer config
Date: Thu, 13 Nov 2025 13:56:39 +0100
Message-Id: <20251113125712.18914-2-peter.marko@siemens.com>
In-Reply-To: <20251113125712.18914-1-peter.marko@siemens.com>
References: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2524

This is a copy of these files from kirkstone/go branch modified for
scarthgap release.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 COPYING.MIT     | 17 +++++++++++++++++
 README          | 15 +++++++++++++++
 conf/layer.conf | 15 +++++++++++++++
 3 files changed, 47 insertions(+)
 create mode 100644 COPYING.MIT
 create mode 100644 README
 create mode 100644 conf/layer.conf

diff --git a/COPYING.MIT b/COPYING.MIT
new file mode 100644
index 0000000..fb950dc
--- /dev/null
+++ b/COPYING.MIT
@@ -0,0 +1,17 @@
+Permission is hereby granted, free of charge, to any person obtaining a copy 
+of this software and associated documentation files (the "Software"), to deal 
+in the Software without restriction, including without limitation the rights 
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
+copies of the Software, and to permit persons to whom the Software is 
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in 
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
+THE SOFTWARE.
diff --git a/README b/README
new file mode 100644
index 0000000..9e270f2
--- /dev/null
+++ b/README
@@ -0,0 +1,15 @@
+"Mixin" layer for adding latest Go toolchain versions into the Yocto Project LTS.
+
+At the time Kirkstone was released in April 2024, Go 1.22 was the latest version
+and officially Kirkstone supports only that. This thin special-purpose mixin
+layer is meant to address this issue by backporting Go recipes from the master
+branch of openembedded-core.
+
+The patches can be backport from openembedded-core with:
+
+ git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-devtools/go | \
+ git am --signoff -p4 --directory=recipes-devtools/go
+
+Maintainers:
+Jose Quaresma <jose.quaresma@foundries.io>
+Peter Marko <peter.marko@siemens.com>
diff --git a/conf/layer.conf b/conf/layer.conf
new file mode 100644
index 0000000..41bc938
--- /dev/null
+++ b/conf/layer.conf
@@ -0,0 +1,15 @@
+# We have a conf and classes directory, append to BBPATH
+BBPATH .= ":${LAYERDIR}"
+
+# We have a recipes directory, add to BBFILES
+BBFILES += "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/recipes*/*/*.bbappend"
+
+BBFILE_COLLECTIONS += "lts-go-mixin"
+BBFILE_PATTERN_lts-go-mixin := "^${LAYERDIR}/"
+BBFILE_PRIORITY_lts-go-mixin = "6"
+
+LAYERSERIES_COMPAT_lts-go-mixin = "scarthgap"
+
+LAYERDEPENDS_lts-go-mixin = " \
+    core \
+"

