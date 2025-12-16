Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C13D609A7
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 15:13:26 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25101.1765898003834950089
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 07:13:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=v8kTGm2+;
 spf=pass (domain: baylibre.com, ip: 209.85.222.176, mailfrom: tgamblin@baylibre.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2a4b6876fso666499785a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765898002; x=1766502802; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XO0sveRFnXNf4iejdeBd3BPYK9a+8e3eBS2Xa0+FKE=;
        b=v8kTGm2+fxBN1mLeSKn9kBxADfKKXl3hhcCD270NJLr7x+S/TNKPtyITG2fhL0no4d
         8YBHsOM0FzWB9M2++g+JAwswSJWIHCMzBBt113iepwCEHrKCg7HVggsZcGITUwKgZsMl
         BSFswbC3rJcgkHxGb6vghsztxtHvdjdO4o78HytI2vwbOV/0ZhA5wbTsctHXyYcSojPy
         jih+qvpQhc/nI9hiMKPg84xVQIfLsqUyLc0Z6dehXjaqUxudl71YMscWk64lf3ELYZPA
         zSL6cZOG2mRx5dy1FLsDFNkglyrS+uSTOqHBz8TRaQxMTkjwtBz/ySBztnfeyfxFq8dH
         CHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898002; x=1766502802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XO0sveRFnXNf4iejdeBd3BPYK9a+8e3eBS2Xa0+FKE=;
        b=dgbL5024blAY+05z6Md1KBsdHf0b4s7nFLnxx3JRIV96FYy5HscPNu1WX0kYHkX5Sq
         eBzK2iVUKzvwoVR73O7jJ7SwxDEJJGbiLPgs49/bExXXY0BCyCmrGzCACV6GiB67DR6b
         9BVywZ82RFTGn4jMCYRvLhfsSYHyrP6SZgS3BHELfU++S2w0iHWvR9gH1Mi84BlQArIL
         zb757HA/fP3BJuPykXAuMI9XLogxhPOK9Aiv0gDh1n/GfKWsvvGjRy0gLqPlCzNGJaBS
         OeeSFC0aCrYUNQsbskynHg+ZzkIhwkH52jySlicYspcA88ZtZDBS+63ZhNXGNlz1bc+R
         EGVw==
X-Gm-Message-State: AOJu0YzVBbJc3lxl1IDyeyEcKsyUl8jITjSc4iF7bcsX1u2AQiytUK6L
	K141MFJCwCGQFa6h6XuP35IUwdA32wjgJ+7o9CorUJtua9sG2EKfQR0wWapuyg957DUNq/erzc5
	g3wkFWto=
X-Gm-Gg: AY/fxX5oHiVRGnWTKQbqcjU6CMKT6G/jjppIYYyIpKdYFOnSDI4kiIOiDawBZDE3pOT
	tWvf0GJqhrXKwlHGYxdcORb2ffJutb7y9QEcL0MApKBY+fd9TumoiBjI8GSX41MGOrCLt5MGUF/
	ZWYh/gQLAKaQvkxKtPYQWO2HPIStbzv9wdlik6B2fEKapB8+xmomKi+P+fyebY76Iilgwq6MefI
	B5U8amuWOUHiZE+BPw81mZvzp/YxIo9lXQbL00WEiVSNs+nGMOgfnCZHy1CjIAAGQH8myNpjPNH
	5TXIdwZcwCBZE4A0/uY8ANVIjJw+3wdJPEhTRXDsq0xBWDHAhSTT78cHIZYfkkg5M6FJSZofCNf
	zt6c8ErjPuk1DrF3CAM0DzFSVtsibXEp0ud7j5gjUvGFlzrcWLGjIp7UOUw8SFUJdlxXZMsu5bD
	x0CuxrRjR2rBY9xdQ=
X-Google-Smtp-Source: AGHT+IFQumWuzjHIGquTjTJ9twNNYkCTkYjSev26l4+KtbenwdHv0kea+DGhTNagb2DEs4CK7QgZXA==
X-Received: by 2002:a05:620a:170f:b0:8b9:fa6f:7e82 with SMTP id af79cd13be357-8bb3a384ac5mr2088811985a.73.1765898000712;
        Tue, 16 Dec 2025 07:13:20 -0800 (PST)
Received: from localhost ([2001:1970:3847:e000:8598:5636:16ad:2a8f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be303e7c37sm206800985a.2.2025.12.16.07.13.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:13:19 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-patches][yocto-autobuilder-helper][PATCH] config.json: add initial CI for meta-riscv
Date: Tue, 16 Dec 2025 10:13:18 -0500
Message-ID: <20251216151318.2550781-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 15:13:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2804

- add meta-riscv in repo-defaults
- add meta-riscv in check-layer-nightly

yocto-check-layer output:

|Reading sigs from: /home/tgamblin/yocto/openembedded-core/build-yfeC/locked-sigs.inc
|INFO: Adding layer meta-riscv
|INFO: Starting to analyze: meta-riscv
|INFO: Distro: nodistro
|INFO: ----------------------------------------------------------------------
|INFO: test_bsp_defines_machines (bsp.BSPCheckLayer)
|INFO:  ... ok
|INFO: test_bsp_no_set_machine (bsp.BSPCheckLayer)
|INFO:  ... ok
|INFO: test_machine_signatures (bsp.BSPCheckLayer)
|INFO:  ... skipped 'No machines set with --machines.'
|INFO: No machines set with --machines.
|INFO: test_machine_world (bsp.BSPCheckLayer)
|INFO:  ... skipped 'No machines set with --machines.'
|INFO: No machines set with --machines.
|INFO: test_layerseries_compat (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_parse (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_patches_upstream_status (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_readme (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_security (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_show_environment (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_signatures (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_world (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: test_world_inherit_class (common.CommonCheckLayer)
|INFO:  ... ok
|INFO: skipped "DistroCheckLayer: Layer meta-riscv isn't Distro one."
|INFO: ----------------------------------------------------------------------
|INFO: Ran 13 tests in 66.446s
|INFO: OK
|INFO:  (skipped=3)
|INFO:
|INFO: Summary of results:
|INFO:
|INFO: meta-riscv ... PASS

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 config.json | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 30d0d67..3229cde 100644
--- a/config.json
+++ b/config.json
@@ -1293,7 +1293,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom"],
+            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1337,6 +1337,10 @@
             "step10" : {
                 "shortname" : "Test meta-qcom YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom --no-auto-dependency"]
+            },
+            "step11" : {
+                "shortname" : "Test meta-riscv YP Compatibility",
+                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-riscv --no-auto-dependency"]
             }
         },
         "metrics" : {
@@ -1974,6 +1978,12 @@
             "revision" : "HEAD",
             "no-layer-add" : true
         },
+        "meta-riscv" : {
+            "url" : "https://github.com/riscv/meta-riscv",
+            "branch" : "master",
+            "revision" : "HEAD",
+            "no-layer-add" : true
+        },
         "auto-upgrade-helper" : {
             "url" : "git://git.yoctoproject.org/auto-upgrade-helper",
             "branch" : "master",
-- 
2.52.0


