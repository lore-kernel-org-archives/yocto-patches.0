Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC36EB7EB3
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 08:40:52 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13913.1772613646412131706
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Mar 2026 00:40:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=LO4L+ygV;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B801F1A2B6B
	for <yocto-patches@lists.yoctoproject.org>; Wed,  4 Mar 2026 08:40:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89D305FF5C;
	Wed,  4 Mar 2026 08:40:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF3BD10369712;
	Wed,  4 Mar 2026 09:40:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772613644; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vlsDzi7u56iUaFQSZCxKTHGi5nb84FjuVk0SjLqYQH4=;
	b=LO4L+ygVcNVN9NiR9Nb6eVpM51kizkF4AGS4n8+HwzrDtZh9lI3L+61qmx6Hg62HCJi5rN
	fqDuWyezORHDWw/ifbAbH8l4bqpYhhR6YODTmfLp/2R9c5bWwZRZq/BokVAJmNLO0NAAlV
	sfuuQFZYxtTQ3sQZVK7vq9gGAPI0TSOoJtjTW8GXRT9QoDwn+VQ9D01/Hjy8rJ8IPeIHGS
	Hp7ObZcB7Rk4Oh5flJ16T0C9acYQ5MXSpOxgbU+XWyzHGy9afjqCKi4W+5wSVSX7M4z/0Z
	gfkN5xWlNcEm05SWX3/hDVjoMZKIBsuYtjK+fPjaMd1hIQ6UymdGMoxxMe/kMw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Mar 2026 09:40:36 +0100
Subject: [yocto-autobuilder-helper][PATCH 1/2] scripts/run-docs-build:
 build using generated releases.json
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-docs-gen-releases-json-v1-1-174049cbef87@bootlin.com>
References: <20260304-docs-gen-releases-json-v1-0-174049cbef87@bootlin.com>
In-Reply-To: <20260304-docs-gen-releases-json-v1-0-174049cbef87@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Nfih2G3f0QtUU8KzaQFkJ2w49ugpebygtX6mKgSPR5I=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpp/AKebdsk8wvXV7Lr+TfZJaDKsdiTlTlLL8j3
 k1urG/XDemJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaafwCgAKCRDRgEFAKaOo
 NnoBD/9LD9+kX5Dtg3eVs4IDPBlNALZr0zx3byR+oNoODzcy6SS/gnR70803RjJXYFIWXPlCmdo
 R8v0WqoOXsOvtsVTE2jUEMUvfK18G6c+OONCtbYaf5CrN3aa7s+7XeB4F3UUzJ/ltYQ78Zsqqos
 DMITsHMu9yxKlB2LEbBLgSHFmMrKjVGy1VIYCCeIMj+3I8l4MkBJQjEz40USKuw5BdeOym+oe/k
 XaHpyxD0qBNyBsAYSM9Ei5pXx5/Fqp31ZaNrcWL+a8mW7DRJAb+FnxlsB0tMu5DWYhkw+Pa+JJG
 G3RSfFsTOZ6/Sg6uJiMR4FhAUQUvfNNWCPR6ePXpXdMbiBiG+/vOEUhI6YE7DfLWMJnKTO6/EL/
 +TTZXMs00JpFnuoTEUBOP03rz6dAAk1ueA295SGMHSlLV7o3t8UAwUpMugBg1qMf5H/Ud6ubd8X
 qTDEriAECrhlISLjzM1Ez9Zb7FqJTikbhG/M7MBRLlqbst/m4xX0cfDrbx1Yb0x09RzkDVQqfm7
 L3nduc7bQLcD9gJW/cOjxZiVf/DA4VvN8gL3jbPIeTwidst+YQWTJnEvY7sLa+tHQY8v8BIOss+
 uHjxIA6Q/qa0/Z5gj1WUKs+Jh9wiKbdINx78dA0CAAhd87HG/6CltmLVPDoehWBfudnRPaQ8/QW
 bvZKdxsJdIZq9FQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 08:40:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3326

Generate the releases.json file using the release-parser.py script, and
copy this file to the documentation/ directory for each yocto-docs
build. It is then picked up by set_versions.py to determine the list of
currently active releases.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index 97c5d7a..b75799e 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -97,6 +97,10 @@ tar --exclude=eclipse -xJf ${docbookarchive_localpath}
 
 $scriptdir/docs_add_banner.py
 
+# generate the releases.json in PWD
+$scriptdir/release-parser.py $ypdocs/..
+cp releases.json "$builddir"
+
 cd $bbdocs
 mkdir $outputdir/bitbake
 
@@ -168,6 +172,7 @@ first_dunfell_sphinx_commit=c25fe058b88b893b0d146f3ed27320b47cdec236
 ypdocsbranch=$(git symbolic-ref -q --short HEAD || git rev-parse HEAD)
 
 git checkout origin/master set_versions.py
+cp "$builddir"/releases.json "$ypdocs"/
 #latest_tag=$(git tag --contains "$first_sphinx_commit" --contains "$first_dunfell_sphinx_commit" --sort="version:refname" 'yocto-*' | tail -1 | sed 's/yocto-//')
 latest_tag=$(./set_versions.py getlatest)
 git reset --hard
@@ -214,6 +219,10 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
             . $builddir/buildtools-old/environment-setup*
         fi
         make clean
+
+        # copy the previously generated releases.json here, which is then picked for the build
+        cp "$builddir"/releases.json "$ypdocs"/
+
         SPHINXOPTS="-j auto" make publish
     )
 

-- 
2.53.0


