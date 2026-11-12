Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8297.1794467631853412069
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 23:13:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=khvCRN8v;
 spf=pass (domain: mvista.com, ip: 74.125.82.181, mailfrom: rsangam@mvista.com)
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37628596783so3806539eec.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 23:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1794467631; x=1795072431; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DKTvwErMh7aX3h3EbvuXWSlwf0fV83RQqtlZwFuJdo=;
        b=khvCRN8vGT0hQ1N6GB7xJ909gSA0yG4WCxt04xxy3kzRpyuA0m5N3K3VTWcBEoTdj0
         Yj5sEdJZ0nZc4sDmaV/1h8hBvZKgwQSGnGDLwNrG/JXKxDtoVjh5dQIzcfUB4fHlDSx+
         VyAZootQb4NvzVBlc15nBh7BE0bey/z48Z1Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467631; x=1795072431;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+DKTvwErMh7aX3h3EbvuXWSlwf0fV83RQqtlZwFuJdo=;
        b=ZP7SS2ix6EP2KNSha8QYIQ7K/Y1DyHOXSbRbnnv48y0FEIuJ0rfw/1fl0/RLr411A0
         e2xV/m7jeHOPE9AZDIRIYNWMBFkQz1rpYHT8IgtyqvlDm3i1Z1c8HekjSB2AbMSxci5d
         guO4nqAFrV6+TuwBZDzpyudhtA3o8dpOJi+/QaPPGc6hBAyXY+HrtfLnkBUS5t0Zqf1D
         KJxu79umGrvws86b4eb8yp17mxYUnTCr8N6jrHRB1jDyPir7RZCiYsdi5wK4nlIchEFv
         Sod/zGa2YOzpHAFyGiwWLFrtCtpypu+BHA2t6ETJoyd6s0ZVSJkV620yjjXmd5Tt7zvy
         8sZg==
X-Gm-Message-State: APuU4Z81gcY14XoVwJvtpzTtx4KlZw6q46UC2E+YZw4W+W4vaFdO8UTV
	9oQLD7kdCLiy4ka3qAvYg1oWbU9YeIcYnh06a4CGoHb9G78ubxD/VbTZ/EL5U6x/vvmMGaR/HWu
	4BLe6QII=
X-Gm-Gg: AYBFou2iEyC1qn4mjCSneyVFlncZv6gsPJwf6EraeBy0liVzCNkpzZ06wOkt/4i1cdw
	EBYsIeBTls36k4XtGsxWgnuAKDraHu0pkZv1N12dCJCdfFI1p7bbiw5wRj0R8qUbL8a2/kfJkOu
	ED2o3hMICk+IAtOxe6l4uG5ys1ofAlze0QUB+t+aiNPpUweNQ4fLML0zIinc/3Fx0/N3IERORbY
	dCwDdMkhkRoOE5B8Ch05xB/3waKbXZUsCS4eQ0YywrAwXIv2wsvGtX4iYIru5+ifSpSLiOEZKGc
	6xz5Sbtvk1+gU4GOGT7X94ZQhhnyoopXL4ozLLp9tEITeAVOpxwprwD69NdFth88luxstmPmoHx
	bvnqOvRiVEoWnLVjDSfb1/Vuor+MuDHz3xMev67CjnecmxWSvLEhLb1QOWVsGVSMuDhal/R0zZI
	ZWUkk804IlUvXdLkdX67B2vHLqHCSyRi7WxZW/3hx7VhEbqSLRXrk4xXmxqOdEdOw62421nWt/H
	Z0hcRF26uMSk4mJHLzNyyQI3NXHZoXbzQXR2H68QvTYqRi6jVhdJe2xh5jHA+n9Bt5bRA+pIYtd
	X/MivCIYu0HEYEqNYtwOaPXgvGCSVVhHfFdCjPTt
X-Received: by 2002:a05:7022:b058:10b0:185:33ab:4d55 with SMTP id a92af1059eb24-1b3c137c87emr4174181c88.29.1794467630866;
        Wed, 11 Nov 2026 23:13:50 -0800 (PST)
