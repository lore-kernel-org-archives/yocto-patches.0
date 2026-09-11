Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B23C88E5C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:30 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48566.1789157725554799908
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lpqPC+wq;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-939ebaf1956so114919185a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157724; x=1789762524; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Sgl6JPzjQcOAGoHISnhSuJ63ZqNjMyOqzm7x8j7NYBU=;
        b=lpqPC+wqKuHEZERBm4bmLwL0wYPxTyS8F9B4QvajURntYf4uNMjWRWXD1hDZSq7O44
         t81YKQqxl8uufwBVP8ILd5C1nbDH0s/+B4FvAdXHNS4ouEmHQ2ahyNQNj/hVGjxyPsHt
         VxSfm1pwwtKH1d/EMPkRFa9gb1MqvvaQReRSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157724; x=1789762524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Sgl6JPzjQcOAGoHISnhSuJ63ZqNjMyOqzm7x8j7NYBU=;
        b=XeH/BHsipo5eat0tZVovyePEEr5WVBvFXv8rbXI1rzPMlx1br2wUXI1sh3gyzlu4zR
         J+T6eGdCGhMgQzuzOMg2OoVpyC+mzHPH4a2Wh/1VdxvnqlcYlyoXJTgMsy2UNlYbinNd
         fOnzDaiMmMb5a+aZQzeztkBfF1UzgOFveRERpnTpdRwsa9LhsICeJg3BAvdpmWRsS4Kb
         1wzCE0tJoI/4vmHA6TbipkxSO6xumKkjEVqPMDoLdh95RODH8rQQM1oCv+u2E5Y/dRIy
         zvPzq/ghjLaezNVe1Vb9zm2zHlOPyR794mccKuhUAtHeHilOlUwLXIjqS7meUWO1yn8b
         mwMg==
X-Gm-Message-State: AFuF++nZtoz8XigU2roAWxkgdh3rTtlwJLs96ifF+vyO0BmK/AQIPygb
	wYrl/3SVGhWS/KlBhrfsbboSvAuHsgH7jckdcbTTnt009yYyHZaIHlAtfm5l4ZEo8AEiSGzGsEK
	L+B2G
X-Gm-Gg: AYBFou1agtUaytzpUYh2o25+HP4V8lpFCyh78arkKZ9UFEGtFZO1KW/MTdps5dfECSr
	AD2d4O/hFhTCfKZwqFDUf3IgPAUhWRkpRVKUyf+xD99xcvJY3RtMMmFaNwExh+z4WhaKXocGOir
	usi/9sYafbt60U1jh90yFBLJmj09wA4dkZsJExfMnL/cvq0TVQY4o4/On0sqtbKHbDOz/5dJsVE
	ffw+vf1qkvuuB36biWOzSn1WN+HmGGnjqYbGEsAzCd55jgjtnO+fME205arsEdYedNSMkIcnW1b
	YptXcaxpEBqAVNyjX6+3p8vcBUx+deW9/i1GeFS/edCBH37ib+5tS9eGeUgQTjR3LBmirh+KZgL
	W11+3r6bIFSMZBY9MvEdv8VpuEByRaBOeACLKlBhTSCPHotM8ell9907mfriHd4mi64dZdAVbqx
	FA2mjdEVPqgieiUheeMP+rRo9jupkVTZhcuqaO6gKjwR8m8jz7rxTwnhrVSJMsoiNQj0svGbxdF
	TTiKB8j7rtuRHT7nB75AOsS7mSQRQ4SOlPSIp2HHeKRoR9guR1RupMjqLDGluWy5fC8CMVuIyAa
	oFx3u1CjDnPYs6N2s3SnKU5OldV8cvNwYYI=
X-Received: by 2002:a05:620a:1b83:b0:934:ab73:ac53 with SMTP id af79cd13be357-939e9d64768mr824032685a.0.1789157723363;
        Fri, 11 Sep 2026 13:15:23 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:22 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 02/11] classes/ptest-cargo: use oe.path.join instead of os.path.join
Date: Fri, 11 Sep 2026 16:15:06 -0400
Message-ID: <acc10ab0cc1a69fe3ae056e10d8902e14943b171.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4807

From: Ross Burton <ross.burton@arm.com>

Use oe.path.join() to avoid having to strip leading slashes.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 147ec3334896dab9f2a341752528f80fe78d28b8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index 30463e1..f4c881c 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -85,7 +85,7 @@ python do_install_ptest_cargo() {
     cargo_test_binaries_file = d.getVar('CARGO_TEST_BINARIES_FILES')
     rust_test_args = d.getVar('RUST_TEST_ARGS') or ""
 
-    ptest_dir = os.path.join(dest_dir, ptest_path.lstrip('/'))
+    ptest_dir = oe.path.join(dest_dir, ptest_path)
     os.makedirs(ptest_dir, exist_ok=True)
 
     test_bins = []
-- 
2.55.0


