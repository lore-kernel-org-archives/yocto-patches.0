Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FECF3026D
	for <webhook@archiver.kernel.org>; Sun, 15 Mar 2026 14:26:44 +0000 (UTC)
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27946.1773578746704949734
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Mar 2026 05:45:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=TlWZu5ZO;
 spf=pass (domain: cisco.com, ip: 173.37.142.91, mailfrom: deeratho@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1138; q=dns/txt;
  s=iport01; t=1773578746; x=1774788346;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ArO8O3UGwCx901SBONlqM10fp5TM5iJp2ylsON5cm74=;
  b=TlWZu5ZO7q/EUGV6R9r6EB1JXtJnr7n6HqaGYMOnhlb0wXGv2lcytuvp
   b6I33I628ibqilWmrwdijXsfoxU1RFfsvbkiVNAwCHS323aW/Bra51SNh
   O00/dePpMdKWdURev4VJrr1R70XxMW77bnBQIElXvIAmtd70muB9zns5k
   Liw7hmGvpmaF+TvEWAVzfrhU9l/cRaw6vzdTiyZn8ORdfWS2HyOrKEWfN
   5qwU/7Xqxow+vPATc6tZXtJfv2tWa4bYQte3HJ47Ibjfn4OUCu9FRwnff
   qHK9H2wHRa5qZaYmFFeKeAzLnNqqaqQAkz80fC3uXqAwWQdBCgKyiszns
   Q==;
X-CSE-ConnectionGUID: OhyuMyL9TwqFBBYUkTbVFA==
X-CSE-MsgGUID: IDNXcHQ6Q+OhVycU0vpKOw==
X-IPAS-Result: =?us-ascii?q?A0DVBgBWqbZp/5D/Ja1aglmCSIEAX0JJlCqCIZ4dgX8PA?=
 =?us-ascii?q?QEBDzcaBAEBkisCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4ThlyHEwF2XESDAgGCcwIBsXmCLIEBhHzbMhWBOIU8iBl0hHonGxuBc?=
 =?us-ascii?q?oQHgWEaAYQKhXcEgiJ6FIc7BoM1iDZIgR4DWSwBVRMNCgsHBYFmAzUSKhVuM?=
 =?us-ascii?q?h2BIz4XgQsbBwWFGg+IcnRtgRODLQMLGA1IESwUIxQbBD5uB416PYI0gQ+BR?=
 =?us-ascii?q?mkoESGlQqEOCiiDdIwelToaM6prhEyUOqQJUIRogWg8gVlwFYMiCUkZD444z?=
 =?us-ascii?q?R0jNT0BAQcCBw0DC4FokX0BAQ?=
IronPort-Data: A9a23:AtlVF6g5rtI2GZlQy1WYDyVLX161NREKZh0ujC45NGQN5FlHY01je
 htvX2HUb/aDYGb2eY1/PIm2oUkG6J6Am4RiGlA6/H8xRCxjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeEULOZ82QsaDxMsPve8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqU/+vdqJHBqp
 MAHMR4nRCG+hN68/pySH7wEasQLdKEHPasFsX1miDWcBvE8TNWbHOPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZgt/5JEWxI9EglHzfjBCoU6VooI84nPYy0p6172F3N/9JI3SFZkMwR7Cz
 o7A10XVJCERFOXB8Hmi8ky9jdKXgzvYf51HQdVU8dYv2jV/3Fc7GRodSVz+ufClgU6zQPpbK
 lcI4Ww/qqMu81SxSdvwVAH+p2SL1iPwQPJKGOE8rQXIwa3O7kPBWS4PTyVKb5ots8peqSEW6
 2JlVujBXVRH2IB5g1rHnltIhVte4RQoEFI=
IronPort-HdrOrdr: A9a23:cuXU561ewUpejKmylSFvUgqjBKckLtp133Aq2lEZdPUzSL37qy
 nAppomPHPP5Qr5O0tQ+uxoRpPgfZq0z/cciuMs1NyZMzUO1lHFEGgb1+vfK/mKIVybygabvp
 0QFpRDNA==
X-Talos-CUID: =?us-ascii?q?9a23=3A10BVsGktB7OfrEqxuLkmGksLiR/XOVrd3Wr1Mmv?=
 =?us-ascii?q?pNXlwZpe/eGKTxKlaveM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AybQOHw3Wxl/qhDw5Vt/NazlQDTUjwoiIOEstqMs?=
 =?us-ascii?q?/+O6ECz17Bm+DlBeQXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770595200"; 
   d="scan'208";a="690841702"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Mar 2026 12:45:45 +0000
Received: from sjc-ads-3552.cisco.com (sjc-ads-3552.cisco.com [171.68.249.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 9806318000231
	for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 12:45:45 +0000 (GMT)
Received: by sjc-ads-3552.cisco.com (Postfix, from userid 1795984)
	id 3D4CBCC12B5; Sun, 15 Mar 2026 05:45:45 -0700 (PDT)
From: "Deepak Rathore" <deeratho@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][master][PATCH 0/4] Pull request (cover letter only)
Date: Sun, 15 Mar 2026 05:44:04 -0700
Message-Id: <20260315124408.2966368-1-deeratho@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
X-Outbound-SMTP-Client: 171.68.249.250, sjc-ads-3552.cisco.com
X-Outbound-Node: rcdn-l-core-07.cisco.com
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 14:26:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3462

From: Deepak Rathore <deeratho@cisco.com>

This series extends a set of SELinux recipes to support native and nativesdk
variants. These packages are needed as host or SDK artifacts in certain
dependency chains, where dependency resolution fails when only the target
variant exists.

None of the changes alter target package behavior; they solely enable the
required native/nativesdk build paths.

Testing:
  - Built each recipe as native/nativesdk on x86-64 with no errors.
  - Verified existing target builds are unaffected.

Deepak Rathore (4):
  checkpolicy: extend SELinux tooling for nativesdk builds
  libsepol: extend SELinux tooling for nativesdk builds
  selinux-python: extend SELinux tooling for native builds
  semodule-utils: extend SELinux tooling for nativesdk builds

Signed-off-by: Deepak Rathore <deeratho@cisco.com>
---
 recipes-security/selinux/checkpolicy_3.10.bb    | 2 +-
 recipes-security/selinux/libsepol_3.10.bb       | 2 +-
 recipes-security/selinux/selinux-python_3.10.bb | 1 +
 recipes-security/selinux/semodule-utils_3.10.bb | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.35.6

