Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8349.1794467997028680777
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 23:19:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=ioQG3au+;
 spf=pass (domain: mvista.com, ip: 74.125.82.171, mailfrom: rsangam@mvista.com)
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-372bdb942dbso5078170eec.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 23:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1794467996; x=1795072796; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+DKTvwErMh7aX3h3EbvuXWSlwf0fV83RQqtlZwFuJdo=;
        b=ioQG3au+yTAJdfKmBEYkC8QZkWcskuR68E6zUlNMIJfI9nCkpMFDvJ59c8jOfQ468Q
         U0ii5Uih1lnZc5d/gQsH+ZSx+FWc3xSaoAnGuE/2g5T6Za7760s+TD389EPRnMxntfxt
         bwkiO9ebbcOAkE7dI/VY5JdU56OI+tAZtFjso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467996; x=1795072796;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+DKTvwErMh7aX3h3EbvuXWSlwf0fV83RQqtlZwFuJdo=;
        b=TQQxmqpTZ6mLcLHGG6nFjuEBgvOM3YGv2/yk7SdiYJ3jirqNrozmNIAoc8kHU2d24X
         1Xz3+c/3ixoz1vOHVxITTWWF86VBwgoEu/iPeRlMagUeefWFcRQ3EmsXYh5hqYFLx9ID
         mLSgnJGSAyvQHxipHmf3W8wyumRO2MLQhI6WUb3pzvFhFz9sHXoNP8Y8opgyFhdVyByU
         c86klweaQepJMeX+/tbpYEaZheEAWG3ErmpU4aOtlBm8eIK+8oM5tbSdlsxi8QQXJ7Ev
         aZsCjN9VHm/cSzZHKSPbzytSOjdI/Rs1Rjpl4yY2q9NMpsYjLRiT7+iEdaOcHWqHCLiO
         pCDg==
X-Gm-Message-State: APuU4Z9VnAI/MrwoYtZ4EfaLWFEf/+JSHopxhZnIAgqox2Xbrug9Tk6v
	GbtfcvoK7LDsoe2CKOokzCntuJwU68ghXMPf5gr5DGZbfKdACEB3BKoVE1LHOYY5MyErAZ3TTX2
	fkvxCgk4=
X-Gm-Gg: AYBFou0DlGFUEz0TM9+xyI0Muor2qKdstaadvnHIb2LuC0FGimhILoerFj+Ubxwm7N+
	kX6RPnI9l0t40XFdn8u2XyIqWSx1cjZjgHFgBc+J4bv5RlZ37mYv3EXqYICO9r10P8qTdnRApr3
	N0t9a6szxuA/p2A8bmbIdXdw9yep9BFUTbP1BtbwKjD57j7SGX6iDPF5CTw3Yqpln9Sh3xVXh9Q
	3REJDOjW7jWndzyLT6UR7vQZ+qUyPzmWHRKNz0Y2UyV3KHbtXqqKW24a/1nwdNy+nRahf5hGNdd
	apnkSlkCrgYP7FqCqjzHfBeAos54nPdUT5EG83/1F76wr2cgB/UjbvItQCbgzUjbj1/r2gaeQgs
	lXO176+j6CTTcHLNVaVDg4TLte5WzVQLd8R2uTmgEp1iBOgO5sENOJ1b+DwotXMhICABj6h0VGA
	7v+XUryBMoOS6ipxGH9HbHK5u3MB0q7+Y6snCe+u0rhfylhaq9x/+Q8RhNCOJWlCp5irGU2mowf
	cK4ZSr8x4FKou19N1kybYn00xP8Itgbb5D1ZAjuzQopbBbTqqegyeEdn+y8MOokpjTzRrGqNRKz
	6H/q0WQwH2WKNcVpMCgcW8TJqa0O8BHW+bvSc/Yb
X-Received: by 2002:a05:7300:d58b:b0:361:167c:2364 with SMTP id 5a478bee46e88-37685b80515mr5210379eec.8.1794467996089;
        Wed, 11 Nov 2026 23:19:56 -0800 (PST)
Return-Path: <rsangam@mvista.com>
Received: from MVIN00040.mvista.com ([2405:201:d00d:401c:95e:7103:86c3:44e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm25557153eec.17.2026.11.11.23.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:19:55 -0800 (PST)
From: Rohini Sangam <rsangam@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Rohini Sangam <rsangam@mvista.com>
Subject: [meta-virtualization][scarthgap][PATCH] libvirt: Security fix for CVE-2026-18917
Date: Thu, 12 Nov 2026 12:49:45 +0530
Message-Id: <20261112071945.270457-1-rsangam@mvista.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 07:20:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5319
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

