Return-Path: <oe@myspectrum.nl>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C74AC369B2
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 16:07:29 +0000 (UTC)
Received: from outbound1.mail.transip.nl (outbound1.mail.transip.nl [149.210.149.72])
 by mx.groups.io with SMTP id smtpd.web11.12866.1744906044349052562
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 17 Apr 2025 09:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@myspectrum.nl header.s=transip-a header.b=q9rnpQYn;
 spf=pass (domain: myspectrum.nl, ip: 149.210.149.72, mailfrom: oe@myspectrum.nl)
Received: from submission8.mail.transip.nl (unknown [10.103.8.159])
	by outbound1.mail.transip.nl (Postfix) with ESMTP id 4ZdjTQ1gPkzRjTn;
	Thu, 17 Apr 2025 18:07:22 +0200 (CEST)
Received: from yellow.myspectrum.nl (yellow.myspectrum.nl [136.144.146.76])
	by submission8.mail.transip.nl (Postfix) with ESMTPSA id 4ZdjTP46Xpz2npc8w;
	Thu, 17 Apr 2025 18:07:21 +0200 (CEST)
Received: from yellow.myspectrum.nl (84-27-20-154.cable.dynamic.v4.ziggo.nl [84.27.20.154])
	(Authenticated sender: sendmail@myspectrum.nl)
	by yellow.myspectrum.nl (Postfix) with ESMTPSA id 19A59200E2;
	Thu, 17 Apr 2025 16:07:19 +0000 (UTC)
Authentication-Results: yellow.myspectrum.nl;
	auth=pass smtp.auth=sendmail@myspectrum.nl smtp.mailfrom=oe@myspectrum.nl
Received: by yellow.myspectrum.nl (sSMTP sendmail emulation); Thu, 17 Apr 2025 18:07:19 +0200
From: oe@myspectrum.nl
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@foundries.io>,
	Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: [meta-lts-mixins][kirkstone/go][PATCH] conf/layer: add scarthgap as compatible
Date: Thu, 17 Apr 2025 18:07:09 +0200
Message-ID: <20250417160709.3581248-1-oe@myspectrum.nl>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Scanned-By: ClueGetter at submission8.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=myspectrum.nl; t=1744906041; h=from:subject:to:cc:date:
 mime-version; bh=svxfxWYfh/npt3KIYTrmScKqQ/v5ofjBXusd5o7/hxk=;
 b=q9rnpQYnE3CEXsgP0DvXjqzzr9s6mZ3I9YiaPEOOhcvniPNF8KEGT9oB6JwQ12VQCSWE0w
 vK6juyJjiPadHLroxXfvVh07BSSOoxy1DDKpEVe9bBxNQPI+CC5y/4/xg5eSOF5m25iNXy
 e6edI8It8GMwCjDqC1tSVSjDitOGq6HUIrKCPYXU4tF8UxEQeKyoeoiYt2kGl9JAgN5aN8
 jTZ4GgoMguiLPHKCe1bbfqqLjiYyxAz+nMOQ8MF/O24uv4LgngljOKrmh0kvepVvCCwHPI
 cjw4N4r8zgiUplCMHvBzkb8k2E4TPx2ZGO+KSbfhL9WoTkQcBaraZrROTt502A==
X-Report-Abuse-To: abuse@transip.nl
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 17 Apr 2025 16:07:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1378

From: Jeroen Hofstee <jhofstee@victronenergy.com>

Scarthgap shipped go 1.22, which is now EOL since the release of
go 1.24. This adds scarthap as compatible to the kirkstone branch,
so a newer version of go can be compiled for that release as well.
While that is a bit mixing releases, that seems rather applicable
to this repository. Add a note to README that the kirkstone/go
branch is compatible with both.

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
---
 README          | 7 +++++++
 conf/layer.conf | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/README b/README
index d0b6bc4..b12c360 100644
--- a/README
+++ b/README
@@ -5,6 +5,13 @@ and officially Kirkstone supports only that. This thin s=
pecial-purpose mixin
 layer is meant to address this issue by backporting Go recipes from the =
master
 branch of openembedded-core.
=20
+A the time Scarthgap was released in April 2024, Go 1.22 was the latest =
version
+and officially Scarthgap supports only that. Since the branches for Kirk=
stone
+and Scarthgap would be the same and they are supported till April 2026, =
the
+kirkstone/go branch is marked as compatible with Scarthgap as well.
+
+NOTE: The branch name might be subject to change, especially after April=
 2026.
+
 The patches can be backport from openembedded-core with:
=20
  git -C ../openembedded-core format-patch --stdout -1 origin/master meta=
/recipes-devtools/go | \
diff --git a/conf/layer.conf b/conf/layer.conf
index 5d1b19f..30a0e00 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -8,7 +8,7 @@ BBFILE_COLLECTIONS +=3D "lts-go-mixin"
 BBFILE_PATTERN_lts-go-mixin :=3D "^${LAYERDIR}/"
 BBFILE_PRIORITY_lts-go-mixin =3D "6"
=20
-LAYERSERIES_COMPAT_lts-go-mixin =3D "kirkstone"
+LAYERSERIES_COMPAT_lts-go-mixin =3D "kirkstone scarthgap"
=20
 LAYERDEPENDS_lts-go-mixin =3D " \
     core \
--=20
2.43.0


