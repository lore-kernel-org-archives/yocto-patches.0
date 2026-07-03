Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB3AC44508
	for <webhook@archiver.kernel.org>; Fri,  3 Jul 2026 00:46:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.83546.1783039586883424123
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Jul 2026 17:46:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6630kJ1C069650;
	Thu, 2 Jul 2026 19:46:22 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, frezidok1@gmail.com
Subject: [pseudo][PATCH 13/23] pseudo_util.c: strchr now returns const char
Date: Thu,  2 Jul 2026 19:46:08 -0500
Message-Id: <1783039578-31531-14-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1783039578-31531-1-git-send-email-mark.hatle@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 6630kJ1C069650
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jul 2026 00:46:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4378

Fix compile warning:
  pseudo_util.c: In function =E2=80=98pseudo_append_elements=E2=80=99:
  pseudo_util.c:896:30: warning: initialization discards =E2=80=98const=E2=
=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    896 |                 char *next =3D strchr(path, '/');
        |                              ^~~~~~
  pseudo_util.c:898:30: warning: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
    898 |                         next =3D strchr(path, '\0');
        |                              ^

Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 pseudo_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index 4c05394..3eaa9e6 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -893,7 +893,7 @@ pseudo_append_elements(char *newpath, char *root, siz=
e_t allocated, char **curre
 	while (path < (start + elen) && *path) {
 		size_t this_elen;
 		int leave_this =3D 0;
-		char *next =3D strchr(path, '/');
+		const char *next =3D strchr(path, '/');
 		if (!next) {
 			next =3D strchr(path, '\0');
 			leave_this =3D leave_last;
--=20
2.53.0


