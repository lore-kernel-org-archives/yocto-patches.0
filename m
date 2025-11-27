Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631B3CFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 16:40:38 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22651.1764261630588685851
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 08:40:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GGK98PNa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47796a837c7so6807645e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764261628; x=1764866428; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uK1kGhbC6dV6r/xiiKSL6gOcT10zQofpW1nLRNiYCmo=;
        b=GGK98PNamgZn0a7Vh3nze0yETI90nTkk5R8KUtbOc75OKzge+lGURQmdbbz5d8pdrx
         eIQmXRRCoYR8YpIqFtRg6xFV0aZ6k/tMAfqPnLM0W3uBn8hAy2GHkYMirpmIV7ZmCvt3
         7ZeAjn7K3jurL3BVq1mt7PUBKT73f36vVmFGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764261628; x=1764866428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uK1kGhbC6dV6r/xiiKSL6gOcT10zQofpW1nLRNiYCmo=;
        b=viAEjNgbGh6HgzihCOx5CmbQgR9QwTimKibLelPEUFMUQBreNv3y8GDPbwgSyeqeUN
         C5VwiO+ezgr+Snq3imQJVDqCu6aOEmQ4HWYdPyDO5PdO+biMSSO+X/t0rfRhn0zp57i3
         JMx1U61affqr3M+Yqr49rc62+uY6VTnolmgSjPfgvndQ6Plq1HEvN8unTls0ygYZHt+l
         8kOXkjFySDJVRg0iWSrTFCizq51A1JI2LeEvclv/iF8SaUsORDG6mv64cDCv32LdnKZv
         DLPu6eu7yLLmouoRVFB4QlneCQGzB7bz8CZiw9S5hkqGS24vhR3SNwdYKDUU9Y2gLfH4
         9swg==
X-Gm-Message-State: AOJu0Yw5h1JNCF0DDvTWsZABIBtBwUYUuPnx6b5uOo8swGAQsbvzOG+B
	WyH6ePZRjqrRg06Jcz1EIGX71BBDIqQ4bD4F9PCaVE4Yx83J6eioGfPbRY+eoBJqRpDM/icy4RG
	T5ICU
X-Gm-Gg: ASbGncum425ISLnyFejfHH9ifB9N2h5mO9cLrqt5703+twR+0SCtXaNM5BoIu2a7Hu7
	1DnmiEJbR+XZ1mEJZKdpDyJDT6Lptp0tpG3BRc1UrmNt7yD2Iy4cnWABaU010wIpkazCgCJBdAL
	8f76+RsQ8q5nsStXmHgAoyr70j6+t/3PV8gDj/ecwPK5MznYzeV/p3OJzT5yz5vNj3c85X1uJsH
	J/cpXSSNv+K66QIOfUoD3jMoOoi8iedUOWwAJcnjne4t4ovgmV8l67i72vaO3/lELhaY/IEuFNC
	LYwGkL+VXCj6iebYm6LQf5fs4huYt2jIjt+MEBPkWH81h9/cmfzeDxxorVciXI4a9wpDHbY4zQY
	LdZ2ZYo7eEEVQrli20ZZMU01seaPcDYppUFKrfa/2H6RZRh5OD/q5zT+l/SpVPV5DD/A6FdTqqh
	4Yhz3Hd92dY0rvY9iBldSksiu7SaOHMkCCNv0N3O17dTc8AdrQOA==
X-Google-Smtp-Source: AGHT+IGJXt/Eg3wP5HUGCMm0Ghp/Mt/Fj/7mJvj7H6ejFDYzOhQ88Nn+T7LOOq5aBu7mDGPpd5oBcA==
X-Received: by 2002:a05:600c:3b09:b0:477:a3f9:fda5 with SMTP id 5b1f17b1804b1-477c016e425mr188804605e9.9.1764261628327;
        Thu, 27 Nov 2025 08:40:28 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:49e4:7f15:9d56:4465])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47911143a16sm39884605e9.1.2025.11.27.08.40.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:40:27 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/getproperties: Fix to handled detached head states
Date: Thu, 27 Nov 2025 16:40:26 +0000
Message-ID: <20251127164026.853181-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 16:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2721

Now that we have a whinlatter branch, we're seeing HEAD being reported instead
of the real branch name. For some reason buildbot leaves the tree in a detached
head state even though the revisions match and this doesn't work with rev-parse.

Try using name-rev instead (thanks Mathieu for the pointer).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/getproperties.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 5c342c7..a0175c2 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -21,7 +21,7 @@ def get_revision(repopath):
     return subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repopath).decode('utf-8').strip()
 
 def get_branch(repopath):
-   return subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"], cwd=repopath).decode('utf-8').strip()
+   return subprocess.check_output(["git", "name-rev", "--name-only", "HEAD"], cwd=repopath).decode('utf-8').strip()
 
 jsonprops = {}
 jsonprops['commit_yocto-autobuilder-helper'] = get_revision(builddir + "/../yocto-autobuilder-helper/")