Return-Path: <rsangam@mvista.com>
Received: from MVIN00040.mvista.com ([2405:201:d00d:401c:95e:7103:86c3:44e5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm19512404c88.13.2026.11.11.23.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:13:50 -0800 (PST)
From: Rohini Sangam <rsangam@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Rohini Sangam <rsangam@mvista.com>
Subject: [meta-virtualization][scarthgap][PATCH] libvirt: Security fix for CVE-2026-18917
Date: Thu, 12 Nov 2026 12:43:42 +0530
Message-Id: <20261112071342.269791-1-rsangam@mvista.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 07:14:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5318
Content-Type: text/plain; charset="utf-8"

Pick patch from [1] also mentioned at Debian tracker in [2]

[1] https://gitlab.com/libvirt/libvirt/-/commit/5a62cbf2907d4590283597b46da9c0f41e7b4d4f
[2] https://security-tracker.debian.org/tracker/CVE-2026-18917

Signed-off-by: Rohini Sangam <rsangam@mvista.com>
---
 .../libvirt/libvirt/CVE-2026-18917.patch      | 70 +++++++++++++++++++
 recipes-extended/libvirt/libvirt_10.0.0.bb    |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 recipes-extended/libvirt/libvirt/CVE-2026-18917.patch

diff --git a/recipes-extended/libvirt/libvirt/CVE-2026-18917.patch b/recipes-extended/libvirt/libvirt/CVE-2026-18917.patch
new file mode 100644
index 00000000..bf9c2e69
--- /dev/null
+++ b/recipes-extended/libvirt/libvirt/CVE-2026-18917.patch
@@ -0,0 +1,70 @@
+From 5a62cbf2907d4590283597b46da9c0f41e7b4d4f Mon Sep 17 00:00:00 2001
+From: Peter Krempa <pkrempa@redhat.com>
+Date: Wed, 12 Aug 2026 16:51:58 +0200
+Subject: [PATCH] remote: Fix integer overflow in RPC handler for
+ virNodeGetFreePages (CVE-2026-18917)
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+CVE-2026-18917
+
+The RPC handler 'remoteDispatchNodeGetFreePages' multiplies the 'npages'
+argument with the 'cellcount' argument passed to 'virNodeGetFreePages',
+both of which are declared as 'unsigned int' to both do an RPC limit
+check against the 'REMOTE_NODE_MAX_CELLS' constant and then to allocate
+the memory to hold the result from the actual hypervisor driver.
+
+Since both the values are 'unsigned int' the product is also unsigned
+int so big enough numbers can overflow, both passing the check and also
+allocating not enough memory for the result. The hypervisor driver
+assumes that the passed buffer is large enough and overwrites memory.
+
+When this happens the the hypervisor daemon crashes.
+
+This can be triggered e.g. by passing 1023 and 4198405 as values which
+multiply to 1019 after wrapping to 32 bit unsigned value.
+
+Use the VIR_INT_MULTIPLY_OVERFLOW macro in the check to avoid the issue
+the same way as we do for other APIs doing multiplication of arguments
+to determine amount of required memory.
+
+Fixes: 34f2d0319d2098c77c8cc27d8350616029125a2b (v1.2.5-164-g34f2d0319d)
+Closes: https://gitlab.com/libvirt/libvirt/-/work_items/903
+Signed-off-by: Peter Krempa <pkrempa@redhat.com>
+Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
+
+CVE: CVE-2026-18917
+Upstream-Status: Backport from https://gitlab.com/libvirt/libvirt/-/commit/5a62cbf2907d4590283597b46da9c0f41e7b4d4f
+
+Signed-off-by: Rohini Sangam <rsangam@mvista.com>
+---
+ src/remote/remote_daemon_dispatch.c | 9 +++++----
+ 1 file changed, 5 insertions(+), 4 deletions(-)
+
+diff --git a/src/remote/remote_daemon_dispatch.c b/src/remote/remote_daemon_dispatch.c
+index 7542caa..8bf5e7c 100644
+--- a/src/remote/remote_daemon_dispatch.c
++++ b/src/remote/remote_daemon_dispatch.c
+@@ -6620,13 +6620,14 @@ remoteDispatchNodeGetFreePages(virNetServer *server G_GNUC_UNUSED,
+     if (!conn)
+         goto cleanup;
+ 
+-    if (args->pages.pages_len * args->cellCount > REMOTE_NODE_MAX_CELLS) {
+-        virReportError(VIR_ERR_INTERNAL_ERROR, "%s",
+-                       _("the result won't fit into REMOTE_NODE_MAX_CELLS"));
++    if (VIR_INT_MULTIPLY_OVERFLOW(args->pages.pages_len, args->cellCount) ||
++        args->pages.pages_len * args->cellCount > REMOTE_NODE_MAX_CELLS) {
++        virReportError(VIR_ERR_INTERNAL_ERROR,
++                       _("npages * cellcount > REMOTE_NODE_MAX_CELLS (%1$u)"),
++                       REMOTE_NODE_MAX_CELLS);
+         goto cleanup;
+     }
+ 
+-    /* Allocate return buffer. */
+     ret->counts.counts_val = g_new0(uint64_t,
+                                     args->pages.pages_len * args->cellCount);
+ 
+-- 
+2.44.4
+
diff --git a/recipes-extended/libvirt/libvirt_10.0.0.bb b/recipes-extended/libvirt/libvirt_10.0.0.bb
index 4076a0cf..2bb725b1 100644
--- a/recipes-extended/libvirt/libvirt_10.0.0.bb
+++ b/recipes-extended/libvirt/libvirt_10.0.0.bb
@@ -39,6 +39,7 @@ SRC_URI = "http://libvirt.org/sources/libvirt-${PV}.tar.xz;name=libvirt \
            file://CVE-2024-4418.patch \
            file://CVE-2025-13193.patch \
            file://CVE-2026-63622.patch \
+           file://CVE-2026-18917.patch \
           "
 
 SRC_URI[libvirt.sha256sum] = "8ba2e72ec8bdd2418554a1474c42c35704c30174b7611eaf9a16544b71bcf00a"
-- 
2.34.1

