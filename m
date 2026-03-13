Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E6105A586
	for <webhook@archiver.kernel.org>; Fri, 13 Mar 2026 00:23:48 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5224.1773361424733263364
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Mar 2026 17:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Dq5v+sg6;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so13014475e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 17:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773361422; x=1773966222; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihUc7uuBHPu4tQ3dVYQTyL9RnO0C1I9oOSPPrN2h/90=;
        b=Dq5v+sg6JwhHzZHNWgGGbmUgI3smxAg6cW1Y+NDsmaMN1VggPzfpd7acQfsjWM/36U
         7Dg4Q/0MOcAVTSq3sM/ZQsM/5OC6UOsrae7of5KlBU/TUHQ4ozYKsv3qiJXvYyMyJl2p
         l1XbYeuICbLYKPEszS5cPDEW/0h4NhEYQcSWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361422; x=1773966222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihUc7uuBHPu4tQ3dVYQTyL9RnO0C1I9oOSPPrN2h/90=;
        b=gjGa+v5QiBMtTKUH0u8+c5/ntGHZMRkkqiox9Wt08QQIIHwsZtCnciNvH++sdPUFfg
         orN3d0du936emRA9EPvCTfTG//B0ueEU+exkx8DiKBVmqp5EWASwJzrqMYP1Mkb8inZl
         ZTzri31yrZ5IsdnWdLGfmXHd1CAi+xitHPQLlsnkpoK8C6q7UPoSrxjGpmMVAilE7d3K
         h2RC4wsUS85yaycQvU0Y6EQTdZF97nOmIym5rWHAOwNgjGUjXWCzkjUVji5vv4iiRf51
         H9iwwRj/kOppFtwWpUj1IsPX+hRZsTEN+qjObk42N8s4HbvyCWg2gtsS+rP2wnas9cG4
         FMnw==
X-Gm-Message-State: AOJu0YzIcrOxj5dtUhMHXNBpersQ3uhGOzGQjn2oA+xshxHIjNBPAeEv
	n+uiqo1Q8mIzUJQc7mGouPTsxFhNCiGt4I2hM9y75ISRdpeDpWt9QsWc3dxZs2TtyBmY7ND2/pO
	Awi3R
X-Gm-Gg: ATEYQzxo06BebWcKXNrUAHmBE/SuvkFdoHuakxt9H3jxrV/E5/Re8fUMAo+4axUOCLp
	HKYbst0js8XcDrgA+ZpPDIkfio+4mM61Esj7m4e1C4CJGvdgqt+eV/vfYK8l7HsytifqndE80Sz
	AbLzzCDlvh9h46YWzacuWKjViTosCJXqO6wJkofMJmb+oBK4xOCtuHfBDknYpKUPk8S30JeAqHO
	c5I74vV8o55iabWH9qIA+bi9uS6FXyaUcR1tPR/pNEge/mN3v+QwZpSP8oLT/dDNKJS6o7aQuxt
	Dpbz3HTWJE6SCvhU33EmzpV34EE/wWb8GEUO+85JXySAKAcfdP+numTSSeRQBsXtFV0Yc40Ece+
	cxNxgxmQa2YczAXpozHwExcFA3pwGBQN6rrUfjUUncZT5CT6KC9FoY40FKjpoTfBZSdKvTflf6i
	KUgoX5RpaR0XH1UdGrlCFSKJVq+5ANa9R7IFty0jpUkHorfukvzvk1Za8qg318o5nwWUCb85mlu
	rLsNRFqFEb2wdlEK4k5IuFLSndemarfwoyaTcc=
X-Received: by 2002:a05:600c:3489:b0:485:4972:35b with SMTP id 5b1f17b1804b1-485566dd5c7mr18461785e9.14.1773361422255;
        Thu, 12 Mar 2026 17:23:42 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a9a19e6457d4ef2f.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a9a1:9e64:57d4:ef2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c7c514sm5996655e9.32.2026.03.12.17.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:23:41 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [yocto-autobuilder-helper][PATCH] release-parser: Add release maintainer info
Date: Fri, 13 Mar 2026 01:22:50 +0100
Message-ID: <20260313002249.756178-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Mar 2026 00:23:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3451

From: Yoann Congal <yoann.congal@smile.fr>

The contributor guide[0] states:
> The list of stable branches along with the status and maintainer for
> each branch can be obtained from the Releases[1] page.
But this info is not currently present.

To add it to the Release page we need to add it to releases.json first.

(Partial) output looks like:
$ jq 'map({release_codename, maintainer})' releases.json
[
  {
    "release_codename": "Wrynose",
    "maintainer": "Richard Purdie <richard.purdie@linuxfoundation.org>"
  },
  {
    "release_codename": "Whinlatter",
    "maintainer": "Yoann Congal <yoann.congal@smile.fr>"
  },
  {
    "release_codename": "Walnascar",
    "maintainer": "N/A"
  },
...
  {
    "release_codename": "Scarthgap",
    "maintainer": "Yoann Congal <yoann.congal@smile.fr>"
  },
...
  {
    "release_codename": "Kirkstone",
    "maintainer": "Yoann Congal <yoann.congal@smile.fr>"
  },
  {
    "release_codename": "Honister",
    "maintainer": "N/A"
  },
...

[0]: https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html#submitting-changes-to-stable-release-branches
[1]: https://www.yoctoproject.org/development/releases/

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/release-parser.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/release-parser.py b/scripts/release-parser.py
index e07fd71..a3b1cea 100755
--- a/scripts/release-parser.py
+++ b/scripts/release-parser.py
@@ -19,9 +19,12 @@ SUPPORTED_RELEASES = {
      "yocto-5.0": "LTS until Apr. 2028",
      "yocto-5.3": "Stable Release until May 2026",
 }
+
 CURRENT_ACTIVE_DEV_CODENAME = "Wrynose"
 CURRENT_ACTIVE_DEV_VERSION = "6.0"
+CURRENT_ACTIVE_DEV_MAINTAINER = "Richard Purdie <richard.purdie@linuxfoundation.org>"
 CURRENT_STABLE_BRANCH = "5.3"
+CURRENT_STABLE_MAINTAINER = "Yoann Congal <yoann.congal@smile.fr>"
 
 repo = Repo(GIT_REPO)
 
@@ -89,6 +92,7 @@ def get_git_tags():
             release_notes = ""
 
         status = SUPPORTED_RELEASES.get(branch, "EOL")
+        maintainer = CURRENT_STABLE_MAINTAINER if branch in SUPPORTED_RELEASES else "N/A"
 
         # Create a dictionary for the series entry
         tag_dict = {
@@ -101,6 +105,7 @@ def get_git_tags():
             "status": status,
             "download": download,
             "release_notes": release_notes,
+            "maintainer": maintainer
         }
         tag_list.append(tag_dict)
 
@@ -120,6 +125,7 @@ tags.append(
         "releases" : list(e.name for e in filter(lambda e: e.name.startswith(CURRENT_ACTIVE_DEV_VERSION), repo.tags)),
         "status": "Active Development",
         "download": "",
+        "maintainer": CURRENT_ACTIVE_DEV_MAINTAINER,
     }
 )
 

