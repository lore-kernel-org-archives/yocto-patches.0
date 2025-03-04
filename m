Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8286C021B8
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 17:55:56 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.28559.1741110947730134756
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Mar 2025 09:55:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Q7WpnNoS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3910e101d0fso1645045f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Mar 2025 09:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741110946; x=1741715746; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDEucZ5AF7GL0V67NfLdPqWTd5OX1cu9Gx6tal+JX1E=;
        b=Q7WpnNoS/AG1wXGEe/hXhaZa+euTQM9hkJMUeqJ1Zw4egKxLAKeu3llSc+6fXFyfZR
         egaWdV2BOHe/WHTha7Ez/j/m0NeQ6tE286lPZt/c5vczMXZ7nH8wWgL7B8BQ8xuqiIdn
         foKd6ADfiSGJ3A26M9e5OCFDdH2W/XprENO2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110946; x=1741715746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDEucZ5AF7GL0V67NfLdPqWTd5OX1cu9Gx6tal+JX1E=;
        b=NwIVpqX8XOAHBrBPID8TWTKvA1+0KqyGJLeB9thqAUDw/EkqAktcfE2sr6cxS4y2GM
         TuRXzqKjK2TlRZOhstAYPVK1PDQjfGK9HGgf0nM3xMEr3dniNmJvp+XZkQl1B3u5OWqE
         QrpMz3n086xmnvBdAngYP2WRLQUXsjI3CPQidPJNWTevJQ4CTQRDPiLzJYGHO0xuHnaD
         XdAkqztL5Aql8bDe30R7c4kUx8KF1fZgv7JA3fgv+M47oLb41HONZ8Nc7bVulhOjqWv9
         jaay0S5+FwSqGXKMnNkWB5Q9/o/BXL/kceON3sJ0PJeCKkdV46vchVy//L1ABMBocHwB
         nGOg==
X-Gm-Message-State: AOJu0YyWcggMzTARtS/Tc0qphNQYyJNXuyXdgJHrl++w1ScuPLdhox+Q
	AKsWCwp7vg7xnEKaYi1rtOriBibCxFWE4okakWomdimuxiC6o13y2D3JUhCeqXmm47eoxOZN/sU
	p
X-Gm-Gg: ASbGnct+Ylk5PfNG21/2ADukgxrbUgAKHx4mf9h1w/O/fMZwraYGYru9Eam551yInYp
	gIfxf1/ZMCRT9OBHkEDV5f4esIe6gdrHRM95SCcjHvb5APVYVWAMsAPnS2kvzTyF/GhDpDA6JOb
	Q38r4ioi8d6U9X6Qe2hNnG62y204iVn6X/UI/9kWwM0KUbB2ePlCWdJG0BDLjMHv/+D6jYbA+GC
	SQkh5VhukNl/G/h1cTdXSMOb498oqXORbETR++O8JStQmcK62cMX7qNLc3gwouHD6iQyhhhnEff
	as6eMqePT79ratnIVwPRkdr/sLkb0+RVEa7BKBnqQr4iwJnyGza/bXImruNmdlAp2YonW1YriQ=
	=
X-Google-Smtp-Source: AGHT+IGfpw/0lvTREQjvlPr8OwrTZ0TyiszCgeU2H7/cPVq274j4Eliu+q1vgzeBZaMu/ds4aZDCWA==
X-Received: by 2002:a05:6000:21c6:b0:390:fd23:c145 with SMTP id ffacd0b85a97d-390fd23c2c2mr6900103f8f.36.1741110945484;
        Tue, 04 Mar 2025 09:55:45 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bea3:48e1:f1c0:6abe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e46f580bsm18075744f8f.0.2025.03.04.09.55.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:55:44 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/release-parser: Add list of release version to release series information
Date: Tue,  4 Mar 2025 17:55:43 +0000
Message-ID: <20250304175544.1956335-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Mar 2025 17:55:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1141

It would be useful to know the list of releases in each release series
so add this information to releases.json. Also add milestone informaiton
for the current development branch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/release-parser.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index 321bd58..e024bad 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -10,11 +10,11 @@ from collections import defaultdict
 import datetime
 import semver
 
-GIT_REPO = "~/git/poky"
+GIT_REPO = "~/Repos/poky"
 
+repo = Repo(GIT_REPO)
 
 def get_git_tags():
-    repo = Repo(GIT_REPO)
     tagmap = {}
     for t in repo.tags:
         tagmap.setdefault(repo.commit(t), []).append(t)
@@ -53,6 +53,7 @@ def get_git_tags():
                 return semver.VersionInfo.parse(tag + ".0")
 
         tag_names = [parse(re.sub(r"yocto-", "", e.name)) for e in tags]
+        tag_strings = [re.sub(r"yocto-", "", e.name) for e in tags]
 
         if len(tag_names) == 1:
             latest_tag = repo.tags[
@@ -87,13 +88,14 @@ def get_git_tags():
         if branch == "yocto-5.1":
             status = "Stable Release"
 
-        # Create a dictionary for the tag
+        # Create a dictionary for the series entry
         tag_dict = {
             "series_version": re.sub(r"[^\d\.]", "", tags[0].name),
             "original_release_date": tags[0].commit.committed_datetime.isoformat(),
             "latest_release_date": latest_tag.commit.committed_datetime.isoformat(),
             "release_codename": convert_name(tags[0]),
             "latest_tag": str(max(tag_names)),
+            "releases": tag_strings,
             "status": status,
             "download": download,
             "release_notes": release_notes,
@@ -113,6 +115,7 @@ tags.append(
         "latest_release_date": "",
         "release_codename": "Walnascar",
         "latest_tag": "",
+        "releases" : list(e.name for e in filter(lambda e: e.name.startswith("5.2"), repo.tags)),
         "status": "Active Development",
         "download": "",
     }

