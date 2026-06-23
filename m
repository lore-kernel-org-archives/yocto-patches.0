Return-Path: <nitin.wankhade333@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F3CDB471
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:10:48 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14975.1782195035236424897
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 23:10:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KMo61VI1;
 spf=pass (domain: gmail.com, ip: 209.85.214.180, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf332e9457so4679855ad.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 23:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195034; x=1782799834; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMz1k5BKruWXiJmcBwuX/Ouj2rqXb/4H9U+XjtV6phI=;
        b=KMo61VI1WeC3Xt4U3N75/Sf3guKi57PFGwX0/n8JEdV72PznpMhV69NPlpJifbRB+g
         xqfRl56MYrHtYwtAbRWWfkO+uygMqYkb1XriNlThboHo1OGg2pct0+L7RtLnqSnaGB71
         Z6oenyo4Mj1N+FlcMBT8Sb0m0gF3/m7GtLn5i+eoHp42KGXsOtotZDpAqgXsLPec/Gvw
         qh1MK78JgMOZJ40q7FaVdCpj2LuJ4H3oeNPegQ/ku4VXZmfwMOWmwm6eCMT1vWA/PjGK
         zUuolqPQ6bm/5Vyngp85+FHtiALgDDhm5HTYp8TsXSVd6bOmqmJlg3f9GTMHJJYxQ85l
         nAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195034; x=1782799834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mMz1k5BKruWXiJmcBwuX/Ouj2rqXb/4H9U+XjtV6phI=;
        b=rVxo7v5kYitvpeT7epMFIYVzhCdgRE/M/0p4CBO4Bva9UlE8xTTgPt90nQOqKH6YKF
         8cEKHV+81UffGxNwP6TJEew4khKoDMOVud6UuqnH4AtvjBh4oX5EydIC8VFWvVWVMwv7
         eBvbOFN3F0+2cGcLbujhlkTE/Q+4C+tujpcgOpyi3CM6E4t2/uyb4IiPUTMLLJTCzRky
         aVHLgWrpjD0cXv0femdOr4h5ZdMdqep/cb+2XmfZ7kaop3TyoVvLjwK8iCyFkKuBjePF
         E4D7J4UDK+4KBuYfoVaf3jIa+qRUW35oURvsNIbD0s8ztlsQRQh7hTgr/xSIMlVrveaW
         lNFw==
X-Gm-Message-State: AOJu0YxHLCDB/yhdv4n2Z8UbnIU4tuP8n3+CDrUv7Vz6FHtG+J6v1iUt
	wW6mIkPE14wa1ya8+jkTb9zNkYslOXwlFuVQPwAXdftJ84PpHfxTT/bFlUydJIO+i9Q=
X-Gm-Gg: AfdE7cmZKGCoIRXKvCafHj0FEuXZMRlqyDudJAHj1xOG3aRsBRe/Wufx7DDPYj790Mj
	jaXnzY+nu79hlKa0GGgWrR4qk9HsJ1rG7pUCJo2cQAlQAUWzH9s0fkSsVLxhuxN4dE1rCnREQ99
	O/5g32LtXnhWY5vRpnvwbePCObcv9FNtCoepaWGBsnx/ThTmWxRLetSLiKPAzZcE4sbb/++2MRa
	5EE2q5Gd0fubqFfTmiUVJRY1YPRFcXyDE3eDXIGfQn08ofzj0tc5sv2q1jnYBEw6Pq3gRM523ah
	gvxoAZyISwHugslDolAElyTpXFl2/OMBtTKZOAtxk2qJEYlcXVqCBZgbBKbNHruafrLdvzzCpcy
	hOKGGqk6IzxjRxmigSFpgR9kHWnuHpjUSkka/kO/AxYLM8lf2phIdy3YRFNAzY4ANu+5ErnKh6F
	JS1uN5hXyd8y0Ypv+cDE8ffOI=
X-Received: by 2002:a17:903:124d:b0:2c0:c262:b928 with SMTP id d9443c01a7336-2c7bf0d568cmr18218935ad.2.1782195034599;
        Mon, 22 Jun 2026 23:10:34 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85f1sm99844045ad.42.2026.06.22.23.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:10:34 -0700 (PDT)
From: Nitin Wankhade <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH V2 6/7] strongswan: Fix CVE-2026-35333
Date: Tue, 23 Jun 2026 11:40:00 +0530
Message-Id: <20260623061001.644583-6-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623061001.644583-1-nitin.wankhade@kpit.com>
References: <20260623061001.644583-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:10:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4272

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 .../strongswan/files/CVE-2026-35333.patch     | 41 +++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |  1 +
 2 files changed, 42 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/CVE-2026-35333.patch

diff --git a/meta-networking/recipes-support/strongswan/files/CVE-2026-35333.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-35333.patch
new file mode 100644
index 0000000..0233ebf
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/CVE-2026-35333.patch
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
index 1e90b1c..ecc7788 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -5,4 +5,5 @@ SRC_URI += "\
     file://CVE-2026-35330.patch \
     file://CVE-2026-35331.patch \
     file://CVE-2026-35332.patch \
+    file://CVE-2026-35333.patch \
 "
-- 
2.34.1


