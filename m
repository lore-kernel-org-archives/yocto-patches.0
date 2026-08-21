Return-Path: <alessio.bogani@elettra.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8847C5DF7D
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 20:17:26 +0000 (UTC)
Received: from eggs.elettra.eu (eggs.elettra.eu [140.105.207.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.886.1787343442739697773
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Aug 2026 13:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@elettra.eu header.s=esgkey1 header.b=m8hY5EAY;
 spf=pass (domain: elettra.eu, ip: 140.105.207.10, mailfrom: alessio.bogani@elettra.eu)
X-Envelope-From: <alessio.bogani@elettra.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elettra.eu;
	s=esgkey1; t=1787343440;
	bh=Q7DaCSGWvmWP1xu1Etc7oWC7+8GFXA2g1inhvt43Y6U=;
	h=From:To:Cc:Subject:Date:From;
	b=m8hY5EAYTriRt2kFac2fmaEG+f/0pBv5jSqj7ahTRakMRR5wdOYZRN8YEtr6IrF0r
	 jwmgu+jG49zIUV5Bpn3uLHYJb/CCLvLicic1ldzl+0o69TBS4AVfM1tuVX2d4TB0Qr
	 a73baXLKRRyuNhbL4ijg17UDlWjEzAUuQRKI1PNA=
Received: from zmp.elettra.eu (zmp.elettra.eu [140.105.206.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by eggs.elettra.eu (Postfix) with ESMTPS id 4hRWnD1y29zCF5P;
	Fri, 21 Aug 2026 22:17:20 +0200 (CEST)
Received: from zmp.elettra.eu (localhost [127.0.0.1])
	by zmp.elettra.eu (Postfix) with ESMTPS id A148B14A64FA;
	Fri, 21 Aug 2026 22:17:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmp.elettra.eu (Postfix) with ESMTP id 8FDDF14A6505;
	Fri, 21 Aug 2026 22:17:20 +0200 (CEST)
X-Virus-Scanned: amavis at zmp.elettra.eu
Received: from zmp.elettra.eu ([127.0.0.1])
 by localhost (zmp.elettra.eu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id ZgZUs9R5EaxB; Fri, 21 Aug 2026 22:17:20 +0200 (CEST)
Received: from nb-bogani.elettra.eu (ip238-103-231-195.pool-bba.aruba.it [195.231.103.238])
	by zmp.elettra.eu (Postfix) with ESMTPSA id 5CC4D14A64FA;
	Fri, 21 Aug 2026 22:17:20 +0200 (CEST)
From: alessio.bogani@elettra.eu
To: yocto-patches@lists.yoctoproject.org
Cc: Anuj Mittal <anuj.mittal@oss.qualcomm.com>,
	Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [meta-dpdk][wrynose][PATCH] dpdk/25.11: upgrade 25.11.2 -> 25.11.3
Date: Fri, 21 Aug 2026 22:17:15 +0200
Message-ID: <20260821201715.5391-1-alessio.bogani@elettra.eu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-elettra-Libra-ESVA-Information: Please contact elettra for more information
X-elettra-Libra-ESVA-ID: 4hRWnD1y29zCF5P
X-elettra-Libra-ESVA: No virus found
X-elettra-Libra-ESVA-From: alessio.bogani@elettra.eu
X-elettra-Libra-ESVA-Watermark: 1787948240.5429@laS1ZLas5xy62Ez4VsSiMQ
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Aug 2026 20:17:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4682

From: Alessio Igor Bogani <alessio.bogani@elettra.eu>

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 .../recipes-extended/dpdk/{dpdk_25.11.2.bb =3D> dpdk_25.11.3.bb}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-dpdk/recipes-extended/dpdk/{dpdk_25.11.2.bb =3D> dpdk_25.11.=
3.bb} (91%)

diff --git a/meta-dpdk/recipes-extended/dpdk/dpdk_25.11.2.bb b/meta-dpdk/=
recipes-extended/dpdk/dpdk_25.11.3.bb
similarity index 91%
rename from meta-dpdk/recipes-extended/dpdk/dpdk_25.11.2.bb
rename to meta-dpdk/recipes-extended/dpdk/dpdk_25.11.3.bb
index efe2ed583dcc..55314685a4e5 100644
--- a/meta-dpdk/recipes-extended/dpdk/dpdk_25.11.2.bb
+++ b/meta-dpdk/recipes-extended/dpdk/dpdk_25.11.3.bb
@@ -1,17 +1,17 @@
 include dpdk.inc
=20
 SRC_URI +=3D " file://0001-config-meson-get-cpu_instruction_set-from-mes=
on-opti.patch"
=20
 STABLE =3D "-stable"
 BRANCH =3D "25.11"
-SRCREV =3D "27757d03e981a1946434e9bf4c9cfb1ab7e03546"
+SRCREV =3D "4f6640ffddd528599c3cb8a62a701a1e4637f046"
=20
 PACKAGES =3D+ "${PN}-examples ${PN}-tools"
=20
 FILES:${PN} +=3D " ${bindir}/dpdk-testpmd \
 		 ${bindir}/dpdk-proc-info \
 		 ${libdir}/*.so* \
 		 ${libdir}/dpdk/pmds-26.0/*.so* \
 		 "
 FILES:${PN}-examples =3D " \
 	${prefix}/share/dpdk/examples/* \
--=20
2.43.0


