Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5A6C982EE
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 00:46:02 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40009.1789951562298315532
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 20 Sep 2026 17:46:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Exubl2Bp;
 spf=pass (domain: konsulko.com, ip: 209.85.214.178, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so17228055ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 20 Sep 2026 17:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789951562; x=1790556362; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcEIENCTJwDG1FWVzGQzZW2aJBEQjteyoPolbkTQlpI=;
        b=Exubl2BpNMzjL4kvkMgNLbSCBR3MAJMBN/cRR1UKRfD3Jj6u/4CMyKakq6OAe/XNee
         RW+26YsggdPYTpnCz5nB8jH15SYa6w0ASQUGTjljlVnUWA+rgaPzM0u1l8xuOyzbz4U+
         NeKrXRLXFo1RwKieWnwTfJbqHkQGsGdUzm3fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951562; x=1790556362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CcEIENCTJwDG1FWVzGQzZW2aJBEQjteyoPolbkTQlpI=;
        b=MBOz/P1L0lPQhzSst+T72lcFEB0MOTc3RbMEx+nPjZ0bMJdnrZrNzSLhY1cPcwCVNP
         g2qJp5JL8YIJfHqTaV0aKb/ilwGKeWGsuuVHqZxBz9LGCMoMP9yOtelKK4O1qX7LXO0e
         oybu6riWnIxse6avfv8BcBJNgrFZ/nG6j07un4ony/uGjMwHpHRjt604ZCwAA7pQebr3
         TXqcTqndetYJwOjsLXkMbX+jqf1nJNZhZz5/LMrgjd1Cf13drlhQOSqInCRpGoYeHmeZ
         f2d4f5thLNLbiAHiIqSHJW8a6Y6bLfLFIwIn0d0cR4y/+KlYiebPToiys12yEbhYEnpM
         HZUw==
X-Gm-Message-State: AFuF++k2iLeqjPPN7Vd6eAG4YIlOA0w5voFgVkZXOFgA5hmLxQWEX/Lp
	8cCiIDYtRkLf1EE12Dg4LNkxs8XBdYo/A0a/uAIFmznfcMgH0bBakIE9DUvDDm2pdy+ijH4YWHr
	TxCMt
X-Gm-Gg: AYBFou3y+RK/gas/b5W14Gp38Tev3yZ7GOGLbfDHnBbQCYl6Z44ayhKPF7J2cBcZRN9
	Jv47arfYg/U60QEeaV07YZ/bOs18gxH17c3A2OxlPcgColGTnPbLwGtUzl62kbnmf4uy5lz6VBw
	zSvLoZ0fNl97FRlLZs4SF0AnvPSNG9+9067PY0Ohb3j8wb8Sqju50V7amfhEOEO0k7xeq+BxqGi
	YH4Jd5rmZIvtNeFagGmmeyURpffV0DTGe83DJM+ny5S8vw3hxBbuKxH+mlbhaGLhVXFlQBdgd3S
	YZ+PfDWSS5URrLxOnyrhlP+5IqQdnhknAqgDrbWXW+HGYFppCIZMwM57emsmgdzRFgD7yA++ygr
	woozCNhRxX83eqyT/d006sLK32pziriaLZCVebexAzMH4Nz1ard6k/Z9EovbZ2VQnSHUamT0HiM
	+pq+VdhUAa+rQd2QmZBb+5LNUmyCc7KMsjZcJQKQQKeMAJnGbU1lH3N0FshTHXgjNAYGaDB34n7
	kn7A+W/BfXVjA==
X-Received: by 2002:a17:902:868e:b0:2dd:ad7d:72e8 with SMTP id d9443c01a7336-2ddad7d74dbmr81010805ad.31.1789951561621;
        Sun, 20 Sep 2026 17:46:01 -0700 (PDT)
Received: from thetis.home.local ([2606:c800:6024:2000:7821:4c5:938a:e12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc1803813sm24512385ad.82.2026.09.20.17.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 17:46:01 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder-helper][PATCH 4/4] config.json: Keep the bitbake server warm for containers-library
Date: Sun, 20 Sep 2026 17:41:18 -0700
Message-ID: <20260921004540.3718904-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921004540.3718904-1-tim.orling@konsulko.com>
References: <20260921004540.3718904-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 00:46:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4917

From: Tim Orling <tim.orling@konsulko.com>

The push-containers step makes ~11 bitbake invocations per container.
Without BB_SERVER_TIMEOUT each starts its own cooker and reparses the
whole layer stack. Set it to 600, as buildperf and metrics already do.

AI-Generated: Claude Opus 5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 22fc16d..d4b2ec2 100644
--- a/config.json
+++ b/config.json
@@ -1890,7 +1890,8 @@
             "extravars" : [
                 "require conf/distro/include/meta-virt-host.conf",
                 "DISTRO_FEATURES:append = ' usrmerge'",
-                "INIT_MANAGER = 'systemd'"
+                "INIT_MANAGER = 'systemd'",
+                "BB_SERVER_TIMEOUT = '600'"
             ],
             "EXTRACMDS" : ["sed -i '/meta-virt-host.conf/d' ${HELPERBUILDDIR}/conf/auto.conf"],
             "vcontainer" : "${VCONTAINER_TARBALL_URL}",
-- 
2.47.3


