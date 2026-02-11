Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D1CECD6F8
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 23:15:20 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32708.1770851718607852623
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Feb 2026 15:15:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gj7na0V0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.43, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e64657f0cso245421e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 15:15:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770851716; cv=none;
        d=google.com; s=arc-20240605;
        b=EyGkwbU5Tp79Kqx46PDdjxaQ1HQm53U0peE5zv/TgUxAmTfxSRVUbibSnQ2VWIRae4
         Fzy66m5lia9f/kPkRi4WLuyT6sOgLp6ETZLKQpmqzkVhcWnjLvmMWAR4k2C7ryWy9iZA
         zkRrveL87YQB03XJsY8Jo2BVZBs1bywVThkFdbd+whVxbN2+JbPSwgdz+6fTHz03z810
         nWxeb0k1MEYNe0eP6Oei+Wb48Uxudk09YB4Zh70DVdZiTqo/ZL2X/rvTGQazKgxXoYlP
         N4JGIJYZG1crhI5h700M9UtSgxA9GVHIPw+dw8Gy2Wz9HuVi6MaJa9A+0lzG/Pc1/nEy
         llvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tALcIb+zEpc76ZMMcfjpzO36QXhHPTDsf2PjRL1Am6Y=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=JL/R0W0VvkoLiiTN1D2MphVayDsjrHUAsv4yWY8U52OtzxxvH/4IzlTRY4UBSC7nRD
         XGDNpn7UXMvYzV4CCv34MjXXT2B74MEWLhqmuOtDGAxow5veqmLazNAS2nrfgNsGAk77
         Xe8jEkBw+J1MNPQ/voVDPl+dZjm0mwY5gzLDDPBHBNr5xnRZ1F3JrhuBipe53DtbVmFW
         qHgEyPc4CRVYDZwQ+HwvfRCdmRSAznQYidDxG0O2r8OJU6e5ITDK+B2J5NCf63D1wgpD
         6HmYtLPmAXSuxbFC0UDrtRZENYw3RBVqFsquMNjKdC8BK5C3bqHBmv2o9qnsx6dsVQ9S
         s0hw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770851716; x=1771456516; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tALcIb+zEpc76ZMMcfjpzO36QXhHPTDsf2PjRL1Am6Y=;
        b=gj7na0V0FLv7MQ91fsXLHeDechQplbiHXmDoDEf0qILbMJ61h+Y4OapQtNvjXEQuEs
         qwL9tSBmzWF+frQkt3mOLYSMWflUCTuFBqgLH6rYbPp1X1BXr3rYFEARJSg1pFxTi3gB
         hVyaQMlfsDj2jmH6MdLr/HwN+RhIRv60DX7ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770851716; x=1771456516;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tALcIb+zEpc76ZMMcfjpzO36QXhHPTDsf2PjRL1Am6Y=;
        b=bk9tsopSA0ASHVwMTWXie0jywaZOhmApl9cO+hN02B6hPsjX43VIGme62uxTa3Yvw2
         a/n74zwX4DBzxLQnVvBu81hYUs7bcHrogzIL+NyE1aBzK7MNZ4NSaC6XLfn3YAQT+CX1
         uKlz3lC70S7OYSyTrQqpTqlacWphJ2ranVJiYjaPDOPhNxXpUrZc4FZjjrGJ9/6p78nW
         BJyL18gDhpZQrWHdU71M1Y3irPikJwta9f08NOxmW2BglmaAURNrt7lBryzAB7+0hSUb
         CNAhwZ4083X6jwyw/l3BxduPFXf0CuSIxNeD0Zwnh0y13n9CA6keG4PNHXq5mSHTpOph
         yjfA==
X-Gm-Message-State: AOJu0YwDd3WEXONGJNzpNvfl34t+mA3dJGyb0XeIRSV/uEvdcUvWkoWU
	gjiFLoY3xjZ2m6GT+8F3DdhXWuIU2sw8yrfjhRqn9HPtiWrC8nNV/o+K24OtWHNris6Ep20kgUa
	3WPvTHfcY0uMpS757FakfEB5Aj7N63pq45ODSonzZq+Rdi8l6T/e9aBosiA==
