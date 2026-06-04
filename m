Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A857CD6E68
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 08:05:56 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6283.1780560348068464778
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 01:05:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=IIyHvLeY;
 spf=pass (domain: gmail.com, ip: 209.85.215.172, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8584e80bd3so181436a12.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560347; x=1781165147; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pK2yRVhNBKt8zVmDaSxdIDrmqLebHhDZEG+YBQh3q0=;
        b=IIyHvLeYv/qyhehyRtqDiC7iCpdZvPTopg0ZxTv+gm8u1/Iyi5xo2iTHSTqnh5v19P
         13R4ydICAAEOHVpAnX8e2SS7PkqKlR5GfW3tZp4ln+7eutxFCPcuDEPMSANtyFx9EGGc
         X6j0glkoiaej6s09Dfm5J8VHimCwYl1RgWNOSUqjHyU0P9bi83JBTGvprA0rljESJRRy
         rLp+SQ3ctBtVU4J2nT4cVbB0m/p+L721LRo2WbexgYYJucHJBu0GF9YLtOfBWNm2TMYZ
         Z3byLDsKaufFREUVn9lLt7vWeiFkq+mxalXatpN9fnmtUHUFBRXKEU9wKLT93Z1fVSUx
         uQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560347; x=1781165147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pK2yRVhNBKt8zVmDaSxdIDrmqLebHhDZEG+YBQh3q0=;
        b=eiHUYpFy2gFW70P8/7FRSao9E5bRlLKW72UtgmA7HJTwmfc0T0zOAajCpHosbaikRb
         51ouG7RQkHgsHQkWtGb91hXNQwdQF7Xvet6vIfryNWupZju6ZUvc5pG+ObDIsguuZkga
         Vew1+dD500Sp/dnxC4j2LyxHfj/nboroneY7PbSkQwV04ecO/b6Kb48gXTu0JEJTACzV
         x3LsFqBWeqTTUa+Y1CzlifRz0P+UcF6hvlYEMQvqarbg5xMrDXQ9UtKVcrpAay4QBoWT
         rUOUqRguCG303NtoNebjrVCvzRiK+IHWGoVW8d9nd4QS8ezc/HUVZlpUW9kX0wgAjdFl
         FcAg==
X-Gm-Message-State: AOJu0Yw/ycu0lcWvjZ9Wqz3+lXJl/WugzQYMSuw5YDvuDB7+3bAMWLcB
	DY2BHoSd09uZqDEh8FGxbjrIqQxQ8QSZvHUsZjuj8IKsXEotSJT1qASylQ5F+g==
X-Gm-Gg: Acq92OH4r/yF7mzMDClPDmVDYIwc8Nb5GUUZ0NPMYQPTsuwC/IIjc0U49gSVUJZPWXI
	LaSLn5P1PXk46SIlNEXFc9HILcMFf97fFJ/Y6M8onnC/TlygEUJaL0ctaWP/HHxD4YKlWzIWQ0G
	ZKREl0xe39qNd1cMDX6ns1x1TgFYaOy69rEoUMoEN/F/gnViq1OTJssHPdIKz7aXVkPc1XoOAcG
	Ghn0WxvDIY8s9ahPYStIDN+ZGX0sIF4OrrETv9GpNBUJqDzN0oDRTjgD+pCpz/PD2nb3i4xJ6qD
	q2YaJa6tscV3zjyId8AQ56tM3pLPpvYbw6YNV73KbNK1CHPxR4p6aThFs3NYHG6rO+d/j/KQflX
	zQugW5s14PH1KuI8yVenabhmTq3J3Jq4lnfRlQPqwUU536fZDYlcJgusVz6wRcqKKbZbGV1HNjo
	wlaycnRz9BSdDUZBMQrT+cuXY5uasXx6SEFDI2ZyfWdX3H6g==
X-Received: by 2002:a05:6a00:ab85:b0:842:6a3b:60ea with SMTP id d2e1a72fcca58-84284f475d2mr6842050b3a.40.1780560347345;
        Thu, 04 Jun 2026 01:05:47 -0700 (PDT)
Received: from LL-868L.kpit.com ([103.155.222.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm6139001b3a.49.2026.06.04.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:05:46 -0700 (PDT)
From: Nitin Wankhade <jackson.james9803@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH 6/7] strongswan: Fix CVE-2026-35333
Date: Thu,  4 Jun 2026 13:35:05 +0530
Message-Id: <20260604080506.274123-6-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604080506.274123-1-nitin.wankhade@kpit.com>
References: <20260604080506.274123-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 08:05:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4137

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 ...-undersized-attributes-in-enumerator.patch | 41 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/libradius-Reject-undersized-attributes-in-enumerator.patch

diff --git a/meta-networking/recipes-support/strongswan/files/libradius-Reject-undersized-attributes-in-enumerator.patch b/meta-networking/recipes-support/strongswan/files/libradius-Reject-undersized-attributes-in-enumerator.patch
new file mode 100644
index 0000000..0233ebf
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/libradius-Reject-undersized-attributes-in-enumerator.patch
@@ -0,0 +1,41 @@
+From: =?utf-8?q?Lukas_Johannes_M=C3=B6ller?= <research@johannes-moeller.dev>
+Date: Thu, 12 Mar 2026 10:24:45 +0000
+Subject: libradius: Reject undersized attributes in enumerator
+MIME-Version: 1.0
+Content-Type: text/plain; charset="utf-8"
+Content-Transfer-Encoding: 8bit
+
+attribute_enumerate() accepts RADIUS attributes whose length byte is
+smaller than sizeof(rattr_t) (2).  For length == 0, the iterator never
+advances and traps callers — including verify() — in a non-advancing
+loop.  For length == 1, misaligned packed-struct reads occur.
+
+Add a separate check for this->next->length < sizeof(rattr_t) after
+the existing truncation guard.  This mirrors radius_message_parse(),
+which already distinguishes invalid length from truncation.
+
+Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
+
+Fixes: 4a6b84a93461 ("reintegrated eap-radius branch into trunk")
+Fixes: CVE-2026-35333
+
+CVE: CVE-2026-35333
+Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]
+Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
+===
+diff --git a/src/libradius/radius_message.c b/src/libradius/radius_message.c
+index 8e2db0c..2bbbb48 100644
+--- a/src/libradius/radius_message.c
++++ b/src/libradius/radius_message.c
+@@ -261,6 +261,11 @@ METHOD(enumerator_t, attribute_enumerate, bool,
+ 		DBG1(DBG_IKE, "RADIUS message truncated");
+ 		return FALSE;
+ 	}
++	if (this->next->length < sizeof(rattr_t))
++	{
++                DBG1(DBG_IKE, "RADIUS attribute has invalid length");
++                return FALSE;
++       }
+ 	*type = this->next->type;
+ 	data->ptr = this->next->value;
+ 	data->len = this->next->length - sizeof(rattr_t);
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
index 8ccb230..8d22b60 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -4,4 +4,5 @@ SRC_URI += "\
     file://libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch \
     file://constraints-Case-insensitive-matching-and-reject-exc.patch \
     file://tls-server-Only-accept-non-empty-ECDH-public-keys-wi.patch \
+    file://libradius-Reject-undersized-attributes-in-enumerator.patch \
 "
-- 
2.34.1


