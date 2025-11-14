Return-Path: <louis.rannou@semalibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15917CDE03F
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 08:30:18 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13405.1763109008212660662
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 00:30:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: no key for signature: lookup dkim._domainkey.semalibre.com on 100.100.100.100:53: no such host" header.i=@semalibre.com header.s=dkim header.b=JPcRjTuR;
 spf=pass (domain: semalibre.com, ip: 185.246.84.56, mailfrom: louis.rannou@semalibre.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E29841A1AA0
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 08:30:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0F606060E;
	Fri, 14 Nov 2025 08:30:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A193D102F2A6F;
	Fri, 14 Nov 2025 09:30:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=semalibre.com;
	s=dkim; t=1763109006;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RNNcmG4myTCZPic1yoKp5tCVBbEMcOT6jC1/vtBkGu4=;
	b=JPcRjTuR3/2tzoFuK5bRR66FL8GVLE3zzB6eW+3jsgns4RlNPY/QUO6dhIuhOFyLsXDZYi
	RtwRP6UmgsTQkixVfpRglC4DAzpFkpb/4xfwJnkkf1fPu7+hHijVB/M0foS6lwkSVl9csF
	HO441gr+/orcWC1I7EUk7GLjqDbIxLQGitsvi3+KRBUyznCSzgqDFFMYqQ0bRIta2in5ee
	HxRZSxmDt7SpLnKO+mp6AkyySShe5qFY4X60WShOtm27/drMkzsBmqo1JkeEHU7Y8ajMiA
	gFb2zrppD8GwgClpMJyqSz5EejpkEJ4KM6nUbryhk0yQjrICLK7NDApDdji29Q==
From: Louis Rannou <louis.rannou@semalibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	rybczynska@gmail.com,
	pascal.eberhard@non.se.com,
	yi.zhao@windriver.com,
	Louis Rannou <louis.rannou@non.se.com>
Subject: [meta-security][PATCH 4/4] openscap: fix musl compatibility
Date: Fri, 14 Nov 2025 09:29:50 +0100
Message-ID: <20251114-openscap_bump-v1-4-1c8169b8e332@non.se.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 08:30:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2557

From: Louis Rannou <louis.rannou@non.se.com>

Add the dependency to musl-fts and the link flag for compliance with the =
musl C library.

The link flag is prepended. For some reason, probably a compliance issue =
with CMake, the
link can't be made if appended.

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
 recipes-compliance/openscap/openscap_1.4.2.bb                        | 3=
 +++
 recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb | 2=
 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-compliance/openscap/openscap_1.4.2.bb b/recipes-comp=
liance/openscap/openscap_1.4.2.bb
index f7c7aec..bf38e12 100644
--- a/recipes-compliance/openscap/openscap_1.4.2.bb
+++ b/recipes-compliance/openscap/openscap_1.4.2.bb
@@ -67,3 +67,6 @@ FILES:${PN} +=3D "${PYTHON_SITEPACKAGES_DIR}"
 RDEPENDS:${PN} =3D "libxml2 python3-core libgcc bash"
 RDEPENDS:${PN}:class-target =3D "libxml2 python3-core libgcc bash os-rel=
ease"
 BBCLASSEXTEND =3D "native"
+
+DEPENDS:append:libc-musl =3D " fts"
+OECMAKE_C_LINK_FLAGS:prepend:libc-musl =3D " -lfts "
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0=
.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1=
.78.bb
index 8489218..94415c4 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.b=
b
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.b=
b
@@ -42,5 +42,3 @@ do_install:append() {
 FILES:${PN} +=3D "${datadir}/xml ${datadir}/openscap"
=20
 RDEPENDS:${PN} =3D "openscap"
-
-COMPATIBLE_HOST:libc-musl =3D "null"

--=20
2.43.0

