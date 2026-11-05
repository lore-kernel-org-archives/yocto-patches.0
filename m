Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29018.1793862193573720461
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Nov 2026 23:03:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=DdmOuvr1;
 spf=pass (domain: cisco.com, ip: 173.37.86.76, mailfrom: dkelaiya@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1776; q=dns/txt;
  s=iport01; t=1793862193; x=1795071793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eztZUn7ktebkr+cav8vHsiT0hbz8WGnV3I+T2e2R7Vk=;
  b=DdmOuvr1oq/AjGixmY04DaIgX1ItZ5alwyy0ePCFcNeY78+FEYuNuGg7
   1ostTsGfg2dISFnrQjF5RZZszbnMtD2KzRmLLHBiCM8NpAptEUSbmcGj/
   GTlWw8jGYbTsIHIJazh3sPuVMXxaqeZv7D+Xn+MEjuEx/+GcF+SpxExMF
   tK7/H47VU04LcTrBAFqJ2RtIFvVR2itUmNzpcNGJwEFR4jt47qaXgwCP0
   UDn0X7UOH6Gc5tUi24XNL1Aqxh/ZegqJbMA429tWjXnYU4v3iRJIQvI4w
   JO6IyzND2GNZfcn7tBjjVIjcCSVUY6apG2+guFxFAMp5xRcfCmxOOgTSZ
   Q==;
X-CSE-ConnectionGUID: iqlDHLxhQW+mvN/MD5ZpWg==
X-CSE-MsgGUID: +uKlf69RS9SfnnjbDc416w==
X-IPAS-Result: =?us-ascii?q?A0BGAgDEKOxq/4v/Ja1aglmCV3VgQ0kDlkgDniGBfg8BA?=
 =?us-ascii?q?QEPSgcEAQGEP0YCjh0CJjQJDgECBAMCAwEBAQEBAQEBAQEBAQoBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4Thk8NkBMCAQMyATQSECAmCysrGYMCAYJ0AxEGvDGCLIEB4DEBBQYUA?=
 =?us-ascii?q?YE4hUCII3aEfScbG4FyhH6BBYFcAQEBARiCE4V5BIINFYEMhH+Jc4hFSIEeA?=
 =?us-ascii?q?1ksAVUTDQoLBwWBaAM1EioVbjIdgSM+F4EHGwYFgR2BHoESgQddgSsoXQEhg?=
 =?us-ascii?q?QiBdgKCUYIAAgFJQQ4HRVMJJUMSRyQiCBIJARMaLAqBGjU8CSY/FQxkCxoFY?=
 =?us-ascii?q?QgCDQxyORAwHiQvBRwmQBsKGBgNSBEsNxUZBD5uB5IvgxGBDioCBByBXS8Pp?=
 =?us-ascii?q?WeeS4JGCiiDeIwklToaM6pxmQiOCpZRhGmBaDyBWXAVgyISQRkPjjkng0SFE?=
 =?us-ascii?q?8k+JjICCQMvAQEHAgcOAwuBaJF+AQE?=
IronPort-Data: A9a23:ztM//qg1qiUlNprvrcCxEymZX161NREKZh0ujC45NGQN5FlHY01je
 htvX2iAP/7cajehctx0PIW//UoD65OGndE1GQptrng0ES5jpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FHwdOCn8ikkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeAULOZ82QsaDxNsvrf8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUZ4+JbIUVe9
 cUnazUTSFemq7+E2I20H7wEasQLdKEHPasFsX1miDWcBvE8TNWbGePB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWYQZ/5JEWxI9EglHzcDBcoVOErII84nPYy0p6172F3N/9J4DWFZwOwxnGz
 o7A1yfkIRUUao2l8mu+/HSqhOXjln+iBp1HQdVU8dYv2jV/3Fc7GRodSVz+ufClgU6zQPpbK
 lcI4Ww/qqMu81SxSdvwVAH+p2SL1iPwQPJKGOE8rQXIwa3O7kPBXC4PTyVKb5ots8peqSEW6
 2JlVujBXVRH2IB5g1rEnltIhVte4RQoEFI=
IronPort-HdrOrdr: A9a23:6czTF6A6hzxSOxLlHemO55DYdb4zR+YMi2TDGXofdfUzSL3+qy
 nAppUmPHPP5Qr5HUtQ++xoW5PwJU80i6QU3WB5B97LN2PbUSmTXeRfBODZrQEIdReTygck79
 YCT4FOTPvtEFN9kcH2pCO8E9om3Z271ZrAv5a585+oJjsaE52JKGxCe3+mLnE=
X-Talos-CUID: 9a23:xDRVEG7D64HFGB3twdss9VcQNuABYn3k8zTVPWn/LEo0eqWqRgrF
X-Talos-MUID: 9a23:7k8BhQtkLd678rSdNs2nxyxBMMk2sp6VWXsDl5MEseWPaXUuJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,196,1787011200"; 
   d="scan'208";a="544813576"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Nov 2026 07:03:12 +0000
Received: from sjc-ads-5675.cisco.com (sjc-ads-5675.cisco.com [10.28.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 9314D18000206;
	Thu,  5 Nov 2026 07:03:12 +0000 (GMT)
Received: by sjc-ads-5675.cisco.com (Postfix, from userid 1887444)
	id 3CAE3CBF201; Wed,  4 Nov 2026 23:03:12 -0800 (PST)
From: "Darsh Kelaiya -X (dkelaiya - E INFOCHIPS PRIVATE LIMITED at Cisco)" <dkelaiya@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Darsh Kelaiya <dkelaiya@cisco.com>
Subject: [yocto-patches][meta-selinux][wrynose][PATCH 2/2] selinux: ignore CVE-2026-59677 in components excluding seunshare
Date: Wed,  4 Nov 2026 23:03:09 -0800
Message-Id: <20261105070309.834959-2-dkelaiya@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20261105070309.834959-1-dkelaiya@cisco.com>
References: <20261105070309.834959-1-dkelaiya@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;sjc-ads-5675.cisco.com [10.28.88.189];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.28.88.189, sjc-ads-5675.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Nov 2026 07:03:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5238
Content-Type: text/plain; charset="utf-8"

From: Darsh Kelaiya <dkelaiya@cisco.com>

Analysis:
- CVE-2026-59677 affects the privileged --kill path in seunshare;
  upstream removes its killall() helper to fix the issue [1, 2].
- SELinux components share a broad CVE product mapping through
  selinux_common.inc [3]. Only selinux-sandbox builds seunshare.
- Set not-applicable-config once in the shared include for the
  components that exclude seunshare, including native variants.
- For BPN selinux-sandbox, remove this status flag after parsing
  so CVE reporting detects the source patch carried by its recipe.

Reference:
[1] https://security.opensuse.org/2026/07/15/selinux-seunshare.html
[2] https://github.com/SELinuxProject/selinux/commit/572db2fae9157ae620160e0d7b2c3f8b75fe6c1a
[3] https://git.yoctoproject.org/meta-selinux/tree/recipes-security/selinux/selinux_common.inc?id=1c3a699f363167571ab39fecb0fe6f56691a4e20

Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
---
 recipes-security/selinux/selinux_common.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index bf7aa78..e434853 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -23,8 +23,10 @@ do_install() {
 CVE_PRODUCT ?= "selinux_project:selinux"
 
 CVE_STATUS[CVE-2026-59676] = "not-applicable-config: The vulnerable seunshare utility is built by selinux-sandbox."
+CVE_STATUS[CVE-2026-59677] = "not-applicable-config: The vulnerable seunshare utility is built by selinux-sandbox."
 
 python __anonymous() {
     if d.getVar("BPN") == "selinux-sandbox":
         d.delVarFlag("CVE_STATUS", "CVE-2026-59676")
+        d.delVarFlag("CVE_STATUS", "CVE-2026-59677")
 }
-- 
2.35.6
