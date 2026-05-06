Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B14CD343B
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:21:53 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22870.1778084510893111669
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:21:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fpuEyxyo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso3621576f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778084509; x=1778689309; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnsixsCXcakjCak1KYHiceN3SZiPYVWaIBl8iRsmJ3A=;
        b=fpuEyxyoo7/11WNmki8/XnPEdi9Zw7AwQmjzUm1K9MNHTzCejvfhxdXcXzZ+OGLqFf
         WMabdJhdMi139yleDH79a+m3fMgnuCOsbwQ5ece0FRbu6z0c7zL5Hn5sd7hGyKkl3/6k
         f1d688NqE2bSiRPb85lI1oWYGP3Zg/5yZgRAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084509; x=1778689309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZnsixsCXcakjCak1KYHiceN3SZiPYVWaIBl8iRsmJ3A=;
        b=IGPnQ2xvMpGYdYD88svnXfiF5by1Z8pwMde0kjYjIFu6U7PI9t6lRmt7gJeeC+kJgT
         KFuQmFIdzYqFG/S0EY/4GS5c0mJdZmgOusOm2wwVntSpXAiMeBthgdVfgwcog9kaw+zq
         xy4TRAtKL0nHnuGJY34/DP3NtlIW0rTvgC44f9n7LxZg6QhzIAdCn4K5P/5l2Uutf5Kt
         pl6GGuqiL+3vUIa8FPecuJfCM1LxoNiGzeuG8wRVPhccNT6H0/5QNHDWare+n1gAWk94
         cr6mjz2rRgJYnd0981w8TMOPOp2PP3D9cWrJbk+6chA0JG9SOLHwUFz7IebVZiUWcFcf
         d7Yw==
X-Gm-Message-State: AOJu0YxfzTTbi4uXtMKU+8H9AMFkriWlDLEEwFJz0OW9GfWV9J+u527Q
	aS8IzEJrOJvmoH3ZMEKjw4KTuj/UxCrpmmtzMXQP72brdL3B3koTTXCM4hQOVzDj0a2ED/lqybU
	x/nei
X-Gm-Gg: AeBDiescR+wbHh6i4Kz2SF4SRyd8sz7oyMXn7ivIjNwKblsLahXlbp9VUDHXSrxslJy
	282UOm1W4aW5+Opwigu8escM8ZWVvNld8dBlUaV86g2GGKZWMnN2CvXBI5fFSvsB+213yFoDc2T
	YHulEWOCWOrgSLGDOA4Q9BEWSEx1JTSwabnLOxpisSQPakuw17s2U/hSD6Kce8tkLcpwbV80lv2
	Y1K9Oxa4NEuXO8y+uaTGgknWFm1zdW+/tTUXjo1PBT+yiqjZQqv3PR3Qg7YgOP71439+eFk5zhI
	VmczekeCFRwRIbfVCYJrLrVKJHYcJrBYfdD1S2OgA76UMu5jHc7ju8hBpbGR0rPuebF7kXWLjuE
	whyRHEGReZz6jRh6NJfhfZfYvpJ3NoPXjoeYCZNqmlUlz+fi/IZkhCKKYbHxI3G2eHLcenfnx10
	+vN7YxZI7grsUUGXS1KCfn6GTmP8bvla1UtBPssqFB2fYexagy18LffMMvIhLLC2s=
X-Received: by 2002:a05:6000:2586:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-4515b61bcc3mr7022058f8f.14.1778084508891;
        Wed, 06 May 2026 09:21:48 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm14318822f8f.27.2026.05.06.09.21.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:21:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 6/6] publish-artefacts: Drop obsolete qemu machines from releases (mips/ppc)
Date: Wed,  6 May 2026 17:21:37 +0100
Message-ID: <20260506162137.4180049-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
References: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:21:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3927

Drop machines we no longer have as primary supported archiectures from our release
artefacts script.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index bcfc97b..10adde5 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -81,31 +81,6 @@ case "$target" in
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/beaglebone-yocto/*u-boot* $DEST/machines/beaglebone-yocto-alt
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/beaglebone-yocto/*beaglebone-yocto* $DEST/machines/beaglebone-yocto-alt
         ;;
-    "qemumips64")
-        mkdir -p $DEST/machines/qemu/qemumips64
-        sha256sums $TMPDIR/deploy/images/qemumips64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemumips64/*qemumips64* $DEST/machines/qemu/qemumips64
-        ;;
-    "qemumips")
-        mkdir -p $DEST/machines/qemu/qemumips
-        sha256sums $TMPDIR/deploy/images/qemumips
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemumips/*qemumips* $DEST/machines/qemu/qemumips
-        ;;
-    "qemumips-alt")
-        mkdir -p $DEST/machines/qemu/qemumips-alt
-        sha256sums $TMPDIR/deploy/images/qemumips
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemumips/*qemumips* $DEST/machines/qemu/qemumips-alt
-        ;;
-    "qemuppc")
-        mkdir -p $DEST/machines/qemu/qemuppc
-        sha256sums $TMPDIR/deploy/images/qemuppc
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemuppc/*qemuppc* $DEST/machines/qemu/qemuppc
-        ;;
-    "qemuppc-alt")
-        mkdir -p $DEST/machines/qemu/qemuppc-alt
-        sha256sums $TMPDIR/deploy/images/qemuppc
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemuppc/*qemuppc* $DEST/machines/qemu/qemuppc-alt
-        ;;
     "qemux86-64")
         mkdir -p $DEST/machines/qemu/qemux86-64
         sha256sums $TMPDIR/deploy/images/qemux86-64

