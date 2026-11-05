Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29047.1793862380803339449
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 23:06:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=cLxmEluU;
 spf=pass (domain: cisco.com, ip: 173.37.86.72, mailfrom: dkelaiya@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2885; q=dns/txt;
  s=iport01; t=1793862380; x=1795071980;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L5dIeE2Y5kG4SYT9kxXdIV7+bEOJCCWjfJt40C/VFgw=;
  b=cLxmEluUNwJq0DUsYvrtOtto/0pCucypbyqqIuyJS4IRXtrDJ0riat5f
   TSba/UUEuYEHcUqLERTQt1HlSlE8X23OWp9xCwceS8VATgrTymKUBho+G
   gKUJzIx2K6wZFJ5aexYdzEhmGkpGfM4D0Q4eWfKesDb52JUEw2EClh7b7
   iHB4AM3dUOEyZXjO8v1b2yx3Y3ciSlc1IQ9EYtakLYVciaBJdRa2xbqmr
   hOyIP8cGveiNGi62yNoHhEo70WEWG4AzDyVdUsMAn+lug0iQ1IEpg2DgO
   nYHh8Ghqh/CwtLk18q99fQ5YE9nW1m97P/tisI4T97FAjB8/EXc/vxaCK
   w==;
X-CSE-ConnectionGUID: PtqUzTuoT3KJy1Kzh8nhNA==
X-CSE-MsgGUID: t5fyA2l3SVKVYGk/e8AoGg==
X-IPAS-Result: =?us-ascii?q?A0BGAgBCKexq/4r/Ja1aglmCV3VgQ0kDlVxsi2iSPIF+D?=
 =?us-ascii?q?wEBAQ9EDQQBAYQ/Ro4fAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBA?=
 =?us-ascii?q?gEHBYEOE4ZPDZASAQIBNQFGLAMBAk8LIyGDAgGCOgM3AxEGvDOCLIEBhH7YT?=
 =?us-ascii?q?A2CWgELFAGBOIVAgn+FJF0YAYR9JxsbgXKEfoEFgRpCAQEBgSaBBoV5BIIig?=
 =?us-ascii?q?QyBWh6GIoZYAoFShnFIgR4DWSwBVRMNCgsHBYFoAzUSKhVuMh2BIz4XgQcbB?=
 =?us-ascii?q?gWBHYEegRKBB12BKyhdASGBCIF2AoJRggACAUlBDgdFUwklQxJHJCIIEgkBE?=
 =?us-ascii?q?xosCoEaNTwJJj8VDGQLGgVhCAINDHI5EDAeJC8FHCZAGwoYGA1IESw3FRkEP?=
 =?us-ascii?q?m4Hki+CfxKBDgEHIgKBIF0GKUulK6AgcQoog3iMJI8+hXwaM6pxC5h9jgqEC?=
 =?us-ascii?q?pJHhGmBaDyBWXAVgyIJCUEZD44vCgscg0SFE8lIJjICCQMvAQEHAgcOAwuBa?=
 =?us-ascii?q?JAAgX4BAQ?=
IronPort-Data: A9a23:ZozteKLJHvIL4VYpFE+RhJQlxSXFcZb7ZxGr2PjKsXjdYENS1jdUm
 mdLW26DM/zZa2eme9p+YIvioR9T75LQmtBiTVQd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZpCCea+Uf1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnS0
 T/Oi5eHYgH8gmYoajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1WEFgLL7EF/dosIkNfr
 N8KKGALbjaq0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBVLAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2N0Sojx5nYj/7DLoyn+qsj3juehVTqUmeouw85G27IAlZjeSxa4KOKoLbLSlTtlrFq
 HPvpWCiOS85Cu2wyn2IolurqeCayEsXX6pXTtVU7MVCkVqY2mtWEBQKXlu2utG9i1WiQJROL
 EcI/TI0qqo//1DtScPyNyBUu1aetRIaHt4VGOog5UTVk+zf4h2SAS4PSTsphMEaifLajAcCj
 jeh9+4FzxQ22FFJYRpxLoupkA4=
IronPort-HdrOrdr: A9a23:ntPZbqk+1JcZgH3IknxlG+zl6gnpDfIa3DAbv31ZSRFFG/FwWf
 rAoB19726QtN9/YhAdcLy7VZVoIkmsl6Kdn7NwAV7KZmCP0wGVxepZg7cKrQeNJ8SHzJ8/6Y
 5QN45jFdb3EV92yez+4AW+DpIc5ePvytHNuQ8bpE0dKz2DrMpbnmBENjo=
X-Talos-CUID: 9a23:zbYEgmCtZsbreIf6ExF77XMGJt0iTib+7maJAF24WWBpbpTAHA==
X-Talos-MUID: 9a23:MeSFDAb6opDG2+BTq2LilRg4MJxT3YeQOW8O1phWks6rOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="544303869"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Nov 2026 07:06:19 +0000
Received: from sjc-ads-5675.cisco.com (sjc-ads-5675.cisco.com [10.28.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id B8740180001F2;
	Thu,  5 Nov 2026 07:06:19 +0000 (GMT)
Received: by sjc-ads-5675.cisco.com (Postfix, from userid 1887444)
	id 62360CC1611; Wed,  4 Nov 2026 23:06:19 -0800 (PST)
From: "Darsh Kelaiya -X (dkelaiya - E INFOCHIPS PRIVATE LIMITED at Cisco)" <dkelaiya@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Darsh Kelaiya <dkelaiya@cisco.com>
Subject: [yocto-patches][meta-selinux][wrynose][PATCH 1/2] selinux-sandbox: fix CVE-2026-59676
Date: Wed,  4 Nov 2026 23:06:16 -0800
Message-Id: <20261105070617.839020-1-dkelaiya@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;sjc-ads-5675.cisco.com [10.28.88.189];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.28.88.189, sjc-ads-5675.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Nov 2026 07:06:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5241
Content-Type: text/plain; charset="utf-8"

From: Darsh Kelaiya <dkelaiya@cisco.com>

This patch applies the upstream fix as referenced in [2],
using the commit shown in [1].

The 3.10 rm_rf() implementation follows symlinks after checking
directory entries, allowing a setuid seunshare caller to remove
root-owned files. Add O_NOFOLLOW to its recursive openat() call.

[1] https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd2472d4502842df5d5b8255a8
[2] https://security.opensuse.org/2026/07/15/selinux-seunshare.html

Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
---
 .../selinux-sandbox/CVE-2026-59676.patch      | 33 +++++++++++++++++++
 .../selinux/selinux-sandbox_3.10.bb           |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch

diff --git a/recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch b/recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch
new file mode 100644
index 0000000..1356381
--- /dev/null
+++ b/recipes-security/selinux/selinux-sandbox/CVE-2026-59676.patch
@@ -0,0 +1,33 @@
+From 38f0a4d9a683f2cd2472d4502842df5d5b8255a8 Mon Sep 17 00:00:00 2001
+From: Stephen Smalley <stephen.smalley.work@gmail.com>
+Date: Tue, 12 May 2026 14:34:02 -0400
+Subject: [PATCH] sandbox/seunshare: pass O_NOFOLLOW to openat()
+
+We do not want to follow symlinks here.
+
+CVE: CVE-2026-59676
+Upstream-Status: Backport [https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd2472d4502842df5d5b8255a8]
+
+Acked-by: James Carter <jwcart2@gmail.com>
+Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
+(cherry picked from commit 38f0a4d9a683f2cd2472d4502842df5d5b8255a8)
+Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
+---
+ sandbox/seunshare.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
+index e89a9fec..a1900eaa 100644
+--- a/sandbox/seunshare.c
++++ b/sandbox/seunshare.c
+@@ -428,7 +428,7 @@ static bool rm_rf(int targetfd, const char *path) {
+ 	}
+ 
+ 	if (S_ISDIR(statbuf.st_mode)) {
+-		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
++		const int newfd = openat(targetfd, path, O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
+ 		if (newfd < 0) {
+ 			perror("openat");
+ 			return false;
+-- 
+2.35.6
diff --git a/recipes-security/selinux/selinux-sandbox_3.10.bb b/recipes-security/selinux/selinux-sandbox_3.10.bb
index d29cd88..f8ffd36 100644
--- a/recipes-security/selinux/selinux-sandbox_3.10.bb
+++ b/recipes-security/selinux/selinux-sandbox_3.10.bb
@@ -10,6 +10,7 @@ LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=393a5ca445f6965873eca0259a17f833"
 require selinux_common.inc
 
 SRC_URI += "file://sandbox-de-bashify.patch;patchdir=.. \
+            file://CVE-2026-59676.patch;patchdir=.. \
            "
 
 S = "${UNPACKDIR}/${BP}/sandbox"
-- 
2.35.6
