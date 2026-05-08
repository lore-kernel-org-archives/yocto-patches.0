Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080AECD343F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:34 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4499.1778205625591351183
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UeAPRj62;
 spf=pass (domain: konsulko.com, ip: 209.85.214.179, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2baca78cfaaso8293585ad.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205625; x=1778810425; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mGQy1xFaFpNM7L42NkDqhikuDsQ9WFEZzYZmm7tPs0=;
        b=UeAPRj62lt9IjVmlkc+fPrrU3VKRK/ixdCCFY1vWWE40ZvoPqj0KDulfLpEINhucTf
         sNbY8ZML8xSppPYT0rG2xqT0OhgkRL6pkLLJd0KB7RvkRe0toWqNGEkvRUnJTm2HUVNX
         dvOtj/SdlRg2kLhljSpeyphytIblzbwp+p8nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205625; x=1778810425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3mGQy1xFaFpNM7L42NkDqhikuDsQ9WFEZzYZmm7tPs0=;
        b=bbLToTNP0njYmqqviF4Vhp2jmIxNQyGTj5ZYaBFN0kFwO8cd8TioLuAbmzJCzrABgK
         oVT7nYGRzzdEFv7Dj66ypKDrJ9XVNiaLCIq+1LGBvSiD00/D6RH/fFKrr5FVvtL91tZm
         pOwGzSg+b3B+xdeDEL5dvxAOIU25ojqpz8ynlFG5BfVoa85Joy7wi77oZQ4iVTEQZ1Dt
         ly+fyRxGGbMqs+dCJWIoR6e/IPR7nQE0m9CrHCz0Hq9VuczT1fhpbGOrCxp2Ssx+Mso5
         jegRnpGa3RdBLhwWPw7p8oPoANFn1F5+t+S3A7X0X98vkM4Ke4V+UD7Rg2JPDUJQkbGG
         lvVw==
X-Gm-Message-State: AOJu0YyKA3K1hGMljbMBS2r0Tmsq/mWO3nNCI5r9gaHKAVU65TcJ8erx
	dWg0M+vcmZJZZ8PDtYT3FWWp0KR5K9cEX9Jxrjo1UnVEQ3G5L+DGVhICOnkYmvHuRrPT6woKhWC
	FhgPt
X-Gm-Gg: Acq92OEo6aX1IpAFW+2+/cOJX0iSH7dahbfzTTsrRXliLqZPgrggxWs1LI2bkVCkYK5
	h0MFIbnLNR+4qGBoxyaeZeX8GDU8eY4E9vU4iKOwd8NtqxLZ+nck6/zXIwVLhbIcBBp66yGNFdQ
	HZ7tClsTBB0yw/hLFJEQwDE0h3lvs9qBiZaAeaqu44ETi084F1uFWRrS5MexXBmj6GUw3xrByRH
	DzqIMM7I3X4qcXET3n2hfNXrrjVlCw1IYRt8FlUMLDnjSW4oVH4eqRQdsmHKdNWHI4fAloDby0C
	4h3h0Lqcz0hihohp2kdty2A7yH5cLFeHHrZPBHLZlO5WMpQf+cAjcOYr+DW/6tVo1j5uJchlP81
	DxofGndnz11i7hJeCqOj5Do0zCOfujS/0+rgd5Kb38zLhxenfWi/fuZQj/ChxO55gFXw+CPucFc
	vEOx/Piq2HkVJj9eiNeXWbPa2wC+bdkeVKLSy5qohZziuM9yyqnq63Au+ALi4axX9nYL7NT43FT
	Q==
X-Received: by 2002:a17:903:3b87:b0:2b2:4ded:954e with SMTP id d9443c01a7336-2ba798d3e8emr102498405ad.24.1778205622902;
        Thu, 07 May 2026 19:00:22 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ead90asm1596345ad.72.2026.05.07.19.00.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:22 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH 3/4] config.py: add vcontainer-tests, vdkr-tests, vpdmn-tests builders
Date: Thu,  7 May 2026 19:00:05 -0700
Message-ID: <1842b2bb8bd1b7cc9b3bac7c5c8b3c40250281dd.1778202070.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202070.git.tim.orling@konsulko.com>
References: <cover.1778202070.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3937

From: Tim Orling <tim.orling@konsulko.com>

Register three builders that run the meta-virtualization pytest
suites against the SDK produced by vcontainer-tarball, so the test
coverage is exercised by the autobuilder without rebuilding
vcontainer-tarball for every run.

The -tests jobs need the same repo set as vcontainer-tarball
(baserepos plus meta-openembedded and meta-virtualization) so the
layer checkout on the worker matches what the SDK was built against,
and are tagged 'containers' for filtering alongside the other
container-related jobs.

AI-Generated: Claude Cowork Opus 4.7
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.py b/config.py
index e7f9619..4bd5819 100644
--- a/config.py
+++ b/config.py
@@ -37,6 +37,9 @@ buildertorepos = {
     "vcontainer-tarball": baserepos + ["meta-openembedded", "meta-virtualization"],
     "containers-meta-virt": baserepos + ["meta-openembedded", "meta-virtualization"],
     "containers-library": baserepos + ["meta-openembedded", "meta-virtualization", "meta-yocto-containers-demo"],
+    "vcontainer-tests": baserepos + ["meta-openembedded", "meta-virtualization"],
+    "vdkr-tests": baserepos + ["meta-openembedded", "meta-virtualization"],
+    "vpdmn-tests": baserepos + ["meta-openembedded", "meta-virtualization"],
     "default": baserepos
 }
 
@@ -168,6 +171,9 @@ builders_others = [
     "vcontainer-tarball",
     "containers-meta-virt",
     "containers-library",
+    "vcontainer-tests",
+    "vdkr-tests",
+    "vpdmn-tests",
 ] + old_arch_full
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -337,4 +343,7 @@ builder_tags = {
     "vcontainer-tarball": ["containers"],
     "containers-meta-virt": ["containers"],
     "containers-library": ["containers"],
+    "vcontainer-tests": ["containers"],
+    "vdkr-tests": ["containers"],
+    "vpdmn-tests": ["containers"],
 }
-- 
2.43.0


