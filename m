Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28801.1793862193853476893
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 23:03:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=EcjtkrFF;
 spf=pass (domain: cisco.com, ip: 173.37.86.78, mailfrom: dkelaiya@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1617; q=dns/txt;
  s=iport01; t=1793862193; x=1795071793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Vx7Jv3FXEUmm/k7fDVx0MKHOW43UPmZXRIYF8nYq5E=;
  b=EcjtkrFF4RB4rTfwcygV8JieGmGegxocQcEnCp0hau6oL9rnpvAdUwBq
   58T6H5aXAPtECj3JqFk6FAXXN+ZQ5t8V80eXeKOhJRacPxOT6gfkuFkAx
   LWFSWP/lpXzIDgnr2txsHzhPw1L7tp5UWBfkGOV9pqPmfauK+a3HHFjom
   2Pu3Uhv6QvvoGk2bToXYjcLG7y6+HGw7nYs8lYuwOSOe6rjUkJPDzamZi
   ox06fuyFNW3P9lq5lrKoemOjnPYRE2DgFEX024rJ5O1jVOKgOC1PqM+nd
   u4AGZ4oSeTu08Y3x+wxSOsyDS9I3QJQi14csRiOuaURPSRFJ3Ff/f+Baf
   w==;
X-CSE-ConnectionGUID: TUK8iG1cQS2VxTzWaHgbpg==
X-CSE-MsgGUID: I3OYkNijQvujxC1XUAIn7g==
X-IPAS-Result: =?us-ascii?q?A0BCAgDEKOxq/5L/Ja1aglmCV3VgQ0kDlkieJIF+DwEBA?=
 =?us-ascii?q?Q9KBwQBAYQ/Ro4fAiY0CQ4BAgQDAgMBAQEBAQEBAQEBAQEKAQEFAQEBAgEHB?=
 =?us-ascii?q?YEOE4ZPDZAVNgE0EjAmNkSDAgGCdAMRBrwxgiyBAeAxAQUGFAGBOIVAiCN2h?=
 =?us-ascii?q?H0nGxuBcoR+gQWBXAEBAQEYgQ2BBoV5BIINFYEMhH+Jc4hFSIEeA1ksAVUTD?=
 =?us-ascii?q?QoLBwWBaAM1EioVbjIdgSM+F4EHGwYFgR2BHoESgQddgSsoXQEhgQiBdgKCU?=
 =?us-ascii?q?YIAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxkCxoFYQgCDQxyO?=
 =?us-ascii?q?RAwHiQvBRwmQBsKGBgNSBEsNxUZBD5uB5IvgxGBDioCBIF5Lw+lZ6ERCiiDe?=
 =?us-ascii?q?IwklToaM6pxmQiOCpZRhGmBaDyBWXAVgyISQRkPjjkng0SFE8k+JjICCQMvA?=
 =?us-ascii?q?QEHAgcOAwuBaJAAgX4BAQ?=
IronPort-Data: A9a23:AMIulK6If6gjbxIxb4CngwxRtG3GchMFZxGqfqrLsTDasY5as4F+v
 mobWW+EPPqMYWSkcth/Pouz9h8E7J/Sm9BgGQtqq3pgZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOex9RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/KUzBHf/g2QqaztMt/rZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eAbA7qudYWGp3z
 qYmOAwfURmjiOiuz+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGcGFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkERUrsUIMpWcOOAinrydzRZuVu9rqss6G+Vxwt0uFToGIeJIY3SG5sPzy50o
 ErnpEPIATcbNuWB1DiV2Sucu8bum3z0Ddd6+LqQs6QCbEeo7n0UAwEREEOyvfK5h1WWX9NEN
 1dS6y0lsa8q7kupQ9LhGRqirxa5UgU0QdFcFag+rQqK0KeRu1ffDWkfRTkHY9sj3CMreQEXO
 payt4uBLVRSXHe9EBpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:XZdqna2K9nLuBUk66GQPdQqjBIQkLtp133Aq2lEZdPWaSKOlfq
 eV7ZEmPHDP6Qr5NEtMpTniAtjjfZqjz/5ICOAqVN/INjUO01HHEGgN1+ffKkXbak7D398Y87
 t8eK5jD9C1J117gcHmpDScKb8bsb26GGTCv5a585+rJjsaDJ1d0w==
X-Talos-CUID: 9a23:PSX0A23qDqe0RriYmnmwXbxfJv0GInzylXzpGBWGGVp7d7S1RlWI9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3A75dpjA1bLZeLuCSOxx4nb+OxsjUjwv+JOUMrkJc?=
 =?us-ascii?q?/pdSGJQcpCwq0rTLoTdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="543906629"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Nov 2026 07:03:12 +0000
Received: from sjc-ads-5675.cisco.com (sjc-ads-5675.cisco.com [10.28.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 8F84318000200;
	Thu,  5 Nov 2026 07:03:12 +0000 (GMT)
Received: by sjc-ads-5675.cisco.com (Postfix, from userid 1887444)
	id 3A129CC1611; Wed,  4 Nov 2026 23:03:12 -0800 (PST)
From: "Darsh Kelaiya -X (dkelaiya - E INFOCHIPS PRIVATE LIMITED at Cisco)" <dkelaiya@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Darsh Kelaiya <dkelaiya@cisco.com>
Subject: [yocto-patches][meta-selinux][wrynose][PATCH 1/2] selinux: ignore CVE-2026-59676 in components excluding seunshare
Date: Wed,  4 Nov 2026 23:03:08 -0800
Message-Id: <20261105070309.834959-1-dkelaiya@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;sjc-ads-5675.cisco.com [10.28.88.189];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.28.88.189, sjc-ads-5675.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Nov 2026 07:03:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5239
Content-Type: text/plain; charset="utf-8"

From: Darsh Kelaiya <dkelaiya@cisco.com>

Analysis:
- CVE-2026-59676 affects recursive deletion in sandbox/seunshare.c
  and is fixed by adding O_NOFOLLOW to openat() [1, 2].
- SELinux components share a broad CVE product mapping through
  selinux_common.inc [3]. Only selinux-sandbox builds seunshare.
- Set not-applicable-config once in the shared include for the
  components that exclude seunshare, including native variants.
- For BPN selinux-sandbox, remove this status flag after parsing
  so CVE reporting detects the source patch carried by its recipe.

Reference:
[1] https://security.opensuse.org/2026/07/15/selinux-seunshare.html
[2] https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd2472d4502842df5d5b8255a8
[3] https://git.yoctoproject.org/meta-selinux/tree/recipes-security/selinux/selinux_common.inc?id=1c3a699f363167571ab39fecb0fe6f56691a4e20

Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
---
 recipes-security/selinux/selinux_common.inc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index aaf0b90..bf7aa78 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -21,3 +21,10 @@ do_install() {
 }
 
 CVE_PRODUCT ?= "selinux_project:selinux"
+
+CVE_STATUS[CVE-2026-59676] = "not-applicable-config: The vulnerable seunshare utility is built by selinux-sandbox."
+
+python __anonymous() {
+    if d.getVar("BPN") == "selinux-sandbox":
+        d.delVarFlag("CVE_STATUS", "CVE-2026-59676")
+}
-- 
2.35.6
