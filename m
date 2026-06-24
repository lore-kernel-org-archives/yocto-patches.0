Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0CCDB481
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 14:24:49 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8496.1782311087063160060
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 07:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=VmqbsgN1;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4924593f45dso12579085e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1782311085; x=1782915885; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UTQH7S/fcQvyRcUj467tczNowsvu7gggnFFxFA0fpY=;
        b=VmqbsgN1LGmS+T3hyXybjFGo+/WSa+bS65MsFhxwqkpwtdRcBBgUukDvlbUlQzCm68
         tjaMUYqnSDkZk7Il1+ntqMn1Cy7rtNWnAgWjcHhLM180cFR9kVH/0MlrWkfoGNRLFNiX
         8uAiIUyRiLjj+l2NqFZuO0LSK322MU5CsPE18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311085; x=1782915885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UTQH7S/fcQvyRcUj467tczNowsvu7gggnFFxFA0fpY=;
        b=ZV2QjvsUoN9PI5XCAeYfK9PxL8iV1cUiCgRlSuAbzN9XcInxGgv+PKwEQKZYXdiYpE
         i3COuCUsds1p5tZYQfWQ2pgekimS2kDmvzX7CQUtYAvb+P+r2TKCPishcLZf8RuASb+6
         XJ9hjcebxBf6Jt5lAIW6+BO2FA8aBrQK859eg8wD1xLF/x6luBGbEykfAIkYHSqTuEeQ
         ZsGGKDb7aBQ23tXiVPc5JRC61X2N1xFCOmIgrCrU4QXxw++2QmLowunGCoLGTqsQsbfY
         yHA6c68HMgQasq+WSmcDd/tjDAG922KxgILjcsTQpQcC65/p4Czcz3TZWpKn9A/4IuOs
         LQqg==
X-Gm-Message-State: AOJu0YyCXxvDD5KqpBaNTrKZUdpF4msN6hjQGUbY1eFIfrUlVdOHfok3
	RG+Ae9xMCT8DlTxGOPWtENYvIIGZ9KHPuq/nROKrGYWUHaZhfTjDRs0kG12rFOKWHEhjJnpOIGl
	QrzSI
X-Gm-Gg: AfdE7cn/mqDPEogTX5JWRuz+JVTs79BnwAlV2VzPJaLfVYmbCVzjUWwmigmmm7JGdHm
	WRETpswPpz6fmDB6f8GnmJkJT8h1IuKZOgNBhfx371w7VuJxOvcsI4I8oeQd52pSnWE9jezoO0h
	JKThVl73XkOs1VONR61+XRdKmFJmh46rK4CH6oI9E9/WQzW7enyqKmZEfXsD4aBSLX3V4vdrgFI
	Kpdoz4cHhKate21P4OpmZno+u7K6Z1IIJ+h+WrnjXbNk/qtvCpRTDbwl5TRFjjB52/RTLZwfKJn
	sMqAkJnliYEiLygNDppn05t3uN22wNfbwPc7rX+h2yAp1rzupMz5skOtA9yqMVmDvU5Wxrf+ZBT
	rbAIzLUsLCt4V2kUKrjWf3aQviu+HLNMYlcNE0EfV0VY8ZpkAlWRSQPClhFexUYA+DAVUVIK30U
	gX+pxBahdh9dMhCZRCFS3x6gUmrKVAjjxST85oAu0Z5HOFwddYsP/GU+u7eELzvILdRDkAOLPAB
	6fLJmMr2IwSC+vwJg==
X-Received: by 2002:a05:600c:c4a2:b0:492:604b:c77b with SMTP id 5b1f17b1804b1-49260875ae9mr48882585e9.26.1782311084869;
        Wed, 24 Jun 2026 07:24:44 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00f2ebd4aef93feb0a.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f2eb:d4ae:f93f:eb0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm491570955e9.14.2026.06.24.07.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:24:44 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Paul Barker <paul@pbarker.dev>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [yocto-autobuilder-helper][scarthgap][PATCH] config.json: Use buildtools on RHEL9 derivatives
Date: Wed, 24 Jun 2026 16:24:29 +0200
Message-ID: <20260624142429.1628429-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 14:24:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4296

From: Paul Barker <paul@pbarker.dev>

tar 1.34 (and possibly earlier versions) is unable to extract tarballs
containing read-only files with xattrs. This was fixed upstream, but
it's unlikely at this point that the fix will be backported to RHEL9
related distros (CentOS Stream 9, AlmaLinux 9, Rocky Linux 9). The issue
affects these distros specifically because they have selinux enabled by
default and this uses xattrs.

The specific failure we've seen is with the /usr/lib/udev/hwdb.bin file
installed by the systemd recipe - this file is chmod 0444. This leads to
the following error, typically during do_image_wic (shortened and split
to make it readable):

    subprocess.CalledProcessError: Command
    'tar --xattrs --xattrs-include='*' -cf - -S -C .../tmp/work/qemux86_64-poky-linux/core-image-minimal/1.0/rootfs -p . |
    tar --xattrs --xattrs-include='*' -xf - -C .../tmp/work/qemux86_64-poky-linux/core-image-minimal/1.0/tmp-wic/rootfs2'
    returned non-zero exit status 2.

To work around this, we will need to use the buildtools tarball on
affected systems.

Fixes [YOCTO #16143].

Signed-off-by: Paul Barker <paul@pbarker.dev>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ae74094f8aeae21dcc2510cd0d854b70cfe2192f)
[YC: Also, by upgrading python3, this patch fixes:
| ERROR: Unable to parse /srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oe/data.py
| Traceback (most recent call last):
|   File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oe/data.py", line 8, in <module>
|     import oe.maketype
|   File "<frozen importlib._bootstrap>", line 1004, in _find_and_load
|   File "<frozen importlib._bootstrap>", line 158, in __enter__
|   File "<frozen importlib._bootstrap>", line 110, in acquire
| KeyError: 140127001167424
From https://autobuilder.yoctoproject.org/valkyrie/?#/builders/40/builds/3981
See upstream issue: https://github.com/python/cpython/issues/91351]
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.json b/config.json
index 86a6ada..64c7495 100644
--- a/config.json
+++ b/config.json
@@ -1932,6 +1932,9 @@
         "alma8*"       : "${BUILDTOOLS_URL}",
         "rocky8*"      : "${BUILDTOOLS_URL}",
         "stream8*"     : "${BUILDTOOLS_URL}",
+        "alma9*"       : "${BUILDTOOLS_URL}",
+        "rocky9*"      : "${BUILDTOOLS_URL}",
+        "stream9*"     : "${BUILDTOOLS_URL}",
         "opensuse154*" : "${BUILDTOOLS_URL}",
         "opensuse155*" : "${BUILDTOOLS_URL}",
         "perf-alma8*"  : "${BUILDTOOLS_URL}",

