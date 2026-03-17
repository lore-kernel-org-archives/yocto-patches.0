Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A8FD8765
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 12:35:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.74879.1773750905059845600
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 05:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=pJb4CWVH;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8BD7E1A2E5D
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61DE15FC9A
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1E55104504C0;
	Tue, 17 Mar 2026 13:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773750902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I2QIYM3aCx/Zhcabu5XHUA6R+3bJckslrMTS+VDXEI0=;
	b=pJb4CWVH4OIntrDv8Y4VQZwWOkYY58BhEdK+bpOv0CwtjuAXkgJq2FSJbkG/i9zX42s/fs
	22azgeLLVKiSclfq4KtiSgMDuwM9FUQBcN9cUIbkYJ2G3jfZR7WNZzCov71nVzgpQhULkW
	exYX/22epYbExgumGAZTpBiAFi/5PwowxxXf4JANayocvWuMUbjxzeLgNGEPyrl6HBxgkg
	F1/gQ4+Vh4a0/5CpbNhXDGsP9+CLMFGaoElLPzepGOOu1MOFaEh9SaigPiytyEucTLVpyK
	UwiwFWhvjzRiuzV6/eF5NRO2lFccyJdM3ybrXdjVoS1lKJUt8A6E3ZOj9SimKg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Mar 2026 13:34:55 +0100
Subject: [yocto-autobuilder-helper][PATCH 3/3] scripts/run-docs-build: copy
 the releases.json file for the bitbake build
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-fix-releases-json-generation-v1-3-f57f3267c88a@bootlin.com>
References: <20260317-fix-releases-json-generation-v1-0-f57f3267c88a@bootlin.com>
In-Reply-To: <20260317-fix-releases-json-generation-v1-0-f57f3267c88a@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=903;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=6Nj+3doZHy90Sl8Rdv7NrAx0Ki/+cShLYi6PTuXEioY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuUpzkIRBJE0PMkZgtrIf3hQ9XLWQVbtn5mGy3
 ildrAXm2K2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCablKcwAKCRDRgEFAKaOo
 NlVHEACrL6x2bvgdPSHaOZdiVdCHvWL8Mkidw40PeZg6w2hvZU1JZR3AYNV6AoAw+ShNoK6/V11
 sNLqgY6U+EoW8fkx+XEd9b2giNlOfgBo/+7EL/TDP1apNVkoDKdCgeXTR2jt0/h5J0iieovYhrJ
 Oh6ZCbJ9NnUJFG1oGleqpvTrEcsTPVhGFbWVt2EZixGdywC6GaGbaIeqdpGrQjQfrMVbLn1Robk
 dwE7lMIv+uTnX5igb0BXlTDGCcCkcqoQ6nqWcjzqJSJ2LNo2KsT9lW8BdwhHqVY7vbWylKKwjMz
 T5vsgrV7M+RDPdamkPDdZdQH8I7b2jTAvqYMard4QsvyIRdteJ052hJZmisqaW7FeKU3vrecpgx
 3ly9OYK45aBQMkWfuCWKq7ST2eaQswtmiTz/ku5hObpNkWM0rlH2KYHDgJ/H5yvko5viYUkbiDx
 YeaXtYb/Q79V/rlFaTgmnfZ5kTsfV6ccmvnD6+c8YrCym2Ph12wz8JPeCvXLe+v4m+ARLOM9fkT
 sNCoD9adPuqlPoFBbdovC0lIXzj1cjks9fJkD7uzJRvdCEeB+7ALqdEzH71t9+Y364J6SRknEUU
 vlzNQWgokXcSY3OR0NzCzEAsT6qYoFePHW0+Q1ijGWw13UHLnYvi52wDZj+t6dVA++bAAXA2tN9
 DJIi8PNrPdba3UQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 12:35:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3487

After [1] we are now using the releases.json file to determine the
active releases for the bitbake docs build. Avoid fetching it for each
build by copying the pre-generated version in the documentation
directory.

[1]: https://git.openembedded.org/bitbake/commit/?id=b55497ab7e29eec398fe52359878a76b185e1af0

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 scripts/run-docs-build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/run-docs-build b/scripts/run-docs-build
index a58abe1..cc902c6 100755
--- a/scripts/run-docs-build
+++ b/scripts/run-docs-build
@@ -133,6 +133,7 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
     (
         . $builddir/buildtools/environment-setup*
         make clean
+        cp "$builddir"/releases.json "$bbdocs"/
         SPHINXOPTS="-j auto" make publish
     )
 

-- 
2.53.0


