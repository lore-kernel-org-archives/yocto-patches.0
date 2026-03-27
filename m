Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F0910BA452
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 09:01:52 +0000 (UTC)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68743.1774602101758369354
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 02:01:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d7qf3Fck;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.176, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38ad26e3992so14564961fa.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 02:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774602099; cv=none;
        d=google.com; s=arc-20240605;
        b=lNqJGG6Vw8IcWMn6H11f+KnB9nf3KyOLd9NXr73S81CXQMuWGfNLKzFKueNbH4gOO2
         wL6gxgsPMqGohdVp34DKC+yz5cl9N7t9ndS2LGQqDfu89fHey+39uWzY9F7A+rkRoFCw
         8CsKx3k6zXkRYo4nx7bDP0OIG4kakiPiFo+n83HZkdum10DFvmi2ZZsKiDS0v4rMad9f
         U0ydLZcD6BvqxAO3Aw0aa352mLCWGCMdOf/4mZXiW29TS/QwbEyFzSeub7F54+9cv+DJ
         KVbC2adwMJa0DR/OAl97eRbY82IiLaYfajq8/bU9h56jwISqbg9D/Ae9Um2yBx7y0GvX
         Od+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8O+BezZm+VNAj2OQof8Iwqq1QNpqdDmLFZCyd3fKYl4=;
        fh=4b3BekqI4JqHH0Gqdmw4gGoVIY9TbySxoCdU/kazmAM=;
        b=fgziHTKb172zSgf2dJvPeFqsq8tgWZSg5pwsL52kODnNYYuTUSF72NdkogmxWuYyjJ
         MK86fyc1ao8czRGQkACHzFRI6/uimvQPm2otB2rPsmNEUWlTB7A+5qqQmszLNDuu4GPa
         qRQdu5lnJ4HUmoXw8AsAXQqb6e03Rc+Mk0jwkQ6tU7AvUxzGhpRvZPK/oWd7SiZqUqfr
         EK9WG73p+bN/7qcb/JiS+Pej7gH89D+oVvwkv71yPMGUwMQ2fMJokwQi0IN3CvxFpjwH
         MUeOUhzIWHfd79PUt/JqGMrOub0krteo3xOLMakSN3Olc5ZgaOXZyU39lOy+D4Fo2RAr
         3LhQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774602099; x=1775206899; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8O+BezZm+VNAj2OQof8Iwqq1QNpqdDmLFZCyd3fKYl4=;
        b=d7qf3FckFdjYZquDgOgP3hXYD+r6rnBlMRVqJU18Fv76BGDopx3hjxvLB+Bzkp+ONq
         P250Ngdb7BHWclDYT+WxGJrN2jOUsU+pZyqLrYz/1SeNOWyBIp09aTYuBT7dFkbLwHfH
         3j+tUC3pF2x5vu2mS29Jw4eCX/qjtlKzwCmu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774602099; x=1775206899;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8O+BezZm+VNAj2OQof8Iwqq1QNpqdDmLFZCyd3fKYl4=;
        b=lmpRm7xmFcnV4nOTMEEu6NVrRkGgkOTdHYiqGgJpp5lBTLpnh7ovfvFuSlI6CFsmMZ
         qQ3CoipGzc+jKiiwwoeAaVkQuKfPedamLYVpIAQxXirQRhSYVOetC1JfUe/7mhFpOzmD
         NLsHxSLpq3bLz2alzI2RmlWLW6Hp+aRGBXjo3En7FbLm2YzsWUegYKt8fx6AGSk5WY3s
         rC3BmjZS/aM66NTAcNI5ZGuTNEwVXT5Vjy7LOZMRed7FQCTwA2t7htutX2ATm0O4aL7S
         mZdCnn3CgBgxhB6amWO4MkafR9qnQJWbPUgWuZ/dZhiMWu4brSwB+GcyhpN00Gor5u49
         ESSA==
X-Gm-Message-State: AOJu0YwvZaZXaVJr9Zvl+ErmO2KZfapjYojC1BD06MX0HhkoXx48qMku
	BYWv8tw6fX59OoRkKmTVXFxRRkVjrmOu4p3DGTRfL74oA9bYsLaiJGY0utCUroIg3keUiPeIntW
	l5HDVtz9fCZhh0qjdjq1ywqmXUeUhROeJBLXZyKdB/nPLh449FwSi5c/qDg==
X-Gm-Gg: ATEYQzwNA9zzYY6tM64rIBVznxwdRTJ5VVz70+nks0jdWae0MlRQs9nSSheIXG+a/om
	p+li8PDsRLR4oFiexTvRiA0DNbtvp5LoHQuEZEb5cpIHc2pDCRszoGR54q+WLTEsOGuiDJCnpzk
	1V39rkFQxo1udsDtyEmhNqFNZLHYIQFN92bR2WEc9wpnq2+aFT0CYWcWEe2Yutn5jmI5eqFCNJE
	JHtxDwgApF/3vNxOE/C9hNRC1inIDre1Ipry13Q5yx7ooIlyrDB5WcxUehbQUM0FkIak9ng8dK8
	LbIWq2bD8HvshPIsq1EqIISWSwbRq/s=
X-Received: by 2002:a2e:8a94:0:b0:38a:3bfe:3c5a with SMTP id
 38308e7fff4ca-38c730c49bemr5467571fa.5.1774602097858; Fri, 27 Mar 2026
 02:01:37 -0700 (PDT)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 27 Mar 2026 02:01:26 -0700
X-Gm-Features: AQROBzATOWx_lI9UYhtR60h5aFaK6D0-tS7auJy8WCGRqp3RwDnmZmRxgtlK_W8
Message-ID: <CADfgfob4zA_PEyt2L5BrLfNeB-CGBGtfA_-kER2RHRiHE0nzeA@mail.gmail.com>
Subject: [yocto-autobuilder-helper][PATCH 1/2] scripts/release-parser: derive
 codename from branch instead of branch tags
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Antonin Godard <antonin.godard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 09:01:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3563

scripts/release-parser: derive codename from branch instead of branch tags

Branch tags (e.g. kirkstone-4.0.34) that duplicate yocto-* tags are
being removed from all repositories. Derive the release codename from
the remote branch that contains the tagged commit instead of relying
on sibling branch tags.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 scripts/release-parser.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index a38824f..9e5bc6a 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -59,15 +59,16 @@ def get_bitbake_mapping(yocto_tag: str) -> str:
     return branches[0].strip().replace("origin/", "")

 def get_git_tags():
-    tagmap = {}
-    for t in repo.tags:
-        tagmap.setdefault(repo.commit(t), []).append(t)
-
     def convert_name(tag):
-        tags = tagmap[tag.commit]
-        for t in tags:
-            if "yocto" not in t.name and ".rc" not in t.name:
-                return "".join(filter(str.isalpha, t.name)).capitalize()
+        branches = repo.git.branch(
+            "--remotes",
+            "--sort=creatordate",
+            "--contains", tag.commit.hexsha,
+        ).splitlines()
+        for b in branches:
+            b = b.strip().replace("origin/", "").replace("* ", "")
+            if b.isalpha() and b not in ("master", "main"):
+                return b.capitalize()
         return "BranchMissing"

     tags = list(filter(lambda e: "yocto" in e.name, repo.tags))
-- 
2.53.0


-- 
Michael Halstead
Linux Foundation / Yocto Project
Staff IT Engineer

