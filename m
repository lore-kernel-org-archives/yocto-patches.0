Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB384C55174
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 10:21:58 +0000 (UTC)
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37104.1785924468658883734
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 03:07:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=ee/pGFF9;
 spf=pass (domain: cisco.com, ip: 173.37.142.93, mailfrom: krkapate@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=941; q=dns/txt;
  s=iport01; t=1785924468; x=1787134068;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tbPQbMwYNkf4XlMmfr3AOJpPls3jtsa4tlSNbDGfup0=;
  b=ee/pGFF9PoxT03h11FhAQr/mVCOtlX6ixr7Zq5XTtpz6TjQrrskKwh54
   0Y/kk0Enfn0pOBCeGqQKTP9btb9GdcqLUOToXMY69DAvARnnUFsDhrV5l
   HwSeAXPLE1BkiBuXSsN+2mjL+ceZg0qOTbToOh5hYRbKLwWN4cGnXvJxQ
   j7Sf5o4PN0wxOMKrFaScACtQAN0/htMtKjVpFsx6kRwdk5a5lBmdOjGWm
   FJ6ABPVRIs8WvWvYwYVfd1YZW3h0XapkCBm3zQbsQBg1bnbmGfpf8f1XG
   NjsjUow/YvGLFkJgGHKFDmYh/Go50qjCHyC1e5gzZ+PiFu1zWP22oY8mU
   g==;
X-CSE-ConnectionGUID: u3CvrsGKR1idhvE4u+VkdQ==
X-CSE-MsgGUID: KuwcLCK6RnOwDGb0rxFQLw==
X-IPAS-Result: =?us-ascii?q?A0C/AgBzCnNq/5QQJK1aglmCV3RfQkm0aIF+DwEBAQ83G?=
 =?us-ascii?q?gQBAYISkFsCJjUIDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGT?=
 =?us-ascii?q?w2HEwF2XESDAgGCdAIBEb1igiyBAd5cgU8BCxQBgTiFP4ghdoJNgi8nG4INh?=
 =?us-ascii?q?H6BBQGBWwKBJ4EGhXgEgiKBDIF4kFlIgR4DWSwBVRMNCgsHBYFmAzUSKhVuM?=
 =?us-ascii?q?h2BIz4XgQ0bBwWBHYEohG0jGTZ8gQlegS0qZRIXgQmCewKCem8LGA1IESw3F?=
 =?us-ascii?q?BkEPm4HjWgggkCBDiyCLKV2oQ+QSJU6GjOqbJkIjgqWUIRpgWkBOoFZcIM3C?=
 =?us-ascii?q?UoZD444g2vMOSQ1PQIHAgcOAwuRaIF+AQE?=
IronPort-Data: A9a23:l3Rc1anKtcEgxdWudOZPktjo5gzLJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIaWj+OOPnfZ2WnLowgYIznpEpUvZ7Um4BhSwA6ry1jEltH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/raf658SUUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+ZC31GONgWYubDpEs//b8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZBD0fhtGk5tz
 6UZJDATQ0yexNy1zIvuH4GAhux7RCXqFIobvnclyXTSCuwrBMmaBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkEfUrsUIMpWcOOAhWP8eiVRtF+9rqss6G+Vxwt0uFToGIWEJYTWGp8Kwy50o
 Erl4nvyJjo5auaZ7iWp3Xj0nP/hpAfkDdd6+LqQs6QCbEeo7n0UAwEREEOyvfK5h1WWX9NEN
 1dS6y0lsa8q7kupQ9LhGRqirxa5UgU0Ut5UFag+rQqK0KeRul/fDWkfRTkHY9sj3CMreQEXO
 payt4uBLVRSXHe9ExpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:E1Jx/qhr+c2PEpbgFh7gRRgNQnBQXuoji2hC6mlwRA09TyX+rb
 HNoB1173HJYVoqNU3I+urwW5VoP0m8yXcd2+B4Vt2ftWLd11dAQrsP0WKb+V3dMhy70PJB3q
 F9dKU7ItjxAV9myfve2mCDYrMdKB3tytHOuQ8YpE0dKT1XVw==
X-Talos-CUID: =?us-ascii?q?9a23=3AUnRdCmgZSDnvc06PVbbNFDVl/TJubyb20m3LDGy?=
 =?us-ascii?q?CUGdlSKO4FULTxqBoqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AMOwmiw4D1Pf4TP8j9B3RlgM0xoxL/rulLGsuz68?=
 =?us-ascii?q?AnNaoGiYoISeztRCoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,206,1779148800"; 
   d="scan'208";a="797047275"
Received: from alln-l-core-11.cisco.com ([173.36.16.148])
  by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Aug 2026 10:07:47 +0000
Received: from sjc-ads-20749.cisco.com (sjc-ads-20749.cisco.com [171.70.189.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "ciscoit-managed-infra-smtp-auth.cisco.com", Issuer "Internal Private TLS SubCA" (verified OK))
	by alln-l-core-11.cisco.com (Postfix) with ESMTPS id 99266180009B9
	for <yocto-patches@lists.yoctoproject.org>; Wed,  5 Aug 2026 10:07:47 +0000 (GMT)
Received: by sjc-ads-20749.cisco.com (Postfix, from userid 1821000)
	id 317BBCCA40B; Wed,  5 Aug 2026 03:07:47 -0700 (PDT)
From: "Krupal Ka Patel -X (krkapate - E-INFO CHIPS INC at Cisco)" <krkapate@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][master][PATCH] tpm2-tools: fix PACKAGECONFIG typo
Date: Wed,  5 Aug 2026 03:07:45 -0700
Message-Id: <20260805100745.4112725-1-krkapate@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
X-Outbound-Client-TLS: VERIFIED;sjc-ads-20749.cisco.com [171.70.189.248];TLSv1.3;TLS_AES_256_GCM_SHA384;256;ciscoit-managed-infra-smtp-auth.cisco.com
X-Outbound-SMTP-Client: 171.70.189.248, sjc-ads-20749.cisco.com
X-Outbound-Node: alln-l-core-11.cisco.com
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 10:21:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4630

From: Krupal Ka Patel <krkapate@cisco.com>

Correct the misspelled PACKAGECONFIG variable so efivar is enabled by
default as intended by commit cdb4e444acbb2b9df467d716241a206c9ea6d3b0.

Signed-off-by: Krupal Ka Patel <krkapate@cisco.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index e1a0c5d..1947503 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -14,7 +14,7 @@ UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
 inherit autotools pkgconfig bash-completion
 
-PACKAGECONGIG ??= "efivar"
+PACKAGECONFIG ??= "efivar"
 PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
 
 BBCLASSEXTEND = "native nativesdk"
-- 
2.51.0


