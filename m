Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90DC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:55:50 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.12291.1740668146879018756
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Feb 2025 06:55:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lmUmmKqU;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e88983cedaso8073036d6.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Feb 2025 06:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740668145; x=1741272945; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6BykoYN5FF1mm4qYUmbhj5pwrqLx9/pxE+QA6Qc1XE=;
        b=lmUmmKqUP10J5UrlrwSaeJ9OhtilBkbaqFt4wY2xDbJTWhbW7/g+Jg8ouRXDUIGMYC
         P+i5QFj8OB0ajwBW0Ky/B2LwSS3Dx+buLgS3JEfneTq/yYtNEAzLmoFZPUPNeKmVcivw
         J1+YIlrAit7J/dKvijMRO9Codp+v0/xIMEL+oxTn3h7vXgsPLvFmNzcBkav9h8xnv7mg
         wWE0JHHZGWPqTGO75tk6vHamE+/50i5jQ5N6FgNUuZlhBi9kGxg68S09UW+p+3WhVhyW
         U/hg45+q96fvU1zELty4VZLSDu0twTQQc3UihqDp1bWFk6ybgMt/c++jFa/bAS6N8VVj
         YCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668145; x=1741272945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6BykoYN5FF1mm4qYUmbhj5pwrqLx9/pxE+QA6Qc1XE=;
        b=V5/urkm9isSdNyuQuOJlFd6cvlUQDQMf0ESgC8fAPKLvyUTMNNb28iebykP/DQ/gQQ
         2NHkFQV4mNC/G6VFcUxYc/ZNlNGxc3pfmkJ6ImU8HFQT/WZLkmggEufEXOcY2iFHg+Kt
         h3dnIwZhu9l7n2u6I1DUkS8vhizdXQkyeD8YhG1XPvKmh7ozPp1KIXZNcpefLP7BEZgl
         PPztIM4S/T8dPQLmjhNVE8KiqDjM7D9bFOrrimqK3p4C6KwtrAPfbo2ASHUNmsUntMKt
         jf9jNECGa7bRbcnNdGgPs5sY8LdjVEcU3lGgMqStlpLDiJ3xdcTlWXn5Yt9+zMYGHR+x
         bT0g==
X-Gm-Message-State: AOJu0YwJzI34GkggNm6VH+K5imREDqMjfYVLQc0kPzYrIK0CwQkJcEDR
	LwHUqY2VsxQRp4iB+f+P8LtUF2V2X7xQ9BTNPL8jn3L5IeOmkp0iI3cF2Q==
X-Gm-Gg: ASbGnct7oLCcemEnh+LhIERvkSS3aJZOyWALVJBiPrlf9LwCBo1DDwfMl/c7IbEqmsB
	DL7aG6coF4VfCSaHQz46bfWm5UtVpiiZ4JxjaTZBumV1uNU4DrMJnJWsoXHlzMQYkRTEuogE1M+
	e/Pv+iqXz1K5OLKGt2h30nDKULVGjVX7hbmhQzGJVHgJBwK2JmC1n9WMmPsj2z37H9KKWgvasKS
	ux6oe7Px6RfSGazquT42U1FQAKIH3CBvG1U9eSPPdfII+n2gdrYNx03cw/ueVS4UWj6hejRKDrs
	Eu/wKKD1SRTtTLFTxBxSdXWWwfVyA8QnocVgshEIitfYN3mSWcFnBc79J2OpAnSoeEN3HQ==
X-Google-Smtp-Source: AGHT+IFKL4/CPKnbj/hpFqEO2ylxzIjfYKoPGdVQjpextdY4icSyxzdoeaIEJFGcGbX6E6msCXzHfw==
X-Received: by 2002:a05:6214:1c0d:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6e6b002fb10mr336748136d6.4.1740668145186;
        Thu, 27 Feb 2025 06:55:45 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976538e3sm10492486d6.34.2025.02.27.06.55.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:55:44 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] rauc-conf: set arch to machine
Date: Thu, 27 Feb 2025 09:55:29 -0500
Message-ID: <20250227145529.8651-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Feb 2025 14:55:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1135

Since this bbappend is modifying the rauc config file with a MACHINE-specific
search-and-replace, the architecture setting of the package needs to be
MACHINE-specific as well. Otherwise if multiple images are built for the same
SoC, the sstate mechanism will use the first-built SoC copy of the
rauc/system.conf file, which may or may not match this device's MACHINE
setting.

At runtime this leads to compatible mismatch issues:

	# rauc install <bundle>
	...
	LastError: Compatible mismatch: Expected 'nanopi-r2s' but bundle manifest has 'rock-pi-e'

These errors can be worked around by using the "--ignore-compatible" cmdline
switch to the "rauc install" command. Or can be fixed by updating the
on-device /etc/rauc/system.conf file and restarting the rauc.service systemd
service unit. This patch, however, is the more correct, build-time, fix,
rather than having to fix the issue at run-time.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend           | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
index 281eb2c4de91..e19db234b9b5 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
@@ -1,5 +1,7 @@
 inherit rk-rauc-demo-features-check
 
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
 FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
 
 do_install:prepend:rk-rauc-demo() {
-- 
2.44.0.501.g19981daefd7c


