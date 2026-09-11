Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102FAC88E5D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:04:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.49580.1789160639797149374
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 14:03:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=t+whBPMZ;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A50EA2E96
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:55 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 070023F8C6
	for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 14:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789160639; bh=1Em1wPTPbmKAEbEUdss1V1iaRST5QrPf08DYQoI4kv4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=t+whBPMZBbNNEubvHP+dvjOyQh3+Lqfgbpn+Yx+X/MADpywzDYJTKb9RuRNWhVcze
	 pot/cVbE4EG6EpoPd5j4xWwNGS9nykEqdeSqPhyLK6qMZ0k9MlDSPPFsLFbJ4d2jmm
	 NpkKecURywYcPHAoB+9aGnpM0STPYefOWvnEon8Y=
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH][yocto-autobuilder-helper 8/8] dashboard/bugtriage: change Newcomer to show also bugs assigned to newcomer@
Date: Fri, 11 Sep 2026 22:03:51 +0100
Message-ID: <20260911210351.2020798-8-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911210351.2020798-1-ross.burton@arm.com>
References: <20260911210351.2020798-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 21:04:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4823

The current Newcomer section shows bugs that have been tagged with the
NEWCOMER whiteboard status. However there are also occasionally bugs
that are assigned to newcomer@ without that whiteboard status.

Construct a query using OR operators to match either bugs that have the
whiteboard status, or are assigned.  The OR operator is needed like,
where it effectively creates a group around assigned_to and
status_whiteboard, as otherwise all of the filters are considered to be
OR instead AND resulting in thousands of matches.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/dashboard/bugtriage/index.html | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/dashboard/bugtriage/index.html b/scripts/dashboard/b=
ugtriage/index.html
index c34fcaf3..73fb1317 100644
--- a/scripts/dashboard/bugtriage/index.html
+++ b/scripts/dashboard/bugtriage/index.html
@@ -773,7 +773,11 @@
           params =3D bugsByWhiteboard("AB-INT");
           break;
         case "#newcomer":
-          params =3D bugsByWhiteboard("NEWCOMER");
+          params =3D new BZSearch();
+          params.appendNotResolved();
+          params.appendOperator("OR");
+          params.appendQuery("status_whiteboard", "allwords", "NEWCOMER"=
);
+          params.appendQuery("assigned_to", "equals", "newcomer@yoctopro=
ject.org");
           break;
         case "#retest":
           params =3D bugsByWhiteboard("RETEST");
--=20
2.43.0


