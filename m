Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D54CCAC5AE
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 16:47:36 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.102.1758905248834117061
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 09:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JhTUWkYA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so23036795e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758905247; x=1759510047; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt4HtHTTeGV5Yuhmd21gGjOHJp8cba1UpL8SF8ktlHQ=;
        b=JhTUWkYAM4Pv7GziyxNLKFMGRxodFKEzgyLh8SykopwsIgcTUaNTPMHRkL99F8pk40
         Va/yUYWnyBeDwIcRgYHBbuZRw59yUGOh+ImP9xPBOXEPXRdbdE9A/VNzNxgtlgFY9Sde
         DLDai982/M1Wd7oFko89n0AyMlm3tRvuXbJUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905247; x=1759510047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt4HtHTTeGV5Yuhmd21gGjOHJp8cba1UpL8SF8ktlHQ=;
        b=TkP1tNSMkosLusOElU3jzQRk77A3+cdwp8qgc5JRwKD6QvzwwPI0/ciK1Eiw8xEPqz
         Jwyjxp+hqLFe4svChzP141YcdUg6R/3WYnn+uk25osTkz34m/xUqWMBWd6hqRMcOtDIJ
         FSPjZ5vqagDSxiYjsrAzd7IMNrbmIxCb9dey/fuFtlbhW8osW0qDbiiMH4yrNZpMYYbU
         a8oj8sSAh2qw5Bhp0PStPo8UFvVEgOi+TjNkETU2u6Eb31UfstwcK/nK3qMexdyPveAA
         apqfLXuNgUaEKMXEjzjs3I/u7PFf8FzJy2mu8pDQjQxOK4tOH8NQTkkdCUqGehgWq89S
         UgWQ==
X-Gm-Message-State: AOJu0Yzab4ed2+pW5vz1Ao9Y0alJJc0FDL8/J0xtI1vzVA8LeVhVJwfA
	ZllAFvaMxbyN7MomKb5T9ZGh0Pk9rYfRIEVy0QOJLUt19vSooTZHp/J9JOg6hJAycVCFMtwDgMM
	5z6FG
X-Gm-Gg: ASbGncspd9lVn+QVIGhSuHMUNvQy6w9COJ8CeLIARq6xu7pvitb7h8SeTF2Kn+O3utk
	rraJqXWnupv4MQZ9B1Pv3LzCHB7GI6JdKnkSPcnPMmUas0svVC8TXK8im99fM52E+p2lTMRw03N
	NRKAJm/Uz70Yw23GRPx/3PpzC1nBWiD2mXZ2GCzqTDcZ1uJ05Q2cSvbY3QnPtfaeneR7fpPs+sM
	iHua/g/XD6VikOxIifc95iyZXUmtK0qsYsPzBoi/21b0x0vrbgrUZ3FiygmrU8Ri0HHdqCyZX1X
	pilZs1Ul+aPCgBbT1pxIj9pBjmYUP3vXARk61NJObMYx5DgJih5B2wNDO9S134MJQE/152gXitg
	LHEh0JKKCzhYe2zHLWR60cWEjZd69uYlnTqcwpE7lIxLZygIPAqg=
X-Google-Smtp-Source: AGHT+IHHNdUdAzl1GuzlYL12dkGu4Nrk4gfIZYz7f1tkZPqhB8Z4KjJYCLZMVZ1b5D2qVz72NwByxQ==
X-Received: by 2002:a05:600c:4982:b0:46e:1b89:77e5 with SMTP id 5b1f17b1804b1-46e329bb52emr54521225e9.12.1758905246591;
        Fri, 26 Sep 2025 09:47:26 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm121268465e9.11.2025.09.26.09.47.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:47:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts: Add bitbake-setup repo filtering for migration
Date: Fri, 26 Sep 2025 17:47:24 +0100
Message-ID: <20250926164724.30475-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 16:47:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2239

In order to allow bitbake-setup builds to co-exist with older poky ones,
we need to add the bitbake repository to the layers present in the builds.

For older branches, add a workaround to filter the layerinfo.json file so
the right information is presented in older builds but newer ones can
work for bitbake-setup too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/prepare-shared-repos | 2 ++
 scripts/send_qa_email.py     | 2 ++
 scripts/shared-repo-unpack   | 2 ++
 scripts/utils.py             | 8 ++++++++
 4 files changed, 14 insertions(+)

diff --git a/scripts/prepare-shared-repos b/scripts/prepare-shared-repos
index 3d10af4..a510a4f 100755
--- a/scripts/prepare-shared-repos
+++ b/scripts/prepare-shared-repos
@@ -38,6 +38,8 @@ ourconfig = utils.loadconfig()
 with open(args.repojson) as f:
     repos = json.load(f)
 
+utils.filterrepojson(repos)
+
 stashdir = utils.getconfig("REPO_STASH_DIR", ourconfig)
 
 with tempfile.TemporaryDirectory(prefix="shared-repo-temp-", dir="/home/pokybuild/tmp") as tempdir:
diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 9e539a0..7ab9f3c 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -131,6 +131,8 @@ def send_qa_email():
     with open(args.repojson) as f:
         repos = json.load(f)
 
+    utils.filterrepojson(repos)
+
     resulttool = os.path.dirname(args.repojson) + "/build/scripts/resulttool"
     querytool = os.path.dirname(args.repojson) + "/build/scripts/yocto_testresults_query.py"
 
diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
index 8e7ec95..be47eec 100755
--- a/scripts/shared-repo-unpack
+++ b/scripts/shared-repo-unpack
@@ -49,6 +49,8 @@ needrepos = utils.getconfigvar("NEEDREPOS", ourconfig, args.target, None)
 with open(args.repojson) as f:
     repos = json.load(f)
 
+utils.filterrepojson(repos)
+
 targetsubdir = args.abworkdir + "/repos"
 needrepos_baseddirs = [r.split('/')[0] for r in needrepos]
 for repo in sorted(repos.keys()):
diff --git a/scripts/utils.py b/scripts/utils.py
index 2902dfa..6a0302a 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -297,6 +297,14 @@ def publishrepo(clonedir, repo, publishdir):
     mkdir(publishdir)
     subprocess.check_call("rsync -av " + archive_name + "* " + publishdir, shell=True, cwd=sharedrepo)
 
+# The repo json needs to be filtered to allow builds with and without bitbake-setup
+def filterrepojson(data):
+    # If bitbake and poky are present, we should use poky and ignore bitbake
+    # If oecore is there, it is a-full or a-quick so don't do that
+    if "bitbake" in data and "poky" in data and "oecore" not in data:
+        del data["bitbake"]
+    return
+
 def mkdir(path):
     try:
         os.makedirs(path)

