Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A434BC3ABD8
	for <webhook@archiver.kernel.org>; Fri, 16 May 2025 13:54:35 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.13817.1747403672248422513
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 16 May 2025 06:54:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nEzYuGXJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0be50048eso2074812f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 16 May 2025 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747403671; x=1748008471; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D38l08rXNq/lbBy3q30dzIjF9rOne6As0lNv9T2r7jA=;
        b=nEzYuGXJLFR8eqTnxH0Wa/piKSB9hiYs4Kr25D5/nL468NI1a94hGBV4H7ARxHRTUg
         crN69OT0RADYbtDMgpqHgWLZ4KzbSt1CiAPbpwkima9If5k8NvvCF4ZYr4/vW8V7HTiB
         dXa7+N9SIn13BpHjI8cTsko59msu7C4FPkA1YTglLw0W8R3vL9o//Lfw3zIJhqAquzuG
         +7MHsXrHZJqcoXkzwk6IstYoZPqVvJtN2s0/4xDWYqbjNVJouDIVgCl/NfYRntbltu1b
         UCCIU5ibxkugu/ZSerLrdd5gLc65sg5d4IX/N6CMrWWwHAzMo4GTKz6t1IfS/CNHXS8W
         G6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747403671; x=1748008471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D38l08rXNq/lbBy3q30dzIjF9rOne6As0lNv9T2r7jA=;
        b=UWJzOFBEl6KIUp7Eq05UqBYAHTOA2Vav6Lr0032cpnKl44Lgg4glaLuAecWuP9YAmv
         XxpRM6qMOmKtsU6l2kh4x+1rHXMhh0AiOPio3HmoHXdkOc+EOkhurX5KxPGwZg+zjDrr
         rpwgNRpPrczSJkDK08rJr+cJayuxw5bV1VEfTWL4xrpfic2gyJtodz0Hyvjw/bTOaEyB
         oefzDYM3Smaj3VbUjtxAeknuaDdg2Y/CDbFpNqA8HXRJZ4wxyr4NC9Jzl4ljK2URhHpK
         HbnkUQ2Qj5U5K7zMcbRmn2u5L4JlGkKCpcID8MCEbfw7jH2h6F0+STL6Txy8ulN/7/1X
         8ydg==
X-Gm-Message-State: AOJu0YwhqnLPA0O68Jd/UDP9f3iZgtqpY7ALf7H8gc66Hqzd5X0UMgaF
	p3YaZ3J6WU2Sr6QwYGLdD5vOKpBXQqRH1PtmCEwN9yYtP4sHG9XUmP70I7QVtQ==
X-Gm-Gg: ASbGncunCjQQ5EVqepPqy1S32EdbyJBZdsCEIIxpoJgFu33jm8ZapCqDEDhRTCtZ0XO
	lDkLwgtMbw0LoQ0NX0g1OMrGDmK+O7bbVg3CW9CNxq12UAMleQh+gK2C9QFg6XeKN9FDsG+tw3g
	ydX5JFOfSPBY2pgJAVp0Z5jkkhTUJVZpdgYgyYhdO6DbxKBjmSrRdtS+WL53y+gMDxLeqLlg2qF
	vbflVsd+ZOKZboX9XdP1KJrLFUXqsYS3c3S1A+UcpYuQqY07eVPaxa7i0udvAm1xXTMFBZfUxUT
	fhx+OwRAHfJuzZ8wWKhwBg8QlQGMwTYixlC6jgnpZ7/M4UgAtMGxXHB1jKqqhYaQaPWGdkRUfdr
	IJ86/vROq
X-Google-Smtp-Source: AGHT+IFFg339EcqZyds9xdnrHBjmxADBeHqR4GYkbTnaJOURipImaXm2tcVGxyyEoKJK6gEtuKFqZw==
X-Received: by 2002:a5d:5f56:0:b0:3a3:6282:693c with SMTP id ffacd0b85a97d-3a362826b2amr1951255f8f.42.1747403670443;
        Fri, 16 May 2025 06:54:30 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca8caf0sm2898581f8f.82.2025.05.16.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 06:54:30 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [yocto-autobuilder2][PATCH] schedulers: set meta-webosose branch to scarthgap-webos for scarthgap builds
Date: Fri, 16 May 2025 15:54:27 +0200
Message-ID: <20250516135427.2540564-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 May 2025 13:54:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1559

From: Martin Jansa <martin.jansa@gmail.com>

* scarthgap based build was triggered today:
  https://autobuilder.yoctoproject.org/valkyrie/#/builders/51/builds/39

  but it failed, because it uses meta-webosose from master branch not scarthgap-webos, missing the 3 commits from:
  https://github.com/webosose/meta-webosose/compare/master...scarthgap-webos

* adjust branch_meta-webosose
* add entry for meta-qt6 like kirkstone build has (but this
  isn't really necessary as the 6.8.1 is the default)

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 schedulers.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 29e85ba..3f0289e 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -116,6 +116,8 @@ branchdefaults = {
         'branch_meta-ti': 'scarthgap',
         'branch_meta-virtualization': 'scarthgap',
         'branch_oecore': 'scarthgap',
+        'branch_meta-webosose': 'scarthgap-webos',
+        'branch_meta-qt6': '6.8.1',
     },
     'nanbield': {
         'branch': 'nanbield',

