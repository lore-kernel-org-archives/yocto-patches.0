Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEEBC61DD4
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:53 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22627.1787777927858962967
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=h/Emfi0n;
 spf=pass (domain: konsulko.com, ip: 209.85.219.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-90cc39e06bdso11121076d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777927; x=1788382727; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PgoYRivC98VWlnEnM/gDp3PQObMpW8IZE8KmclouLz4=;
        b=h/Emfi0n9uz+ndb+jCW6c8dtvYTH99Qm859Hc6pI3iGAxiFYgzzSCmvDogQo3esq82
         I7jaVjMQ0SfLM4obYl3k50vbqVIWK1hXdik8Zmqq4OXo5bUlTUfk6MJmDjs2bi77BxWv
         GTpPqK7HM2xrzeavGGmdDMVyiwK5tzwJtvHW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777927; x=1788382727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PgoYRivC98VWlnEnM/gDp3PQObMpW8IZE8KmclouLz4=;
        b=dd0m7wrdxVC19uc/ZSFrH4Vp7rZrJ7ns21RHDC9pmVM3WwWdZ8H7V0tk5yUUuQoK0H
         tWXs4hvJSdxBAwPtlS7YILcR0yUwI1pC0HUq0pT2TmknxsYACLoJSvnEOAiK0P/q0UQ6
         evkpUbNDTimM4Farf/i3QLv2AbW4UGq9Z3Jk6AhwrC+PNUXxyoliiUhj/mAPmDH9j+O0
         tMI6mFcNy0gGwVgET/x7+iZYEkBo6jhFvyZP89ravU1bRD0nx1M7HokeRMk36GiuRCzO
         M0H6htYcMk0/NJzQ+2GNUWAxmXllefmKn6wVEUW3evW0d6SujTq5PlBwKpwYwQtaelZl
         ctLA==
X-Gm-Message-State: AFuF++mJNw684DuOw6W3DuJLKz1Q7/Z8GkqSBfHLMPZFEh2ZtDHugmFy
	H1DruqUgDrY5FYkrsi7yHcg6324fl67L6yVMmKhGYRn22prMsdS7SotbI+HhcknRBszRRs280kl
	85ynH
X-Gm-Gg: AR+sD12VF5lnQr3RS/1uFcsiHDyg2yF+gNYDlvu7gXAQuhXZk0zrLYSxThSngChOfP6
	hJS8gEBtGJJlLysENKnyKBo1hla5qdydRAPL/hnqF7F1Oniu94a8Nax/9ePtryMiGfEMRoLK9Vr
	uCVHfdnsmm/zIJAM5/qe3RiD4fd1BmX4QiG7TBNJrIrq27P71jAZ04qWxjB2xTylXgwORuhx6LY
	7DIDnolA+JEco83rqO3ArSHhrcfMuNR46sgnIWQ27JOhPweJDQ8Z72X8ivYbpDGeHEyuM/kSJq/
	D8+fNCQKqwn9TzKkCKM5P2ftYDYorfXhvP+gKUnct33+Wog4YbqQM5YLE5EHOUhSDF6FSVi6r6y
	E4RvK0tWfaRIqZOgGCSkR8+t6qhTm819ozx25OpZACqbt3jVg7GhwLaBfr7dFY71EXEJ44TdEKR
	h6BmvIgMrMoxFUaHIr63N7qr2kNNp49ux/6djH85coa+2vwYWzoiPi2mloWMsElnRvAqulrK9w5
	Hhv9b5mzDbtBbNoWrrTe7WNUbJCP76VhDPriRLY8NCNCfOJu5Tfw1qx8PD0L9jX7wyz2O2Hbv7c
	GBDLtkIcOFu8GzKVXsXE2Cr1XCA=
X-Received: by 2002:a05:6214:dcb:b0:90a:7fbd:ea89 with SMTP id 6a1803df08f44-90cc790ca01mr102565966d6.1.1787777926639;
        Wed, 26 Aug 2026 13:58:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:46 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 04/15] README: fix broken URLs in meta-integrity and ccs-tools
Date: Wed, 26 Aug 2026 16:57:38 -0400
Message-ID: <f25a1bf10c3bc4565b820aa27fdc303c10f149ea.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4696

From: Sandeep J <Sandeep.J@windriver.com>

Update TOMOYO documentation URL:
   http://tomoyo.sourceforge.jp/1.8/index.html.en
to:
   https://tomoyo.sourceforge.net/1.8/index.html.en

Replace dead gmane.org permalink references with mail-archive.com
copies of the original Tizen dev mailing list messages:
   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
to:
   https://www.mail-archive.com/dev@lists.tizen.org/msg06106.html

   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
to:
   https://www.mail-archive.com/dev@lists.tizen.org/msg06100.html

Signed-off-by: Sandeep J <Sandeep.J@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-integrity/README.md     | 4 ++--
 recipes-mac/ccs-tools/README | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 92d24f8..9dcd518 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -270,5 +270,5 @@ No package manager is integrated with IMA/EVM. When updating packages,
 files will end up getting installed without correct IMA/EVM attributes
 and thus will not be usable when appraisal is turned on.
 
-[1] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
-[2] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
+[1] https://www.mail-archive.com/dev@lists.tizen.org/msg06106.html
+[2] https://www.mail-archive.com/dev@lists.tizen.org/msg06100.html
diff --git a/recipes-mac/ccs-tools/README b/recipes-mac/ccs-tools/README
index 0381814..dffb933 100644
--- a/recipes-mac/ccs-tools/README
+++ b/recipes-mac/ccs-tools/README
@@ -1,5 +1,5 @@
 Documentation:
-http://tomoyo.sourceforge.jp/1.8/index.html.en
+https://tomoyo.sourceforge.net/1.8/index.html.en
 
 
 To start via command line add:
-- 
2.55.0


