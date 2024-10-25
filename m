Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8749BD0C5E6
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:23:06 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.7401.1729844577702748101
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZRRm32iz;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d432f9f5aso114145f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844576; x=1730449376; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgtlTAmnZRtvp4WNHffm0Nog7RLEQvl16WAMsVBqhe8=;
        b=ZRRm32izdECo9NIEhq2d2ugPPnlt1Rcst8yKzJ+WhRvb0TJ87o/tcl2zfsjXxSDKX6
         o6lsYOsrN+KaEO7r9coUzxOIyHWele+ALS1FfaRASuGwJaxElXzZeG+oCfCY1cEO+VJp
         pugg8LBjYS527xcnMz5v5F+aiDlMFDhBGurF20/Hn9BJ0MQUbrXB4Ol495s2C6kyEuCQ
         ntBGMAyzgh1r2hhZExzzTbyOjeMrGRCzK8touKPgEe9OOLz4Tz8P9MVJYtqay5bubHcw
         JXJnnwboGREQd8nCBDH/jFC0jZmY/0oYoOXv1uwPygl4xo1h7byucJT9YiyFHE5sA3HP
         8/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844576; x=1730449376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BgtlTAmnZRtvp4WNHffm0Nog7RLEQvl16WAMsVBqhe8=;
        b=UaENWoM/uauvTk4Xw+iDfmuyJmq/djTDaiTlRY9kJrg+dRFzGlnELsiWvYZ9PyW8Lw
         BNQmvWGZhayI5bVFrgdEvsJPsiesVBqDTMi+b/awf0hIqPYgxHjBWFvxal7VqJj+53Hb
         jtZ9v/n9LNjR/HNUI1XMJsdZv1PXMTVnwYKmHw5m9qppIo5RLkm/I+1ZBNw0R8RkMZ3Z
         YIYuzXBHPO/iIttb4UapC/s4mZ65rABhnv7F3nvJ/hxlN2b85VxFClEkuKrOAvGOeqIv
         MRPjZfIT4EZZL0pdYgQokt7z/Gv7lCKMPyTyGXuU8NTkkKkpEH3Z1MqLfYowXdct0UGl
         KZrQ==
X-Gm-Message-State: AOJu0YxUoAT95XGGRgjqBFq00nEV0Sy6ZwAmwocJiv0CWto9XeviQgFu
	798bdXogazJwtjrsdTZvb1/seQzx9BSv/uEoiUBhXyMEHxxsxbKnUuJCtU9c
X-Google-Smtp-Source: AGHT+IE1J6xY8+ZUbOseYW4r8qXGLWXr1NfLAvCaV44K5R0iYfj1B6Yq9uq6YYdLZYryvGzH8dtnRg==
X-Received: by 2002:a5d:64e2:0:b0:37d:4aa2:5ce8 with SMTP id ffacd0b85a97d-3805b4357ebmr225201f8f.5.1729844575593;
        Fri, 25 Oct 2024 01:22:55 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:54 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 10/10] sssd: fix path to python3 interpreter
Date: Fri, 25 Oct 2024 10:22:39 +0200
Message-ID: <20241025082239.3468351-11-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
References: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:23:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/758

The project uses /usr/bin/python as the path to the python3 interpreter
in the shebang of the python3 script /usr/sbin/sss_obfuscate[1].

OpenEmbedded uses /usr/bin/python3, and thus, it causes bitbake to raise
the QA issue attached below.

This fixes the path to the python3 interpreter by sed'ing the shebang at
do_install if the python3 is set in the PACKAGECONFIG.

Fixes:

	NOTE: Executing Tasks
	ERROR: sssd-2.9.2-r0 do_package_qa: QA Issue: /usr/sbin/sss_obfuscate contained in package sssd-python requires /usr/bin/python, but no providers found in RDEPENDS:sssd-python? [file-rdeps]
	ERROR: sssd-2.9.2-r0 do_package_qa: Fatal QA errors were found, failing task.

[1]: https://github.com/SSSD/sssd/blob/2.5.2/src/tools/sss_obfuscate#L1

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb      | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index e5cd4d8..f35d0c8 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -107,6 +107,10 @@ do_install () {
         echo "d ${SSSD_UID}:${SSSD_GID} 0755 ${localstatedir}/log/${BPN} none" > ${D}${sysconfdir}/default/volatiles/99_${BPN}
     fi
 
+    if ${@bb.utils.contains('PACKAGECONFIG', 'python3', 'true', 'false', d)}; then
+        sed '1s,/usr/bin/python,/usr/bin/python3,' -i ${D}${sbindir}/sss_obfuscate
+    fi
+
     # Remove /run as it is created on startup
     rm -rf ${D}/run
 
-- 
2.47.0


