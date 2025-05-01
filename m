Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BFEC3ABAD
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 22:16:14 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web10.6717.1746137768433797361
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 15:16:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZFETIM9z;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso28082646d6.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746137767; x=1746742567; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwWNXLpEvFnsL67l4FzA4dEPoqq2ub4hnKSxsEytlpc=;
        b=ZFETIM9zcyi4I8wSuOwtt+pYkNuICcRZBdeHeIEZ2XgMm53DGfTJoWeihwMiaGazf4
         bTZNW11Dp/O332GOGjZP4bdzi6WcALSGZQwd2AgKz/g0dy0WoeZPLXKetUjmZxjB0qAf
         oFp8hVFDGKIcvTw67zeZX1p6E7ZHlSWHsuh9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746137767; x=1746742567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwWNXLpEvFnsL67l4FzA4dEPoqq2ub4hnKSxsEytlpc=;
        b=O91Q3nb41DV0viL4nRb5PdEUShWls/fewp/hQrz5+VMy09a3aDG+uGRtcOpSC81Bme
         M2k2suzaGsIpn/y0bkLMbGyyl80jjHXEsMIw+I1WnX7IRVx8iEoKBLtEXUPvmDnEVero
         /H7XUNRjEAOc4JMmgH1aENWA/drBjkO3Lkp4oyXZazCPPG9nvZweNEDShF3oMyq1w7IJ
         BOkJXDbk8Rod14efRDqDX63CiE3vS0Li8wRc3z97Hmpu05rdVqB8OtGx/IBhtZ4leanp
         L+PKoRDbtB5EX/QLKZ+w3mXoHH35bPWlxCQrH6Hgc9QpdkgKbAtfLu5oAxtZdzVZ+Rju
         Mkww==
X-Gm-Message-State: AOJu0YzdJY5FxHQ+shWzEYPo3JhZZOiFlSqP6DKGLSEJjUzUNA7EheFf
	MxgdeN2cdJzGB2alPSSvCKGhKAEowalg1LlJSgV6O4CfP+18V/rHN/QXFf2ZHdjV+2JfPxbgAvf
	e
X-Gm-Gg: ASbGncu6gGhLo9qpcR/fwNPKNPemaYdEI5t1OAb4qdusEFfF2aYqNSJ1OWOJdZ4hhKv
	T3eQMmqyVlGnS7ENzJEfHRnIxgY1q4xwQqQYBFrgvzk3a/YXHYivog5cO/R62S1On0P9EBSZKIR
	bz2lLnVANRvdqmqWDcIQ2tAYY1LPXlECZh9XX8fIzXHZwogpp8TM18wKu3D9wPoB0aH5xd0/gkR
	sm6oHMexvs2ReUhFxkilh9AZ+883191LUk+b7eHOwYKxp1fM33rIoT6NlN8ZLVqOntB7f/8SUXc
	b1OkK8zCDa4M9XAGw5YPxNmZFnm8mVCiAnrLdKwazXE2cN7S21lgouOCYX9UlnthQz7gVTDGFtI
	SgFQvag6k75Jn1aA2
X-Google-Smtp-Source: AGHT+IHnGE+LEnjCag7VBTDe88FZvC4EUJFcnMrb/KIoKilJY/gjosbwYR4DHqq4ONXh4JL12tsYqQ==
X-Received: by 2002:ad4:5cab:0:b0:6e8:c713:3220 with SMTP id 6a1803df08f44-6f5155ef9ffmr17843416d6.36.1746137766903;
        Thu, 01 May 2025 15:16:06 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3329sm9975366d6.28.2025.05.01.15.16.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:16:06 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 7/7] Update README.md wrt dynamic layer submissions
Date: Thu,  1 May 2025 18:15:43 -0400
Message-ID: <39e6082deb5d982f18ccdba5ef4124b1aaa54e85.1746137462.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746137462.git.scott.murray@konsulko.com>
References: <cover.1746137462.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 22:16:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1473

Add a section documenting the requirements for dynamic layer
additions, since there have been some proposed by the community.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README.md | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/README.md b/README.md
index c390094..a00a00e 100644
--- a/README.md
+++ b/README.md
@@ -65,8 +65,45 @@ are not fixes for a demonstrated build breakage against Scarthgap are unlikely
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