X-Gm-Gg: AZuq6aIiltDUXbIGwhYjWoZLyockN3TNfmOo+g0LjxX+pqNoh58mtpywTDxtHhzOMA8
	x/tmFP3Ybay7oeG56o4fp76QteiUhfT6ZOiR8ZnT6+dX9ps+AOxim+We3JIm4jV6az5aWTU029m
	Ge1tbi6MII9AlZN/zRG9Md4OUNZWWxMkIq3uDDVd2pSSNk1mZ6MKN/Xx+vwJb+5qnDLjf3LWS7z
	IUEhQHBGJCjlELZXTjSl7qtnJGYyVe8KuGhJufcMb6HaIrAVQ2CUs9g7BIzt6Nap619iQOfrz3t
	sxkf5LDZ8okos6s95mgJ
X-Received: by 2002:a05:6512:4023:b0:59e:49fe:2cb3 with SMTP id
 2adb3069b0e04-59e64016da7mr270085e87.15.1770851715783; Wed, 11 Feb 2026
 15:15:15 -0800 (PST)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Wed, 11 Feb 2026 15:15:04 -0800
X-Gm-Features: AZwV_QiSvGAbo7-Ysdt_h9Xj5jD9hpXon4dmJJJAzBYn_D7jQKPgf_Vka31bPNE
Message-ID: <CADfgfoYh2fpNkSNTE5V3W0Eyq4vNARvw+1ZcHAvrpMwASibkDQ@mail.gmail.com>
Subject: [yocto-autobuilder-helper][PATCH] scripts/release-parser: remove poky
 repo add wrynose branch
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Feb 2026 23:15:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3218

Remove references to the deprecated poky repository. Use meta-yocto for
tag data instead. Update to include the 6.0 branch.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 scripts/release-parser.py | 12 ++++++------
 scripts/run-gitstats      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 21a6d57..079bada 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -10,7 +10,7 @@ from collections import defaultdict
 import datetime
 import semver

-GIT_REPO = "~/git/mirror/poky"
+GIT_REPO = "~/git/mirror/meta-yocto"

 repo = Repo(GIT_REPO)

@@ -66,7 +66,7 @@ def get_git_tags():
         if (
             tags[-1].commit.committed_datetime
             >= repo.commit(
-                "73f103bf9b2cdf985464dc53bf4f1cfd71d4531f"
+                "7e35b0bea7f052d38768c4df655065dc43c691b8"
             ).committed_datetime
         ):
             download =
"https://downloads.yoctoproject.org/releases/yocto/{}".format(
@@ -83,8 +83,8 @@ def get_git_tags():
             status = "LTS until Apr. 2026"
         if branch == "yocto-5.0":
             status = "LTS until Apr. 2028"
-        if branch == "yocto-5.2":
-            status = "Stable Release until Nov 2025"
+        if branch == "yocto-5.3":
+            status = "Stable Release until May 2026"

         # Create a dictionary for the series entry
         tag_dict = {
@@ -108,10 +108,10 @@ tags = sorted(get_git_tags(), key=lambda x:
x["original_release_date"], reverse=

 tags.append(
     {
-        "series_version": "5.3",
+        "series_version": "6.0",
         "original_release_date": "",
         "latest_release_date": "",
-        "release_codename": "Whinlatter",
+        "release_codename": "Wrynose",
         "latest_tag": "",
         "releases" : list(e.name for e in filter(lambda e:
e.name.startswith("5.3"), repo.tags)),
         "status": "Active Development",
diff --git a/scripts/run-gitstats b/scripts/run-gitstats
index 5009122..05b13d0 100755
--- a/scripts/run-gitstats
+++ b/scripts/run-gitstats
@@ -17,7 +17,7 @@ dest=${DEST:-docs@docs.yoctoproject.org:dashboard/gitstats}

 cd $builddir
 mkdir gitstats
-gitstats ~/git/mirror/poky $builddir/gitstats/poky > /dev/null
+gitstats ~/git/mirror/meta-yocto $builddir/gitstats/meta-yocto > /dev/null
 gitstats ~/git/mirror/oecore $builddir/gitstats/oecore > /dev/null
 gitstats ~/git/mirror/bitbake $builddir/gitstats/bitbake > /dev/null
 gitstats ~/git/mirror/meta-openembedded
$builddir/gitstats/meta-openembedded > /dev/null
-- 
2.52.0

-- 
Michael Halstead
Linux Foundation / Yocto Project
Staff IT Engineer

