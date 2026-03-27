Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0858310BA453
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 09:02:42 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67765.1774602159445925057
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Mar 2026 02:02:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZTpBg49W;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.172, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a43f1f978so15981551fa.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 02:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774602157; cv=none;
        d=google.com; s=arc-20240605;
        b=Ol4HwIln6f5FSiJIgQAypuNAyND3ePrfFegVYRex2yxBl48pCewU8yc/9KnW8jsN6Y
         bxiGu8bbdbJiAAoFJhrI+1C+MbR4YQcQlXgUYWMVWEZ+cJxY8iXaT5b1A61q0WnPam0d
         ElUec5xEtdpU4WU9hpVkvIqMEgTSd7lsT+adGBhow1dJD3YQpZ1tmpNs5OYl9XoZqC0U
         MNSojjXohKhJMQ5uZdC99GPetWEy1fxonZ36dG+bimhoLR6PdROKCUc+HaDx1qNd+fSS
         h2HUi47KYTY6iISkBj2L/+icoYon7hsp+lE7Lk1iVn48bUqn4cvSCi/QNs5gElpPAw+j
         v8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=k1rOq810XSJvqC38Q23Ez2z0xBqOIK2+aeKCK18D4tU=;
        fh=4b3BekqI4JqHH0Gqdmw4gGoVIY9TbySxoCdU/kazmAM=;
        b=XH8M24vdigwoKk7HcrR/fSpQqB+cAO4rE7mnFMzzFxRmX8hAT/ouEMbx8mzCFoExFG
         OpT/OdPEhdHF/2tYymrSH5tsY6WKOvyZPkW0MzvlSWer5HTdb9pUZqpb34EqoGyxM1DQ
         eonijdDM96HEPQ/i5O7dNdxi3XPLsPJjc6pp6MUO9DwpgUhBnNADBl1E40sYCY0fJ7wF
         md/HOXRi9yug8IoiB2L+73wGTLXuXRZLLT5QSBX1msYJQswxZ5f/FzQL/gXEpLmMhB4e
         HFgxR+N8S4YnXwopUWLPaaDqey/1PbaMKJqduzP208+eoJWYOhLzf27qNoTXKOBnGUJH
         s5BA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774602157; x=1775206957; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k1rOq810XSJvqC38Q23Ez2z0xBqOIK2+aeKCK18D4tU=;
        b=ZTpBg49WUltEaB1sgJSaMtRtm/6RRZxvIEZdwn8LQfK69GzP7sSgAU7epnBmn1rqRK
         1FlzwCju/zfin+tjRfondbfuQ6qADpUNVeDafwc7UtyODMtPTHZU8k+xm0XrccUquT3k
         98HJK6JsKB8nhTTwRcp3lfikg3ZC7UWv228Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774602157; x=1775206957;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1rOq810XSJvqC38Q23Ez2z0xBqOIK2+aeKCK18D4tU=;
        b=hdm8LoLLzhF5L5BzBL//JhhmEgyzK27IoJRYQFn1xyqnUzK9izY+jPDoxDBgfWrBAN
         wXG+0EB+dWFgXYKL5oCFxXWx3iAgEwH18/z2kxsZmZoB8hYQ24Ur0TO3xv7/6zd/MAuI
         hpq/ZYx3yiH/h1f1C0co2/Ojkm9CppgP7VYqTRWhlZXZ+Lh9oKPd+bcPzZHx61P8naG8
         xwoWCMvxjOj+eLg53r4/x0hVTVzrhkpgYV36w/LRlIlrcOSAL89VV5Fp36LhWHa55ny2
         MCFfoF3P5YuI9TWoFfF5CeZOwL1qpqANOyUeDBJEB/ReRJ9h9GjzDIvGKiKodfrcLd/E
         A/mw==
X-Gm-Message-State: AOJu0YyntiPQwDO+fXyh/kgVpXR0/gJfQihLwMkvgYh8jM36lCiC4bFp
	bUJxKadggrzMBaaSoJGkYAyIXxGzcMsMFm/pqKmbxxqCsTMCYeu2KL5kALrNOMil207wT0bGye1
	co5Un53ZejK3HSuTfrXxpD7A/jAGrXxw5rHLs6cGaQwFTFmxozn4XR7V44w==
X-Gm-Gg: ATEYQzw/yvZIZc79Q+2w8sgb4mr1YO7pU5RByLHpr4Np8Id92Q3Td4QCvJMOr7v4fsW
	nOPAci2xUI+J2rNqu26tBlwOT7N10/AjjVn3o6+Zcix6bvUv08ku3DfU6KeYsxe5vx/xFP1eeRv
	5KdNfTughyBxmas4i4xWGGFQgPPA8TsEPE1wtt7BYjMfo508M/x1w3ykDsHc33pGzsB2WhfjLq5
	fVbHBFVxMKrQJAeOJX139XA8d6yIM6YsAUzBD4hAt0WQoH8L6gIlDybJiKSUZKqCeTD+VMuHqvh
	vCvUI/KK79SsLHoaQ8v3
X-Received: by 2002:a05:651c:f04:b0:38c:6b42:3d77 with SMTP id
 38308e7fff4ca-38c73065ecamr5821981fa.2.1774602156693; Fri, 27 Mar 2026
 02:02:36 -0700 (PDT)
MIME-Version: 1.0
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 27 Mar 2026 02:02:25 -0700
X-Gm-Features: AQROBzDjVzM2DffmIwsGToCCVq3yQcRabY7-sPw40j0CLyZ8ul_V-DxNxVohVmA
Message-ID: <CADfgfoYKSrRf0KHeds+NQ2rmFUc4PTgW9n8nPiWeRrG4Jzi4iQ@mail.gmail.com>
Subject: [yocto-autobuilder-helper][PATCH 2/2] scripts/release-parser: use
 argparse for argument handling
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	Antonin Godard <antonin.godard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Mar 2026 09:02:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3564

scripts/release-parser: use argparse for argument handling

Replace raw sys.argv access with argparse so that usage and help text
are printed when the script is called without the required arguments.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 scripts/release-parser.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 9e5bc6a..2aedeb2 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python3

+import argparse
 import json
 import re
 import semver
@@ -7,10 +8,15 @@ import sys

 from git import Repo

-# this is the repository where we fetch most of our tag data
-GIT_REPO = sys.argv[1]
-# the bitbake repository is used to associate bitbake versions to them
-BITBAKE_REPO = sys.argv[2]
+parser = argparse.ArgumentParser(
+    description="Parse Yocto Project release tags and generate releases.json"
+)
+parser.add_argument("docs_repo", help="Path to the yocto-docs git repository")
+parser.add_argument("bitbake_repo", help="Path to the bitbake git repository")
+args = parser.parse_args()
+
+GIT_REPO = args.docs_repo
+BITBAKE_REPO = args.bitbake_repo

 print(f"Reading tag information in {GIT_REPO}")

-- 
2.53.0


-- 
Michael Halstead
Linux Foundation / Yocto Project
Staff IT Engineer

