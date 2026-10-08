Return-Path: <alessio.bogani@elettra.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF5CA600A
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 08:18:28 +0000 (UTC)
Received: from eggs.elettra.eu (eggs.elettra.eu [140.105.207.10])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10687.1791447499881670233
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 08 Oct 2026 01:18:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@elettra.eu header.s=esgkey1 header.b=KmVUdBJB;
 spf=pass (domain: elettra.eu, ip: 140.105.207.10, mailfrom: alessio.bogani@elettra.eu)
X-Envelope-From: <alessio.bogani@elettra.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elettra.eu;
	s=esgkey1; t=1791447495;
	bh=3k5xPlyiqL96il615VuBcZmaBCfEbNCuk4zko3XkPKg=;
	h=From:To:Cc:Subject:Date:From;
	b=KmVUdBJBoK5f1Irm1JdUTNuAtE3RwWffiV1EAe7YryRD8tijM9lnMtrTGE+aDmkb9
	 bWX0On6J7QUdnFuxXN15Uk9u0Hr7HtR4hkKJhVLwFNSkvCY+mO2hPoQneQjniVjZwu
	 tdxcHUz7OJ77UHumDxywoDiJ/0AmVKeAYP1esEFg=
Received: from zmp.elettra.eu (zmp.elettra.eu [140.105.206.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by eggs.elettra.eu (Postfix) with ESMTPS id 4j0jYM5hKjzC5YL;
	Thu,  8 Oct 2026 10:18:15 +0200 (CEST)
Received: from zmp.elettra.eu (localhost [127.0.0.1])
	by zmp.elettra.eu (Postfix) with ESMTPS id 4E28E14A6508;
	Thu,  8 Oct 2026 10:18:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmp.elettra.eu (Postfix) with ESMTP id 3E0CA14AA8BC;
	Thu,  8 Oct 2026 10:18:17 +0200 (CEST)
X-Virus-Scanned: amavis at zmp.elettra.eu
Received: from zmp.elettra.eu ([127.0.0.1])
 by localhost (zmp.elettra.eu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id iVPLEmWse_dv; Thu,  8 Oct 2026 10:18:17 +0200 (CEST)
Received: from voltumna.elettra.trieste.it (voltumna.elettra.eu [192.168.205.44])
	by zmp.elettra.eu (Postfix) with ESMTPSA id 2A1CE14A6508;
	Thu,  8 Oct 2026 10:18:17 +0200 (CEST)
From: alessio.bogani@elettra.eu
To: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Cc: yocto-patches@lists.yoctoproject.org,
	Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH] dpdk/25.11: upgrade 25.11.2 -> 25.11.3
Date: Thu,  8 Oct 2026 10:18:06 +0200
Message-ID: <20261008081806.705443-1-alessio.bogani@elettra.eu>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-elettra-Libra-ESVA-Information: Please contact elettra for more information
X-elettra-Libra-ESVA-ID: 4j0jYM5hKjzC5YL
X-elettra-Libra-ESVA: No virus found
X-elettra-Libra-ESVA-From: alessio.bogani@elettra.eu
X-elettra-Libra-ESVA-Watermark: 1792052296.19327@AjqeNitabn6pbti0Rmv0EQ
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 08 Oct 2026 08:18:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4995

From: Alessio Igor Bogani <alessio.bogani@elettra.eu>

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 recipes-extended/dpdk/{dpdk_25.11.2.bb =3D> dpdk_25.11.3.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-extended/dpdk/{dpdk_25.11.2.bb =3D> dpdk_25.11.3.bb} (91%=
)

diff --git a/recipes-extended/dpdk/dpdk_25.11.2.bb b/recipes-extended/dpd=
k/dpdk_25.11.3.bb
similarity index 91%
rename from recipes-extended/dpdk/dpdk_25.11.2.bb
rename to recipes-extended/dpdk/dpdk_25.11.3.bb
index efe2ed5..5531468 100644
--- a/recipes-extended/dpdk/dpdk_25.11.2.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.3.bb
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


