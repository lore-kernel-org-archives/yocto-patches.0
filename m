Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA419C3ABA3
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:22 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web10.4607.1746132074194888368
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FEa7zRQz;
 spf=pass (domain: konsulko.com, ip: 209.85.160.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47ae894e9b7so28105701cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132073; x=1746736873; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EesNc6moi2ahl6UcCjD3bnzV1tPTsrTxS0+iWoj2t08=;
        b=FEa7zRQzerzTJZzfhcy9ON5oGU+6L8XrEihWHyHJVErph097TOavqyQFU+15qYtZhc
         8nx0zDurIS/0hRjDl/nIWYzEGjlqa3KrrcnqMIISoxHsZ4W1Ho/Jy1/QHqeI/xvlSCQV
         Oyo4FVELxktyYP6kH5iAw4uiDXejaywPAc77w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132073; x=1746736873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EesNc6moi2ahl6UcCjD3bnzV1tPTsrTxS0+iWoj2t08=;
        b=KfCf+f7YTRfsIyjlkI0RKFEW1+HwvLFOLx48P+TPJfo/5PyhJ7jHXscASpZ4qU2tMB
         7RQaxxPeFNe+vO0p2A31uE4b9mcDYN10PowjyRnMVPadg7pr2laMbu8b44nUos+UZQXG
         ypZmkvKHEPTwiODUGtKwGbH0eyo/4c6vnU5XbkReKO0GH0AVAwPVpCW8hfJRPR8FFp98
         nTEQTeAUEFFL2i0JG2adbpnDgL5gKmEDF2/yUg9NQG80f28ZpQXny8ayxhio2LiI/DPg
         TLAFBZfUV0jRVSpjPmgDIzdbp0hcjPHzJnqsF4BgwbRLRbq3nF0oHEm92ELUF0ITXy4p
         3hsA==
X-Gm-Message-State: AOJu0Yxy8LAU/0MDWx0EHshptIJRsVmpAfipvywzayHA78XxhvT/8YZa
	Lb6iFFslrsR65n+2rnaYeBkBX5nWU3n5uPN5yt1isrkeFYEM+uh9cFO8T7o7JBM5DxVc/SVqEbh
	9
X-Gm-Gg: ASbGncvXUfSeasyE4ZYAOtPJr1nW9/K+ESUdThFTe+EA31AaLxF6RqmbCYrmWbKHeEx
	l5zSLL7J90v8XTZzhifNDvOWpgHnFtkREJE5CJkXbgW1LBPPQLOCftDz1MGpTyKUGjGXStb8D+9
	9yGMj5nfv8S8dry6aW3mmRz70D9h1m+sVf/2zpfK+nUf6Jm5BVScGrX9hjA5I0p271w9JrrX0uU
	lC/1bTXUm2e95ox7PVzh+zJdEh8LaDkYI2s1n7GJvVmAEEAsyrRCDMOWU6tpq7DWLVIMVEvvfIL
	U5XpKV6PHzRB2XLEQUcv/zojA+ScbVEE2HRwnp5XgXgLeJbnB48dMmSNQk0jrm7f+DFIlnvN8ce
	nCo9N7w24spbbTeiJ
X-Google-Smtp-Source: AGHT+IFAYvk9ATDi/i+fhnlptPA4JqjYMzUcvimnBL/oNMcRLAiG5prWvfDzmKJoWAkIyMUN3DnzDw==
X-Received: by 2002:a05:622a:5a1a:b0:476:5fd5:4df8 with SMTP id d75a77b69052e-48c330be2f9mr5641681cf.45.1746132073037;
        Thu, 01 May 2025 13:41:13 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.41.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:41:12 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 38/38] Update README.md wrt dynamic layer submissions
Date: Thu,  1 May 2025 16:40:14 -0400
Message-ID: <d4a35d40835895ec12b12f6945021ba9054ec339.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1465

Add a section documenting the requirements for dynamic layer
additions, since there have been some proposed by the community.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README.md | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/README.md b/README.md
index dc31161..482f0cd 100644
--- a/README.md
+++ b/README.md
@@ -91,8 +91,45 @@ are not fixes for a demonstrated build breakage against Kirkstone are unlikely
 to be accepted.  Functional changes should be submitted and merged to oe-core
 master branch first.
 
+See the following section for the requirements for submitting patches
+containing bbappends for recipes outside of oe-core using dynamic layers.
+
+Dynamic Layer Contribution Requirements
+---------------------------------------
+
+There have been community requests to support bbappends for recipes outside
+of oe-core via the use of the dynamic layers scheme.  Submissions will be
+considered based on the following criteria:
+
+- Submissions require the submitter committing to documentation of
+  themselves as maintainer of the associated bbappends/recipes in the
+  "Maintainers" section at the end of this README file.
+- Testing of recipes supported by dynamic layers bbappends is up to their
+  individual maintainer(s), and they will have any complaints about breakage
+  directed their way.
+- Dynamic layers will initially only be considered for layers from the
+  meta-openembedded repository.
+- Non-backport changes to the Rust components from oe-core will by default
+  not be accepted to support a dynamic layer bbappend if they can be carried
+  in a bbappend in the dynamic layer.  Such changes to the base mixin are
+  too likely to increase backport effort over time.
+- Straight backports of newer version recipes will generally be
+  considered out of scope.  There is some potential for negotiation if a
+  package on a LTS branch becomes impossible to compile with a newer Rust
+  version, and patching proves extremely difficult compared to a bump to
+  a newer version.  Note that version bumps that require backports of
+  other components from oe-core will default to being rejected since even
+  in a dynamic layer the potential for side effects on downstream users
+  can be very difficult to gauge.  An example of this from oe-core would
+  be newer versions of python3-cryptography, which require maturin support
+  (and a bunch of associated Python infrastructure changes) unavailable in
+  kirkstone.
+
 Maintenance
 -----------
 
 Layer maintainers:
 Scott Murray <scott.murray@konsulko.com>
+
+Dynamic layer support maintainers:
+TBD
-- 
2.49.0


